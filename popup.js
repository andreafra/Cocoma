import browser from "webextension-polyfill"
import { getHostname } from "./utils"

const optionsForm = document.getElementById("options")
const websiteUrl = document.querySelector("#website-url")
const updateRules = document.querySelector("#update-rules")

// Immediately persist options changes
optionsForm.defaultConsent.addEventListener("change", async (event) => {
	const { options } = await chrome.storage.sync.get("options")
	options.defaultConsent = event.target.checked
	browser.storage.sync.set({ options })
})

optionsForm.websiteConsent.addEventListener("change", async (event) => {
	const { options } = await chrome.storage.sync.get("options")
	const hostname = await getHostname()
	options.websitesConsent[hostname] = event.target.checked
	browser.storage.sync.set({ options })
})

optionsForm.allowClick.addEventListener("change", async (event) => {
	const { options } = await chrome.storage.sync.get("options")
	options.allowClick = event.target.checked
	browser.storage.sync.set({ options })
})

optionsForm.allowCookieInjection.addEventListener("change", async (event) => {
	const { options } = await chrome.storage.sync.get("options")
	options.allowCookieInjection = event.target.checked
	browser.storage.sync.set({ options })
})

updateRules.addEventListener("click", async () => {
	await browser.runtime.sendMessage("update_rules")
})

// When the user opens the extension,
// update the form settings
window.addEventListener("load", async () => {
	const { options } = await chrome.storage.sync.get("options")
	const hostname = await getHostname()

	websiteUrl.innerHTML = hostname

	optionsForm.defaultConsent.checked = Boolean(options.defaultConsent)
	optionsForm.websiteConsent.checked = Boolean(
		options.websitesConsent[hostname]
	)
	optionsForm.allowClick.checked = Boolean(options.allowClick)
	optionsForm.allowCookieInjection.checked = Boolean(
		options.allowCookieInjection
	)
})
