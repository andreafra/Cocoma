# ![Logo](public/icon/icon-masked-96.png) Cocoma (Cookie Consent Manager)
A Web Extension to automate opt-out (or opt-in) consent to cookies.

This repository hosts the source code of Cocoma, a Cookie Consent Manager for:
- Chromium-based browsers (Google Chrome, Edge...)
- Firefox (soon unnecessary, as it will be a built-in feature)
- Safari (iOS and macOS)

Under the hood it leverages [Mozilla's Cookie Banner Rules List](https://github.com/mozilla/cookie-banner-rules-list)
to handle known cookie banners.

Many cookie banners are hiding the "Reject All" button behind additional clicks, e.g.: "Preferences" (which is illegal
in certain countries, due to new cookie policies).
A limitation of the tool is that it cannot perform multiple clicks, and the default option is to **Opt-Out**.

If you decide to **Opt-In** by default, the extension will hide many more banners automatically.

## Issues

If you have issues, you can open one here on this repository. Beware that adding support to other websites is not on me,
as _Cocoma_ depends on external lists.

## Help

See the [help page](https://andreafra.notion.site/Cookie-Consent-Manager-7f7be95ee2c340e29b1b8c4d4e8e4d7c)

## Why
Mostly because I wanted to experiment with Web Extensions and iOS/Safari, and I wasn't particularly busy.

## Doesn't [Hush](https://oblador.github.io/hush/) do the same thing?

Technically not, as Hush is a content blocker that blocks/hides the cookie banners, while this extension mimics the new Firefox,
which will actually _click_ on the Opt-In/Accept All or Opt-Out/Reject All buttons, or alternatively will set known cookies to
set your choice.
