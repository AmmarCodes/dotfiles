# RTL Web Development Skills

AI agent skill for RTL (right-to-left) web development. Teaches agents to write RTL-safe CSS and Tailwind code, handle bidirectional text, manage Arabic typography, and build components that work in both LTR and RTL.

## Install

```bash
npx skills add AmmarCodes/rtl-web-development-skill
```

## What It Covers

- **Tailwind CSS**: `ml-4` → `ms-4`, `text-left` → `text-start`, `border-l` → `border-s`, etc.
- **Plain CSS & CSS-in-JS**: `margin-left` → `margin-inline-start`, `width` → `inline-size`, etc.
- **Value-level keywords**: `text-align: left` → `text-align: start`, `float: right` → `float: inline-end`
- **`dir` attribute**: `dir="rtl"`, `dir="auto"`, `:dir()` pseudo-class
- **Flexbox/Grid auto-flip**: What flips automatically, what doesn't
- **Bidirectional text**: `<bdi>`, `<bdo>`, mixed Arabic-English content
- **Arabic typography**: Letter-spacing, line-height, font stacks, numeral systems
- **Component patterns**: Buttons, forms, breadcrumbs, tables, tabs, cards, toasts
- **Icon handling**: Which icons flip, which don't
- **RTL exceptions**: When NOT to mirror (symmetrical icons, media, code blocks)

## Companion: ESLint Plugin

For automated linting of physical direction properties, use [eslint-plugin-tailwind-rtl](https://github.com/AmmarCodes/eslint-plugin-tailwind-rtl). It catches RTL bugs in CI and code review:

| Tool              | When it helps    | What it does                             |
| ----------------- | ---------------- | ---------------------------------------- |
| **This skill**    | Code generation  | Prevents RTL bugs before they're written |
| **ESLint Plugin** | Code review / CI | Catches RTL regressions in existing code |

## Contents

```
SKILL.md                              # Main skill instructions
references/
  mappings.md                         # Complete physical → logical mapping tables
  arabic-typography.md                # Arabic typography pitfalls and fixes
  component-patterns.md               # RTL patterns for buttons, forms, etc.
```

## Credits

- Many of the rules here are reused from [RTL Styling 101](https://rtlstyling.com/posts/rtl-styling/) by [@shadeed](https://github.com/shadeed).

## License

MIT
