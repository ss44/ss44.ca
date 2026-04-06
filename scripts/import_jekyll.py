import os
import re
import shutil
import argparse
from datetime import datetime
try:
    import yaml
except ImportError:
    print("Please install pyyaml: pip install pyyaml")
    exit(1)

# Regex for Jekyll liquid resize tag: ![alt]({{ 'path' | resize: '...' }}){: .class}
JEKYLL_LIQUID_IMG_REGEX = re.compile(r'!\[([^\]]*)\]\(\s*\{\{\s*[\'"]([^\'"]+)[\'"]\s*\|\s*resize:\s*[\'"]([^\'"]+)[\'"]\s*\}\}\s*\)(?:\{:\s*\.([^}]+)\})?')
# Regex to find standard markdown images: ![alt](path){: .class}
MD_IMAGE_REGEX = re.compile(r'!\[([^\]]*)\]\(([^)]+)\)(?:\{:\s*\.([^}]+)\})?')
# Regex to find HTML images: <img src="path" ...>
HTML_IMAGE_REGEX = re.compile(r'<img[^>]+src=["\']([^"\']+)["\'][^>]*>')

def parse_frontmatter(content):
    """Parses Jekyll frontmatter and returns (frontmatter_dict, markdown_body)."""
    parts = content.split('---', 2)
    if len(parts) >= 3 and parts[0].strip() == '':
        try:
            fm = yaml.safe_load(parts[1])
            body = parts[2]
            return fm, body
        except yaml.YAMLError:
            pass
    return {}, content

def build_jekyll_url(filename, fm):
    """Reconstruct the original Jekyll URL to use as canonicalUrl."""
    # Assuming standard Jekyll permalink style: /:categories/:year/:month/:day/:title/
    # or /year/month/day/title.html. Modify this based on actual Jekyll config.
    # We will provide a standard fallback: /YYYY/MM/DD/slug/
    match = re.match(r'(\d{4})-(\d{2})-(\d{2})-(.+)\.md$', filename)
    if match:
        year, month, day, slug = match.groups()
        return f"https://shindasingh.com/{year}/{month}/{day}/{slug}/"
    return f"https://shindasingh.com/{filename.replace('.md', '/')}"

def extract_slug(filename):
    match = re.match(r'(\d{4}-\d{2}-\d{2})-(.+)\.md$', filename)
    if match:
        return match.group(2)
    return filename.replace('.md', '')

def process_post(file_path, jekyll_root, hugo_root):
    filename = os.path.basename(file_path)
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    fm, body = parse_frontmatter(content)

    # Check if tagged with 'technology'
    tags = fm.get('tags', [])
    categories = fm.get('categories', [])
    
    # Handle single string tags/categories
    if isinstance(tags, str): tags = [tags]
    if isinstance(categories, str): categories = [categories]
    
    tags_lower = [t.lower() for t in tags] if tags else []
    cats_lower = [c.lower() for c in categories] if categories else []

    if 'technology' not in tags_lower and 'technology' not in cats_lower:
        return # Skip

    slug = extract_slug(filename)
    bundle_dir = os.path.join(hugo_root, 'content', 'posts', slug)
    os.makedirs(bundle_dir, exist_ok=True)

    # Add canonical URL to frontmatter
    canonical_url = build_jekyll_url(filename, fm)
    fm['canonicalUrl'] = canonical_url

    # Find and process images
    def replace_liquid_image(match):
        alt_text = match.group(1)
        img_path = match.group(2)
        resize_val = match.group(3)
        class_val = match.group(4) or ""

        # Clean up path
        clean_img_path = img_path.lstrip('/')

        src_img_full_path = os.path.join(jekyll_root, clean_img_path)
        
        if not os.path.exists(src_img_full_path):
            print(f"Warning: Image not found {src_img_full_path} for post {slug}")
            return match.group(0)

        img_filename = os.path.basename(clean_img_path)
        dest_img_full_path = os.path.join(bundle_dir, img_filename)
        shutil.copy2(src_img_full_path, dest_img_full_path)

        class_attr = f' class="{class_val.strip()}"' if class_val else ""
        return f'{{{{< img src="{img_filename}" alt="{alt_text}" resize="{resize_val}"{class_attr} >}}}}'

    def replace_image(match):
        is_html = '<img' in match.group(0)
        if is_html:
            img_path = match.group(1)
            alt_text = ""
            class_val = ""
        else:
            alt_text = match.group(1)
            img_path = match.group(2)
            class_val = match.group(3) if len(match.groups()) >= 3 else None

        # Ignore external images
        if img_path.startswith('http://') or img_path.startswith('https://'):
            return match.group(0)

        # Clean up path
        clean_img_path = img_path.split(' ')[0] # remove title if present
        clean_img_path = clean_img_path.lstrip('/')

        src_img_full_path = os.path.join(jekyll_root, clean_img_path)
        
        if not os.path.exists(src_img_full_path):
            print(f"Warning: Image not found {src_img_full_path} for post {slug}")
            return match.group(0)

        img_filename = os.path.basename(clean_img_path)
        dest_img_full_path = os.path.join(bundle_dir, img_filename)
        shutil.copy2(src_img_full_path, dest_img_full_path)

        if is_html:
            return match.group(0).replace(match.group(1), img_filename)
        else:
            title_part = ""
            if ' ' in img_path:
                title_part = ' ' + ' '.join(img_path.split(' ')[1:])
            
            md_img = f"![{alt_text}]({img_filename}{title_part})"
            if class_val:
                # Assuming standard markdown doesn't support the class naturally, 
                # we could wrap it in shortcode, but let's just emit hugo markdown attrs
                return f'{md_img}{{ class="{class_val.strip()}" }}'
            return md_img

    # Update markdown body with new image paths
    body = JEKYLL_LIQUID_IMG_REGEX.sub(replace_liquid_image, body)
    body = MD_IMAGE_REGEX.sub(replace_image, body)
    body = HTML_IMAGE_REGEX.sub(replace_image, body)

    # Write Hugo bundle index.md
    dest_file = os.path.join(bundle_dir, 'index.md')
    
    new_fm_str = yaml.dump(fm, default_flow_style=False, sort_keys=False, allow_unicode=True)
    
    with open(dest_file, 'w', encoding='utf-8') as f:
        f.write("---\n")
        f.write(new_fm_str)
        f.write("---\n")
        f.write(body)

    print(f"Imported: {slug}")

def main():
    parser = argparse.ArgumentParser(description="Import Jekyll posts into Hugo page bundles")
    parser.add_argument('jekyll_dir', help="Path to Jekyll blog root directory")
    parser.add_argument('--hugo-dir', default='.', help="Path to Hugo blog root directory (default: current directory)")
    
    args = parser.parse_args()
    
    # If the user passed the _posts directory directly instead of the root
    if os.path.basename(os.path.normpath(args.jekyll_dir)) == '_posts':
        posts_dir = args.jekyll_dir
        jekyll_root = os.path.dirname(os.path.normpath(args.jekyll_dir))
    else:
        posts_dir = os.path.join(args.jekyll_dir, '_posts')
        jekyll_root = args.jekyll_dir

    if not os.path.exists(posts_dir):
        print(f"Error: Could not find _posts directory at {posts_dir}")
        return

    for root, dirs, files in os.walk(posts_dir):
        for file in files:
            if file.endswith('.md'):
                file_path = os.path.join(root, file)
                process_post(file_path, jekyll_root, args.hugo_dir)

if __name__ == '__main__':
    main()
