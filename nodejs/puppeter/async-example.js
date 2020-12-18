// more docs: https://github.com/puppeteer/puppeteer/blob/v1.4.0/docs/api.md
// https://github.com/puppeteer/puppeteer/tree/v5.5.0
// How to install: npm i puppeteer
const puppeteer = require('puppeteer');

const withBrowser = async (fn) => {
	const browser = await puppeteer.launch();
	try {
		return await fn(browser);
	} finally {
		await browser.close();
	}
}

const screenshot = withBrowser(async (browser) => {
	const page = await browser.newPage();
	await page.goto('https://www.github.com');
	return await page.screenshot({ path: 'github.png' });
});
