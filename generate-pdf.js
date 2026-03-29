const puppeteer = require('puppeteer');
const handler = require('serve-handler');
const http = require('http');
const path = require('path');

(async () => {
  // Start a local server serving the 'public' directory
  const server = http.createServer((request, response) => {
    return handler(request, response, {
      public: path.join(__dirname, 'public')
    });
  });

  server.listen(3000, async () => {
    console.log('Running local server at http://localhost:3000');
    
    try {
      // Launch headless browser
      const browser = await puppeteer.launch({
        args: ['--no-sandbox', '--disable-setuid-sandbox']
      });
      const page = await browser.newPage();
      
      // Load the page via the local server
      const url = 'http://localhost:3000/resume/';
      await page.goto(url, { waitUntil: 'networkidle0' });
      
      // Generate PDF and save to public/resume.pdf
      await page.pdf({
        path: path.join(__dirname, 'public', 'resume.pdf'),
        format: 'Letter',
        printBackground: true,
        margin: { top: '0', right: '0', bottom: '0.4in', left: '0' },
        displayHeaderFooter: true,
        headerTemplate: '<div></div>',
        footerTemplate: '<div style="width: 100%; font-size: 8pt; padding-right: 0.6in; text-align: right; font-family: sans-serif; color: #777;">Page <span class="pageNumber"></span> of <span class="totalPages"></span></div>'
      });

      await browser.close();
      console.log('PDF generated at public/resume.pdf');
    } catch (error) {
      console.error('Error generating PDF:', error);
      process.exitCode = 1;
    } finally {
      // Stop the server
      server.close();
    }
  });
})();
