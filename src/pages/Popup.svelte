<script lang="ts">
	import browser from "webextension-polyfill"
	import { getHostname, updateRules } from "../utils"
	import { onMount } from "svelte"

	import { Icon } from "@steeze-ui/svelte-icon"
	import { ArrowPath } from "@steeze-ui/heroicons"

	let optionsForm: HTMLFormElement
	let websiteUrl: string = "<none>"

	let lastRuleUpdateDate = new Date()

	// Immediately persist options changes
	const handleDefaultConsentChange = async (event) => {
		const { options } = await browser.storage.sync.get("options")
		options.defaultConsent = event.target.checked
		browser.storage.sync.set({ options })
	}

	const handleWebsiteConsentChange = async (event) => {
		const { options } = await browser.storage.sync.get("options")
		const hostname = await getHostname()
		options.websitesConsent[hostname] = event.target.checked
		browser.storage.sync.set({ options })
	}

	const handleAllowClickChange = async (event) => {
		const { options } = await browser.storage.sync.get("options")
		options.allowClick = event.target.checked
		browser.storage.sync.set({ options })
	}

	const handleAllowCookieInjectionChange = async (event) => {
		const { options } = await browser.storage.sync.get("options")
		options.allowCookieInjection = event.target.checked
		browser.storage.sync.set({ options })
	}

	const handleUpdateRules = async (event) => {
		const { options } = await browser.storage.sync.get("options")
		lastRuleUpdateDate = await updateRules()
		options.lastRuleUpdateDate = lastRuleUpdateDate
		browser.storage.sync.set({ options })
	}

	const handleStartPickChoice = async (event) => {
		const { customRules } = await browser.storage.local.get("customRules")
		customRules.isPickingChoice = true
		customRules.count = customRules.count + 1 || 0
		browser.storage.local.set({ customRules })
	}

	const handleClearBrowsingData = async (event) => {
		await browser.runtime.sendMessage({ type: "clear_data" })
		browser.tabs.reload()
	}

	onMount(async () => {
		const { options } = await browser.storage.sync.get("options")
		const hostname = await getHostname()

		websiteUrl = hostname || "None"

		optionsForm.defaultConsent.checked = Boolean(options.defaultConsent)
		optionsForm.websiteConsent.checked = Boolean(
			options.websitesConsent[hostname]
		)
		optionsForm.allowClick.checked = Boolean(options.allowClick)
		optionsForm.allowCookieInjection.checked = Boolean(
			options.allowCookieInjection
		)
	})

	const URL_REPO = "https://github.com/andreafra/cookie-consent"
	const URL_ISSUE = "https://github.com/andreafra/cookie-consent/issues"
	const URL_HELP =
		"https://andreafra.notion.site/Cookie-Consent-Manager-7f7be95ee2c340e29b1b8c4d4e8e4d7c?pvs=4"
</script>

<header>
	<img class="icon" src="/icon.svg" alt="logo" />
	<h1>Cookie Consent<br />Manager</h1>
</header>
<div class="box">
	<div class="box-item">
		<span>Current website:</span>
		<code>{websiteUrl}</code>
	</div>
</div>
<form id="options" bind:this={optionsForm}>
	<div class="box">
		<label class="form-switch">
			<span>Opt-In (default)</span>
			<input
				type="checkbox"
				on:change={handleDefaultConsentChange}
				name="defaultConsent"
				id="defaultConsent"
			/>
			<i />
		</label>
		<label class="form-switch">
			<span>Opt-In (this website)</span>
			<input
				type="checkbox"
				on:change={handleWebsiteConsentChange}
				name="websiteConsent"
				id="websiteConsent"
			/>
			<i />
		</label>
	</div>
	<div class="box">
		<label class="form-switch">
			<span>Allow auto-click</span>
			<input
				type="checkbox"
				on:change={handleAllowClickChange}
				name="allowClick"
				id="allowClick"
			/>
			<i />
		</label>
		<label class="form-switch">
			<span>Allow cookie injection</span>
			<input
				type="checkbox"
				on:change={handleAllowCookieInjectionChange}
				name="allowCookieInjection"
				id="allowCookieInjection"
			/>
			<i />
		</label>
	</div>
</form>
<p class="caption">Reload the page after apply the new settings.</p>

<button
	id="clear-data"
	class="button button-danger"
	on:click={handleClearBrowsingData}>Clear cookies and reload</button
>
<button
	id="update-rules"
	class="button button-primary"
	on:click={handleUpdateRules}
>
	Update rules
</button>
<p class="caption">Not working? Try selecting the button manually.</p>
<button
	id="pick-elem"
	class="button button-warning"
	on:click={handleStartPickChoice}
>
	Select choice
</button>
<p class="caption">
	{#await lastRuleUpdateDate}
		Downloading rules... <Icon
			class="spin"
			src={ArrowPath}
			size="24px"
			theme="solid"
		/>
	{:then _data}
		Last updated:<br />{_data.toLocaleString()}
	{:catch error}
		Failed to update rules!
	{/await}
</p>
<p class="caption">
	<a href={URL_HELP} target="_blank" referrerpolicy="no-referrer">Help</a>
	•
	<a href={URL_REPO} target="_blank" referrerpolicy="no-referrer"
		>Source Code</a
	>
	•
	<a href={URL_ISSUE} target="_blank" referrerpolicy="no-referrer">Issue</a>
</p>

<style>
</style>
