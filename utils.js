import browser from "webextension-polyfill"

export async function getHostname() {
	const [tab] = await browser.tabs.query({
		active: true,
		lastFocusedWindow: true,
	})
	const url = new URL(tab.url)
	return url.hostname
}

const MOZILLA_GITHUB_RULES =
	"https://raw.githubusercontent.com/mozilla/cookie-banner-rules-list/main/cookie-banner-rules-list.json"

export async function updateRules() {
	const data = await fetch(MOZILLA_GITHUB_RULES, {
		method: "GET",
	})
	if (data.ok) {
		const rules = await data.json()
		console.log(rules)
	} else {
		throw "Failed to fetch latest rules."
	}
}
