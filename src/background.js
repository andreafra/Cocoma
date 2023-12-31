import browser from "webextension-polyfill"
import cookieRules from "../public/cookie-banner-rules-list.json"
import { getHostname, shareStatsWithNativeApp, updateRules } from "./utils"

const defaultOptions = {
	defaultConsent: false,
	websitesConsent: {},
	allowClick: true,
	allowCookieInjection: true,
}

const defaultStats = {
	bannersClosed: 0,
}

const defaultCustomRules = {
	isPickingChoice: false,
	websites: {},
}

browser.runtime.onInstalled.addListener(async (details) => {
	console.log("Extension installed:", details)

	const data = await browser.storage.sync.get(["options", "stats"])

	if (!data.options) {
		console.log("Initializing settings...")
		browser.storage.sync.set({ options: defaultOptions })
	}

	if (!data.stats) {
		console.log("Initializing stats...")
		browser.storage.sync.set({ stats: defaultStats })
	}

	console.log("Initializing default local rules")
	browser.storage.local.set({ customRules: defaultCustomRules })
})

// On install, fetch the newest cookie rules from Mozilla's repository
// Set an expiration date that is checked periodically, on expire fetch again
// Alternatively, the user can fetch again the data.

// @ts-ignore
browser.runtime.onMessage.addListener(messageHandler)

function messageHandler(request, sender, sendResponse) {
	;(async () => {
		const url = await getHostname()
		switch (request.type) {
			case "get_rules":
				const rules = getCookieData(url)
				console.log("Rules", rules)
				sendResponse(rules)
				break
			case "get_consent":
				const consentPrefs = await getConsentPrefs(url)
				sendResponse(consentPrefs)
				break
			case "clear_data":
				console.log("Clearing browsing data and reloading...")
				const cookies = await browser.cookies.getAll({})
				for (const cookie of cookies) {
					await browser.cookies.remove({
						url: `https://${cookie.domain}`,
						name: cookie.name,
					})
				}
				sendResponse()
				break
			case "share_stats":
				shareStatsWithNativeApp()
				sendResponse()
				break
			default:
				console.log("Unsupported message: ", request)
		}
	})()
	return true // needed for async sendResponse, else it returns undefined
}

let rules = cookieRules.data

// Fetch the local, updated rules, if any
;(async () => {
	const { rules: newRules } = await browser.storage.local.get("rules")
	if (newRules) rules = newRules
})()

const getGenericRules = () => rules.filter((rule) => rule.domains.length === 0)
const getSpecificRules = () => rules.filter((rule) => rule.domains.length > 0)

/**
 * Confronts an input url against the list of known cookie banners.
 * @param {string} url the current page hostname
 * @returns Promise containing an object with the valid rules
 */
function getCookieData(url) {
	const startTime = new Date().getTime()
	// Get all rules with domains that match the top hostname
	let filteredRules = getSpecificRules().filter((rule) =>
		rule.domains.some((domain) =>
			url.match(new RegExp(`^(.*\\.)?${domain}$`), "i")
		)
	)

	const elapsedTime = new Date().getTime() - startTime
	// Try use the generic rules if no match is found
	if (filteredRules.length === 0) {
		filteredRules = getGenericRules()
	}

	return {
		rules: filteredRules,
		elapsedTime,
	}
}

async function getConsentPrefs(url) {
	const { options } = await browser.storage.sync.get("options")
	const {
		defaultConsent,
		websitesConsent,
		allowClick,
		allowCookieInjection,
	} = options

	return {
		allowClick,
		allowCookieInjection,
		defaultConsent,
		websiteConsent: websitesConsent[url],
	}
}
