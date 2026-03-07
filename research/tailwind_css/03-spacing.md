# Tailwind CSS — Spacing (Padding & Margin)

All spacing utilities use the formula: `calc(var(--spacing) * n)` where `--spacing` defaults to `0.25rem` (4px).

## Spacing Scale Reference

| Multiplier | Value | Pixels |
|-----------|-------|--------|
| `0` | `0px` | 0px |
| `px` | `1px` | 1px |
| `0.5` | `0.125rem` | 2px |
| `1` | `0.25rem` | 4px |
| `1.5` | `0.375rem` | 6px |
| `2` | `0.5rem` | 8px |
| `2.5` | `0.625rem` | 10px |
| `3` | `0.75rem` | 12px |
| `3.5` | `0.875rem` | 14px |
| `4` | `1rem` | 16px |
| `5` | `1.25rem` | 20px |
| `6` | `1.5rem` | 24px |
| `7` | `1.75rem` | 28px |
| `8` | `2rem` | 32px |
| `9` | `2.25rem` | 36px |
| `10` | `2.5rem` | 40px |
| `11` | `2.75rem` | 44px |
| `12` | `3rem` | 48px |
| `14` | `3.5rem` | 56px |
| `16` | `4rem` | 64px |
| `20` | `5rem` | 80px |
| `24` | `6rem` | 96px |
| `28` | `7rem` | 112px |
| `32` | `8rem` | 128px |
| `36` | `9rem` | 144px |
| `40` | `10rem` | 160px |
| `44` | `11rem` | 176px |
| `48` | `12rem` | 192px |
| `52` | `13rem` | 208px |
| `56` | `14rem` | 224px |
| `60` | `15rem` | 240px |
| `64` | `16rem` | 256px |
| `72` | `18rem` | 288px |
| `80` | `20rem` | 320px |
| `96` | `24rem` | 384px |

> **Any integer works.** `p-13`, `m-37`, etc. are all valid — they compute `calc(var(--spacing) * n)`.

---

## Padding

| Class Pattern | CSS Property |
|--------------|-------------|
| `p-{n}` | `padding` (all sides) |
| `px-{n}` | `padding-left` + `padding-right` |
| `py-{n}` | `padding-top` + `padding-bottom` |
| `pt-{n}` | `padding-top` |
| `pr-{n}` | `padding-right` |
| `pb-{n}` | `padding-bottom` |
| `pl-{n}` | `padding-left` |
| `ps-{n}` | `padding-inline-start` |
| `pe-{n}` | `padding-inline-end` |

### Examples
```html
<div class="p-4">           <!-- 1rem all sides -->
<div class="px-6 py-3">     <!-- 1.5rem horizontal, 0.75rem vertical -->
<div class="pt-8 pb-4">     <!-- 2rem top, 1rem bottom -->
<div class="ps-4 pe-4">     <!-- logical start/end padding (RTL-safe) -->
```

### Arbitrary Values
```html
<div class="p-[13px]">
<div class="px-[5%]">
<div class="py-(--my-padding)">   <!-- CSS variable shorthand -->
```

---

## Margin

| Class Pattern | CSS Property |
|--------------|-------------|
| `m-{n}` | `margin` (all sides) |
| `mx-{n}` | `margin-left` + `margin-right` |
| `my-{n}` | `margin-top` + `margin-bottom` |
| `mt-{n}` | `margin-top` |
| `mr-{n}` | `margin-right` |
| `mb-{n}` | `margin-bottom` |
| `ml-{n}` | `margin-left` |
| `ms-{n}` | `margin-inline-start` |
| `me-{n}` | `margin-inline-end` |

### Special Values
| Class | CSS |
|-------|-----|
| `m-auto` | `margin: auto` |
| `mx-auto` | `margin-left: auto; margin-right: auto` (centering) |
| `my-auto` | `margin-top: auto; margin-bottom: auto` |

### Negative Margins
```html
<div class="-mt-4">      <!-- margin-top: -1rem -->
<div class="-mx-6">      <!-- negative horizontal margins -->
<div class="-m-2">       <!-- negative all sides -->
```

### Auto Margin Centering
```html
<!-- Center a block element horizontally -->
<div class="mx-auto max-w-md">...</div>

<!-- Push item to the right in flex -->
<div class="flex">
  <span>Left</span>
  <span class="ml-auto">Right</span>
</div>
```

---

## Space Between (Children Spacing)

Adds margin between child elements (using `> * + *` selector):

| Class | CSS |
|-------|-----|
| `space-x-{n}` | Horizontal space between children |
| `space-y-{n}` | Vertical space between children |
| `space-x-reverse` | Reverse horizontal space direction |
| `space-y-reverse` | Reverse vertical space direction |

### Examples
```html
<!-- Vertical stack with spacing -->
<div class="space-y-4">
  <div>Item 1</div>
  <div>Item 2</div>
  <div>Item 3</div>
</div>

<!-- Horizontal row with spacing -->
<div class="flex space-x-3">
  <button>One</button>
  <button>Two</button>
  <button>Three</button>
</div>
```

> **Prefer `gap`** over `space-*` when using flexbox or grid — it's more predictable and doesn't rely on sibling selectors.

---

## Customizing the Spacing Scale

```css
@theme {
  --spacing: 0.25rem;       /* Base unit (default) */
  /* Or change to any value */
  --spacing: 4px;           /* Use pixels */
  --spacing: 0.2rem;        /* Tighter scale */
}
```
