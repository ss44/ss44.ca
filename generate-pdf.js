const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const pdfPath = path.join(__dirname, 'public', 'resume.pdf');
const typstPath = path.join(__dirname, 'cobalt-cv', 'main.typ');
const yamlPath = path.join(__dirname, 'data', 'resume.yml');
const fontsDir = path.join(__dirname, 'fonts');

function getMTime(filePath) {
  try {
    return fs.statSync(filePath).mtimeMs;
  } catch (e) {
    return 0; // File doesn't exist
  }
}

const pdfMTime = getMTime(pdfPath);
const typstMTime = getMTime(typstPath);
const yamlMTime = getMTime(yamlPath);

// Define fonts to download
const fonts = [
  { file: 'NotoSans-Regular.ttf', url: 'https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/hinted/ttf/NotoSans-Regular.ttf' },
  { file: 'NotoSans-Medium.ttf', url: 'https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/hinted/ttf/NotoSans-Medium.ttf' },
  { file: 'NotoSans-Bold.ttf', url: 'https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/hinted/ttf/NotoSans-Bold.ttf' },
  { file: 'NotoSans-Italic.ttf', url: 'https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSans/hinted/ttf/NotoSans-Italic.ttf' },
  { file: 'NotoSerif-Regular.ttf', url: 'https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSerif/hinted/ttf/NotoSerif-Regular.ttf' },
  { file: 'NotoSerif-Medium.ttf', url: 'https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSerif/hinted/ttf/NotoSerif-Medium.ttf' },
  { file: 'NotoSerif-Bold.ttf', url: 'https://github.com/notofonts/notofonts.github.io/raw/main/fonts/NotoSerif/hinted/ttf/NotoSerif-Bold.ttf' }
];

if (pdfMTime < typstMTime || pdfMTime < yamlMTime) {
  console.log('Changes detected. Setting up fonts and compiling PDF...');
  
  if (!fs.existsSync(fontsDir)) {
    fs.mkdirSync(fontsDir, { recursive: true });
  }

  // Download missing fonts
  for (const font of fonts) {
    const fontPath = path.join(fontsDir, font.file);
    if (!fs.existsSync(fontPath)) {
      console.log(`Downloading ${font.file}...`);
      execSync(`curl -sL "${font.url}" -o "${fontPath}"`);
    }
  }

  if (!fs.existsSync(path.join(__dirname, 'public'))) {
    fs.mkdirSync(path.join(__dirname, 'public'), { recursive: true });
  }

  try {
    // We use npx typst so Netlify doesn't need it pre-installed globally
    execSync(`npx --yes typst compile --root . --font-path fonts "${typstPath}" "${pdfPath}"`, { stdio: 'inherit' });
    console.log('PDF generated at public/resume.pdf');
  } catch (error) {
    console.error('Error generating PDF with Typst:', error.message);
    process.exitCode = 1;
  }
} else {
  console.log('No changes in resume files detected. Skipping PDF generation.');
}
