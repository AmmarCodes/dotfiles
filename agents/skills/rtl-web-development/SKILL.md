---
name: rtl-web-development
description: |
  Complete RTL (right-to-left) web development guide for AI agents. Use this skill whenever the user mentions RTL, Arabic, Hebrew, Persian, Urdu, bidirectional text, RTL layout, RTL support, dir attribute, or multi-language UI. Also triggers on Styling, layout, or component questions involving RTL languages. Covers Tailwind CSS, plain CSS, CSS-in-JS, React/Next.js setup, Arabic typography, bidirectional text, component patterns, and icon handling.
---

# RTL Web Development for AI Agents

You are generating frontend code. Unless explicitly told otherwise, assume the project may need RTL support. Following these conventions prevents layout bugs that are expensive to fix later.

## The One Rule

**Always use CSS logical properties and RTL-safe Tailwind classes.** Never use physical direction properties (`left`, `right`, `margin-left`, `margin-right`) unless the positioning is intentionally physical and should NOT mirror.

## Quick Mapping: Tailwind

| Never use      | Always use     | Why                                 |
| -------------- | -------------- | ----------------------------------- |
| `ml-*`         | `ms-*`         | margin-left → margin-inline-start   |
| `mr-*`         | `me-*`         | margin-right → margin-inline-end    |
| `pl-*`         | `ps-*`         | padding-left → padding-inline-start |
| `pr-*`         | `pe-*`         | padding-right → padding-inline-end  |
| `left-*`       | `start-*`      | left positioning                    |
| `right-*`      | `end-*`        | right positioning                   |
| `text-left`    | `text-start`   | text alignment                      |
| `text-right`   | `text-end`     | text alignment                      |
| `border-l-*`   | `border-s-*`   | border start                        |
| `border-r-*`   | `border-e-*`   | border end                          |
| `rounded-l-*`  | `rounded-s-*`  | border-radius start                 |
| `rounded-r-*`  | `rounded-e-*`  | border-radius end                   |
| `rounded-tl-*` | `rounded-ts-*` | top-start radius                    |
| `rounded-tr-*` | `rounded-te-*` | top-end radius                      |
| `rounded-bl-*` | `rounded-bs-*` | bottom-start radius                 |
| `rounded-br-*` | `rounded-be-*` | bottom-end radius                   |

```html
<!-- Bad -->
<div class="ml-4 mr-2 pl-3 pr-1 text-left rounded-l-lg border-l-2">
  <!-- Good -->
  <div class="ms-4 me-2 ps-3 pe-1 text-start rounded-s-lg border-s-2"></div>
</div>
```

## Quick Mapping: CSS & CSS-in-JS

| Physical                         | Logical                                       |
| -------------------------------- | --------------------------------------------- |
| `margin-left` / `marginLeft`     | `margin-inline-start` / `marginInlineStart`   |
| `margin-right` / `marginRight`   | `margin-inline-end` / `marginInlineEnd`       |
| `padding-left` / `paddingLeft`   | `padding-inline-start` / `paddingInlineStart` |
| `padding-right` / `paddingRight` | `padding-inline-end` / `paddingInlineEnd`     |
| `border-left` / `borderLeft`     | `border-inline-start` / `borderInlineStart`   |
| `border-right` / `borderRight`   | `border-inline-end` / `borderInlineEnd`       |
| `left`                           | `inset-inline-start`                          |
| `right`                          | `inset-inline-end`                            |
| `width`                          | `inline-size`                                 |
| `height`                         | `block-size`                                  |
| `text-align: left`               | `text-align: start`                           |
| `text-align: right`              | `text-align: end`                             |
| `float: left`                    | `float: inline-start`                         |
| `float: right`                   | `float: inline-end`                           |

For the complete property table (border-color, border-width, border-style, min/max sizes), see `references/mappings.md`.

## The `dir` Attribute

```html
<html dir="rtl" lang="ar"></html>
<!-- OR -->
<html dir="ltr" lang="en"></html>
```

- Always set `dir` and `lang` on `<html>`, not via CSS `direction` alone
- Use `dir="auto"` on user-generated content containers where language is unknown
- For mixed-content elements, set `dir` on the element for correct word ordering

```html
<p dir="auto">مرحباً Welcome to the article about RTL design</p>
```

## Flexbox & Grid Auto-Flip

Flexbox and CSS Grid automatically respect the writing mode. Items reorder when `dir="rtl"` is set.

```css
.header {
  display: flex;
  justify-content: space-between;
} /* auto-flips */
.layout {
  display: grid;
  grid-template-columns: 220px 1fr;
} /* auto-flips */
```

**Gotcha**: `flex-direction: row-reverse` also reverses in RTL, causing a double-flip back to LTR order. Never use `row-reverse` to "fix" RTL layout -- flexbox handles direction automatically.

**Gotcha**: explicit `order` values in flexbox do NOT auto-flip. Handle manually for RTL.

## The `:dir()` Pseudo-Class

Use `:dir(rtl)` for direction-based styling. Unlike `[dir="rtl"]`, it matches elements that inherit direction from ancestors.

```css
.element:dir(rtl) {
  /* RTL styles */
}
.element:dir(ltr) {
  /* LTR styles */
}
```

Browser support: Firefox, Chrome, Safari 16.4+, Edge.

## Bidirectional Isolation: `<bdi>` and `<bdo>`

- `<bdi>` isolates user-generated content whose direction is unknown (prevents corrupting surrounding text)
- `<bdo dir="ltr">` forces LTR for phone numbers, credit cards, code that must stay LTR

```html
<p>Welcome back, <bdi>Ahmed</bdi>! Your score: <bdi>۳۵۰</bdi></p>
<bdo dir="ltr">+1 (555) 123-4567</bdo>
<bdo dir="ltr">4111-1111-1111-1111</bdo>
```

