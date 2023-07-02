import browser from "webextension-polyfill"
import Cookies from "js-cookie"
;(async () => main())()

async function main() {
	// On page load, send the current URL to the background worker and
	// retrieve rules
	const { rules, elapsedTime } = await browser.runtime.sendMessage({
		type: "get_rules",
		payload: {
			url: window.location.hostname,
		},
	})
	console.log("Rules:", rules)
	console.log(`Found matching cookie rules in ${elapsedTime} ms`)
	if (!checkForExistingCookies(rules)) {
		startCookieManager(rules)
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
		}
		if (currentTry >= maxTries) {
			clearInterval(loop)
			console.warn("Failed to get presences.")
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
		const presence = document.querySelector(rule.click.presence)
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
		console.log(`Rule ID: ${rule.id}`)
		if (rule.click) {
			clickConsentButton(rule, consent)
			console.log(`Clicked consent button: optIn=${consent}`)
		} else if (rule.cookies) {
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
		const consentButton = document.querySelector(
			rule.click[consent ? "optIn" : "optOut"]
		)
		if (consentButton) {
			consentButton.click()
		} else {
			console.error("Failed to select optIn/optOut button")
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
