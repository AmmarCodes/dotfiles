# Arabic Typography Pitfalls

## 1. Letter-Spacing: MUST Be Zero

Arabic letters connect to form words. `letter-spacing` breaks connections.

```css
/* Never do this to Arabic text */
.arabic-text {
  letter-spacing: 1px;
}

/* Always reset */
[lang="ar"] {
  letter-spacing: 0;
}
```

## 2. Text Transparency: Use Solid Colors

`rgba()` or `opacity` on Arabic text causes rendering artifacts -- uneven color between connected letters.

```css
/* Can cause rendering issues */
.text-muted {
  color: rgba(0, 0, 0, 0.6);
}

/* Safer for Arabic */
[lang="ar"] .text-muted {
  color: #666;
}
```

## 3. Underlined Links: Overlaps Arabic Dots

Default `text-decoration: underline` overlaps the dots of Arabic letters (ب, ت, ث, etc.).

```css
/* Solution 1: text-decoration-skip-ink (preferred) */
a {
  text-decoration-skip-ink: auto;
}

/* Solution 2: Custom underline with box-shadow (fallback) */
a {
  text-decoration: none;
  box-shadow: inset 0 -1px 0 0 currentColor;
}
```

## 4. Line Height

Arabic needs more line height than Latin (~1.6-1.8 vs 1.4-1.5). Arabic diacritics (harakat) get cut off with low line-height.

```css
[lang="ar"] {
  line-height: 1.8;
}
[lang="en"] {
  line-height: 1.5;
}
```

## 5. Word Size Differences

Arabic translations are often shorter or longer than English. Always add `min-width` to buttons and UI elements that contain translatable text.

```css
.button {
  min-width: 80px;
}
```

## 6. No word-break on Arabic

Arabic words cannot be broken mid-word -- letters are connected. `word-break: break-all` destroys readability.

```css
[lang="ar"] {
  word-break: normal;
  overflow-wrap: break-word;
}
```

## 7. No Abbreviations

Arabic cannot abbreviate words -- letters must stay connected. "Sat" for "Saturday" doesn't work. Always use full words.

## 8. Text Truncation with dir="auto"

Truncated mixed-content text can cut from the wrong side. Use `dir="auto"` on the element.

```html
<p dir="auto" class="truncate">أهلاً وسهلاً بكم في المقال</p>
```

## 9. Bad Fonts Are Worse in Arabic

Bold + bad Arabic font = unreadable. Test Arabic fonts at all weights. Don't just pick system default Arabic.

## 10. Arabic Font Stacks

```css
font-family:
  "Noto Naskh Arabic", "Scheherazade New", "Traditional Arabic", serif;
font-family: "Cairo", "Tajawal", "Almarai", sans-serif;
```

## 11. Arabic Numerals

Arabic has two numeral systems. Be consistent -- don't mix them.

| Type                   | Digits              |
| ---------------------- | ------------------- |
| Arabic (Western)       | 0 1 2 3 4 5 6 7 8 9 |
| Hindi (Eastern Arabic) | ٠ ١ ٢ ٣ ٤ ٥ ٦ ٧ ٨ ٩ |
