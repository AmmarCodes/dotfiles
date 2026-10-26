# Complete RTL CSS Mapping Tables

## Tailwind CSS: Full Class Mapping

### Margin

| Physical | Logical | CSS Property        |
| -------- | ------- | ------------------- |
| `ml-*`   | `ms-*`  | margin-inline-start |
| `mr-*`   | `me-*`  | margin-inline-end   |

### Padding

| Physical | Logical | CSS Property         |
| -------- | ------- | -------------------- |
| `pl-*`   | `ps-*`  | padding-inline-start |
| `pr-*`   | `pe-*`  | padding-inline-end   |

### Position (Inset)

| Physical  | Logical   | CSS Property       |
| --------- | --------- | ------------------ |
| `left-*`  | `start-*` | inset-inline-start |
| `right-*` | `end-*`   | inset-inline-end   |

### Text Alignment

| Physical     | Logical      | CSS Property      |
| ------------ | ------------ | ----------------- |
| `text-left`  | `text-start` | text-align: start |
| `text-right` | `text-end`   | text-align: end   |

### Border

| Physical     | Logical      | CSS Property                   |
| ------------ | ------------ | ------------------------------ |
| `border-l`   | `border-s`   | border-inline-start            |
| `border-r`   | `border-e`   | border-inline-end              |
| `border-l-*` | `border-s-*` | border-inline-start-width etc. |
| `border-r-*` | `border-e-*` | border-inline-end-width etc.   |

### Border Radius

| Physical       | Logical        | CSS Property               |
| -------------- | -------------- | -------------------------- |
| `rounded-l-*`  | `rounded-s-*`  | border-start-start-radius  |
| `rounded-r-*`  | `rounded-e-*`  | border-start-end-radius    |
| `rounded-tl-*` | `rounded-ts-*` | border-top-start-radius    |
| `rounded-tr-*` | `rounded-te-*` | border-top-end-radius      |
| `rounded-bl-*` | `rounded-bs-*` | border-bottom-start-radius |
| `rounded-br-*` | `rounded-be-*` | border-bottom-end-radius   |

---

## CSS Properties: Full Mapping

### Margin

| Physical        | Logical               |
| --------------- | --------------------- |
| `margin-left`   | `margin-inline-start` |
| `margin-right`  | `margin-inline-end`   |
| `margin-top`    | `margin-block-start`  |
| `margin-bottom` | `margin-block-end`    |

### Padding

| Physical         | Logical                |
| ---------------- | ---------------------- |
| `padding-left`   | `padding-inline-start` |
| `padding-right`  | `padding-inline-end`   |
| `padding-top`    | `padding-block-start`  |
| `padding-bottom` | `padding-block-end`    |

### Border

| Physical             | Logical                     |
| -------------------- | --------------------------- |
| `border-left`        | `border-inline-start`       |
| `border-right`       | `border-inline-end`         |
| `border-left-color`  | `border-inline-start-color` |
| `border-right-color` | `border-inline-end-color`   |
| `border-left-width`  | `border-inline-start-width` |
| `border-right-width` | `border-inline-end-width`   |
| `border-left-style`  | `border-inline-start-style` |
| `border-right-style` | `border-inline-end-style`   |

### Border Radius

| Physical                     | Logical                     |
| ---------------------------- | --------------------------- |
| `border-top-left-radius`     | `border-start-start-radius` |
| `border-top-right-radius`    | `border-start-end-radius`   |
| `border-bottom-left-radius`  | `border-end-start-radius`   |
| `border-bottom-right-radius` | `border-end-end-radius`     |

### Position

| Physical | Logical              |
| -------- | -------------------- |
| `left`   | `inset-inline-start` |
| `right`  | `inset-inline-end`   |
| `top`    | `inset-block-start`  |
| `bottom` | `inset-block-end`    |

### Size

| Physical     | Logical           |
| ------------ | ----------------- |
| `width`      | `inline-size`     |
| `height`     | `block-size`      |
| `min-width`  | `min-inline-size` |
| `max-width`  | `max-inline-size` |
| `min-height` | `min-block-size`  |
| `max-height` | `max-block-size`  |

### Value-Level Keywords

| Property     | Physical Value  | Logical Value                |
| ------------ | --------------- | ---------------------------- |
| `text-align` | `left`, `right` | `start`, `end`               |
| `float`      | `left`, `right` | `inline-start`, `inline-end` |
| `clear`      | `left`, `right` | `inline-start`, `inline-end` |

---

## CSS-in-JS: Full Mapping (camelCase)

### Margin

| Physical      | Logical             |
| ------------- | ------------------- |
| `marginLeft`  | `marginInlineStart` |
| `marginRight` | `marginInlineEnd`   |

### Padding

| Physical       | Logical              |
| -------------- | -------------------- |
| `paddingLeft`  | `paddingInlineStart` |
| `paddingRight` | `paddingInlineEnd`   |

### Border

| Physical           | Logical                  |
| ------------------ | ------------------------ |
| `borderLeft`       | `borderInlineStart`      |
| `borderRight`      | `borderInlineEnd`        |
| `borderLeftColor`  | `borderInlineStartColor` |
| `borderRightColor` | `borderInlineEndColor`   |
| `borderLeftWidth`  | `borderInlineStartWidth` |
| `borderRightWidth` | `borderInlineEndWidth`   |
| `borderLeftStyle`  | `borderInlineStartStyle` |
| `borderRightStyle` | `borderInlineEndStyle`   |

### Position

| Physical | Logical            |
| -------- | ------------------ |
| `left`   | `insetInlineStart` |
| `right`  | `insetInlineEnd`   |

### Size

| Physical    | Logical         |
| ----------- | --------------- |
| `width`     | `inlineSize`    |
| `height`    | `blockSize`     |
| `minWidth`  | `minInlineSize` |
| `maxWidth`  | `maxInlineSize` |
| `minHeight` | `minBlockSize`  |
| `maxHeight` | `maxBlockSize`  |
