# Component RTL Patterns

## Button Icons

Icon position flips between LTR and RTL. Use logical properties so it works automatically:

```css
.button {
  display: inline-flex;
}
.button .icon {
  margin-inline-end: 0.5rem;
}
```

## Form Inputs

- **Keep LTR-aligned**: email, phone, URL, credit card, number inputs
- **RTL-align**: name, address, textarea in Arabic

```css
.input--email {
  direction: ltr;
  text-align: left;
}
.input--name[lang="ar"] {
  direction: rtl;
  text-align: right;
}
```

Placeholder exception: if placeholder is in Arabic, align right. Once user types, align according to content type.

## Breadcrumbs

Separator auto-flips with logical properties:

```html
<nav class="breadcrumbs">
  <a href="/">Home</a>
  <span class="breadcrumbs__sep" aria-hidden="true">/</span>
  <a href="/blog">Blog</a>
</nav>
```

## Tables

Tables flip entirely in RTL. Column order reverses.

## Tabs

Icons move from left-of-label (LTR) to right-of-label (RTL).

## Cards (Horizontal)

Image and text order swaps in RTL.

## Toasts / Notifications

Close button and icon positions mirror.

## Blockquotes

Quote decoration icon mirrors.

## Toggle Switches

Toggle direction mirrors -- conceptually like a checkbox, which flips.

## Page Header

Start section (logo) and end section (actions, user menu) swap positions.