## Tailwind `rtl:` Variant

Use `rtl:` for directional icons and components that need explicit flipping:

```html
<button class="rtl:rotate-180"><ArrowLeftIcon /></button>
<div class="text-start rtl:text-right">
  <div class="ms-4 rtl:me-4 rtl:ms-0"></div>
</div>
```

Always prefer logical property utilities (`ms-*`, `me-*`, `ps-*`, `pe-*`, `start-*`, `end-*`) over `rtl:` variant hacks.

## RTL Exceptions: When NOT to Flip

**Never flip:**

- Symmetrical icons (home, search, user, settings, camera, star, heart)
- Media player controls (play, pause, forward -- tape direction, not time)
- Right-hand objects (icons per Material Design guideline)
- Data visualizations (charts, graphs, maps)
- Images, videos, code blocks -- keep original orientation
- Phone numbers, credit cards, math expressions -- stay LTR
- Music notation, clock faces

Force LTR when needed:

```html
<span dir="ltr">+1 (555) 123-4567</span>
<code dir="ltr">console.log("hello");</code>
```

## Bidirectional Icons

**Flip** (they indicate direction): arrows, breadcrumb separators, send icon, undo/redo, sort indicators.

**Don't flip** (universal/symmetrical): play/pause/stop, search, menu, close, plus, checkmark, home, settings, download/upload.

```css
[dir="rtl"] .icon-arrow-right {
  transform: scaleX(-1);
}
```

## Arabic Typography Pitfalls

See `references/arabic-typography.md` for the full guide. Critical rules:

1. **Letter-spacing: MUST be zero** on Arabic text -- letters connect, spacing breaks them
2. **Use solid colors** for Arabic text -- `rgba()` and `opacity` cause rendering artifacts between connected letters
3. **Underlines overlap Arabic dots** -- use `text-decoration-skip-ink: auto` or `box-shadow` underlines
4. **Line height** -- Arabic needs 1.6-1.8 vs Latin 1.4-1.5 (diacritics get cut off otherwise)
5. **Word-break: never `break-all`** on Arabic -- connected letters can't break mid-word
6. **No abbreviations** in Arabic -- letters must stay connected, "Sat" for "Saturday" doesn't work
7. **Provide min-width** on buttons -- Arabic translations are often shorter or longer than English

## Component RTL Patterns

See `references/component-patterns.md` for detailed examples covering:

- Button icons (icon position flips)
- Form inputs (email/URL stay LTR, name/address RTL)
- Breadcrumbs (separator auto-flips)
- Tables, tabs, cards, toasts, blockquotes, toggle switches
- Page headers (logo and actions swap)

## Search Input with Icon

```css
.c-input--search {
  background-image: url("data:image/svg+xml,...");
  background-position: right 6px center;
  padding-inline-end: 32px;
}
```

## Floats: Avoid Them

Floats do NOT auto-flip. If you must use them:

```css
.media__photo {
  float: left;
  margin-right: 16px;
}
[dir="rtl"] .media__photo {
  float: right;
  margin-right: 0;
  margin-left: 16px;
}
```

Better: use flexbox instead.

## Transform Animations in RTL

`translateX()` does NOT auto-flip. Use `scaleX(-1)` for arrow icons:

```css
.c-link:hover svg {
  transform: translateX(6px);
}
[dir="rtl"] .c-link svg {
  transform: scaleX(-1);
}
[dir="rtl"] .c-link:hover svg {
  transform: scaleX(-1) translateX(6px);
}
```

## CSS Naming Conventions

Use `start`/`end` in class names, not `left`/`right`:

```css
/* Bad */
.c-header__left {
}
.c-header__right {
}

/* Good */
.c-header__start {
}
.c-header__end {
}
```

## React / Next.js RTL Setup

```tsx
<html dir={locale === "ar" ? "rtl" : "ltr"} lang={locale}>
```

CSS-in-JS (styled-components, Emotion) requires a Stylis plugin for RTL. MUI provides `@mui/stylis-plugin-rtl`:

```tsx
import rtlPlugin from "stylis-plugin-rtl";
import { CacheProvider } from "@emotion/react";
import createCache from "@emotion/cache";

const cacheRtl = createCache({ key: "muirtl", stylisPlugins: [rtlPlugin] });
```

## Testing RTL

1. Toggle `dir="rtl"` on `<html>` in browser DevTools
2. Test every component in both LTR and RTL
3. Check for: text overflow, alignment, icon orientation, scrollbar position, truncation direction
4. Test with actual Arabic content -- not just mirrored Lorem Ipsum

## Companion: ESLint Plugin

For automated linting of physical direction properties, use [eslint-plugin-tailwind-rtl](https://github.com/AmmarCodes/eslint-plugin-tailwind-rtl). It catches RTL bugs in CI and code review that slip past generation:

```bash
npm install --save-dev eslint-plugin-tailwind-rtl
```

## References

- [RTL Styling 101 by Ahmad Shadeed](https://rtlstyling.com/posts/rtl-styling/)
- [CSS Logical Properties (MDN)](https://developer.mozilla.org/en-US/CSS/CSS_logical_properties_and_values)
- [`:dir()` pseudo-class (MDN)](https://developer.mozilla.org/en-US/CSS/:dir)
- [`<bdi>` element (MDN)](https://developer.mozilla.org/en-US/Web/HTML/Element/bdi)
- [Tailwind CSS RTL Support](https://tailwindcss.com/docs/hover-focus-and-other-states#rtl-support)
- [Tailwind Logical Properties](https://tailwindcss.com/docs/margin#logical-properties)
