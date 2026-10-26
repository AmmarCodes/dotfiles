---
name: nested-border-radius
description: >
  When writing or reviewing CSS for nested rounded-corner elements (cards inside cards, buttons inside panels, modals with inner content areas, etc.), ALWAYS use this skill. It provides the correct nested border-radius formula to ensure visually harmonious inner radii that don't look awkward or misaligned. Use whenever the user mentions border-radius, rounded corners, nested cards, padding inside rounded containers, or any UI element that sits inside another rounded element. This applies to Tailwind, CSS modules, inline styles, design systems, and component libraries.
---

# Nested Border Radius Skill

## The Rule

When an element with a border-radius contains another element that also has a border-radius, the inner radius must be smaller than the outer radius by exactly the distance (padding/gap) between them.

**Formula:**

```
outerRadius = innerRadius + distance
```

Or solving for the inner radius:

```
innerRadius = outerRadius - distance
```

Where `distance` is the padding, margin, or gap between the outer edge and the inner element's edge.

## Why This Matters

Without this formula, nested rounded corners look visually "off" — the inner curve either bulges past the outer curve or leaves an uneven gap. Proper nesting creates clean, professional-looking containment.

## Examples

**CSS Example:**

```css
.outer {
  border-radius: 24px;
  padding: 8px;
}

.inner {
  /* 24px - 8px = 16px */
  border-radius: 16px;
}
```

**Tailwind Example:**

```html
<!-- Outer: rounded-3xl (24px), padding: p-2 (8px) -->
<!-- Inner: rounded-2xl (16px) -->
<div class="rounded-3xl p-2 bg-gray-100">
  <div class="rounded-2xl bg-white p-4">Content</div>
</div>
```

## Quick Reference Table

| Outer Radius | Distance | Inner Radius |
| ------------ | -------- | ------------ |
| 12px         | 4px      | 8px          |
| 16px         | 4px      | 12px         |
| 20px         | 4px      | 16px         |
| 24px         | 8px      | 16px         |
| 32px         | 8px      | 24px         |
| 48px         | 16px     | 32px         |

## Edge Cases

- If `outerRadius - distance` is negative or zero, the inner element should have `border-radius: 0` (sharp corners are fine inside generous rounding).
- This formula assumes uniform padding on all sides. If padding is asymmetric (e.g., more padding on top), consider using the smallest padding value for the radius calculation, or use `calc()`.
- For partial rounding (e.g., `border-radius: 12px 4px`), apply the formula to each corresponding corner independently.

## Action

When generating or reviewing CSS/Tailwind/styled-components for nested rounded elements, ALWAYS verify the inner border-radius against this formula. If the user hasn't specified inner radii, suggest the correct values based on the outer radius and padding.
