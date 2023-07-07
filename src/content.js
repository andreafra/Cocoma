import browser from "webextension-polyfill"
import Cookies from "js-cookie"

async function main() {
	// On page load, send the current URL to the background worker and
	// retrieve rules
	const { rules, elapsedTime } = await browser.runtime.sendMessage({
		type: "get_rules",
		payload: {
			url: window.location.hostname,
		},
	})
	console.log("Matching rules found:", rules)
	if (!checkForExistingCookies(rules)) {
		startCookieManager(rules)
	} else {
		console.log(`Found matching cookie rules in ${elapsedTime} ms`)
	}
}

function checkForExistingCookies(rules) {
	for (const rule in rules) {
		if (!rule.cookies) return false
		if (rule.cookies.optIn)
			return rule.cookes.optIn.some(
				({ name, value }) => Cookies.get(name) === value
			)
		if (rule.cookies.optOut)
			return rule.cookes.optOut.some(
				({ name, value }) => Cookies.get(name) === value
			)
	}
	return false
}

function startCookieManager(rules) {
	const maxTries = 10
	let currentTry = 0
	const loop = setInterval(() => {
		const _rules = filterRulesByPresences(rules)
		if (_rules.length > 0) {
			clearInterval(loop)
			handleCookieConsent(_rules)
			return
		}
		if (currentTry >= maxTries) {
			clearInterval(loop)
			console.warn("Failed to get presences.")
			return
		}
		currentTry++
	}, 500)
}

/**
 * Filters rules keeping only those who match a presence element in the DOM
 * @param {*} rules An iterable collection of rules
 * @returns
 */
function filterRulesByPresences(rules) {
	return rules.reduce((acc, rule) => {
		const presence =
			document.querySelector(rule.click.presence) ??
			document.querySelector(rule.click.optIn)
		if (presence) acc.push(rule)
		return acc
	}, [])
}

async function handleCookieConsent(rules) {
	const { defaultConsent, websiteConsent, allowClick, allowCookieInjection } =
		await browser.runtime.sendMessage({
			type: "get_consent",
		})

	const consent = websiteConsent ?? defaultConsent
	console.log(`Applying consent (${consent})...`)
	for (const rule of rules) {
		console.log(`Using rule id=${rule.id}`)
		if (allowClick && rule.click) {
			clickConsentButton(rule, consent)
			console.log(`Clicked consent button: optIn=${consent}`)
		} else if (allowCookieInjection && rule.cookies) {
			setConsentCookies(rule, consent)
			console.log(`Set consent cookie: optIn=${consent}`)
		} else {
			console.log(
				"Failed to click the consent button and set the cookies."
			)
		}
	}

	function clickConsentButton(rule, consent) {
		console.log("Trying to click the consent button.")
		const consentChoice = consent ? "optIn" : "optOut"
		const consentButton = document.querySelector(rule.click[consentChoice])
		if (consentButton) {
			consentButton.click()
		} else {
			console.error(`Failed to click ${consentChoice} button.`)
		}
	}

	function setConsentCookies(rule, consent) {
		console.log("Trying to set consent cookies.")
		const cookies = consent ? rule.cookies?.optIn : rule.cookies?.optOut
		if (cookies) {
			for (const cookie in cookies) {
				Cookies.set(cookie.name, cookie.value)
				console.log(
					`Setting cookie ${cookie.name} to value ${cookie.value}`
				)
			}
		}
	}
}

browser.storage.local.onChanged.addListener(async (change) => {
	const { customRules } = await browser.storage.local.get("customRules")
	if (customRules.isPickingChoice) {
		console.log("Entering picking mode...")
		document.addEventListener("click", handlePickChoice, false)
	}
})

function handlePickChoice(event) {
	// prevent default action
	event.preventDefault()
	const target = event.target
	let container = target
	// navigate the dom to find the top-level container
	for (
		;
		container.parentNode != document.body;
		container = container.parentNode
	) {}
	console.log(target)
	console.log(container)
	// remove the listener
	document.removeEventListener("click", handlePickChoice)
}
;(async () => main())()
