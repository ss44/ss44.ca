const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const pdfPath = path.join(__dirname, 'public', 'resume.pdf');
const typstPath = path.join(__dirname, 'cobalt-cv', 'main.typ');
const yamlPath = path.join(__dirname, 'data', 'resume.yml');

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

if (pdfMTime < typstMTime || pdfMTime < yamlMTime) {
  console.log('Changes detected. Compiling PDF using Typst...');
  
  // Ensure the public directory exists
  if (!fs.existsSync(path.join(__dirname, 'public'))) {
    fs.mkdirSync(path.join(__dirname, 'public'), { recursive: true });
  }

  try {
    execSync(`typst compile --root . "${typstPath}" "${pdfPath}"`, { stdio: 'inherit' });
    console.log('PDF generated at public/resume.pdf');
  } catch (error) {
    console.error('Error generating PDF with Typst:', error.message);
    process.exitCode = 1;
  }
} else {
  console.log('No changes in resume files detected. Skipping PDF generation.');
}
