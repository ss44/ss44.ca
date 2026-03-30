# ss44.ca Personal Portfolio & Resume

This is the personal portfolio website of Shajinder Singh Padda.

I'm a Senior Full Stack Web Developer with 20+ years of experience turning complex problems into scalable, secure web applications. My core expertise lies in **Ruby**, **JavaScript** (*TypeScript, React, VueJS*), **PHP**, and SQL (**PostgreSQL, MySQL**). Ultimately, my real passion is building resilient systems that users love and developers enjoy maintaining.

When I'm not writing production code, I'm exploring new languages, tinkering with my homelab, messing around in Davinci Resolve, or binge-watching woodworking videos on YouTube.

## Build Commands

To build and launch the site:
```bash
# Install dependencies
npm install

# Build the PDF resume from the YAML data
node generate-pdf.js

# Launch the Hugo local development server
hugo server -D
```

To build for production:
```bash
# Generate PDF and build Hugo site
npm install
hugo build --gc --minify
node generate-pdf.js

To deploy and deploy to netlify
```
netlify build
netlify deploy
```