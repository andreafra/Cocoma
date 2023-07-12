import browser from "webextension-polyfill"

export async function getCurrentTab() {
	const currentWindow = await browser.windows.getCurrent()
	const [tab] = await browser.tabs.query({
		active: true,
		windowId: currentWindow.id,
	})

	return tab
}

export async function getHostname() {
	const tab = await getCurrentTab()

	const url = new URL(tab.url)
	return url.hostname
}

export async function updateStatsWithSuccess() {
	const { stats } = await browser.storage.sync.get("stats")
	stats.bannersClosed += 1
	browser.storage.sync.set({ stats })
	browser.runtime.sendMessage({ type: "share_stats" })
}

export async function shareStatsWithNativeApp() {
	const { stats } = await browser.storage.sync.get("stats")
	console.log("Sharing stats...")
	const res = await browser.runtime.sendNativeMessage("_", stats)
	console.log(
		res["success"]
			? "Successfully shared stats with app."
			: "Failed to share stats with app."
	)
	console.log(res)
}

const MOZILLA_GITHUB_RULES =
	"https://raw.githubusercontent.com/mozilla/cookie-banner-rules-list/main/cookie-banner-rules-list.json"

export async function updateRules() {
	console.log("Updating rules...")
	const data = await fetch(MOZILLA_GITHUB_RULES, {
		method: "GET",
	})
	if (data.ok) {
		const { data: rules } = await data.json()
		console.log("New rules:", rules)
		browser.storage.local.set({ rules })
		return new Date()
	} else {
		throw "Failed to fetch latest rules."
	}
}
