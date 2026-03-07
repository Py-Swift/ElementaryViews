# Tailwind CSS — Typography

## Font Size

| Class | Font Size | Default Line Height |
|-------|-----------|-------------------|
| `text-xs` | `0.75rem` (12px) | `1rem` (16px) |
| `text-sm` | `0.875rem` (14px) | `1.25rem` (20px) |
| `text-base` | `1rem` (16px) | `1.5rem` (24px) |
| `text-lg` | `1.125rem` (18px) | `1.75rem` (28px) |
| `text-xl` | `1.25rem` (20px) | `1.75rem` (28px) |
| `text-2xl` | `1.5rem` (24px) | `2rem` (32px) |
| `text-3xl` | `1.875rem` (30px) | `2.25rem` (36px) |
| `text-4xl` | `2.25rem` (36px) | `2.5rem` (40px) |
| `text-5xl` | `3rem` (48px) | `1` |
| `text-6xl` | `3.75rem` (60px) | `1` |
| `text-7xl` | `4.5rem` (72px) | `1` |
| `text-8xl` | `6rem` (96px) | `1` |
| `text-9xl` | `8rem` (128px) | `1` |

### Font Size with Custom Line Height

```html
<p class="text-sm/6">     <!-- 14px font, 1.5rem line-height -->
<p class="text-sm/7">     <!-- 14px font, 1.75rem line-height -->
<p class="text-lg/8">     <!-- 18px font, 2rem line-height -->
<p class="text-base/loose"> <!-- with named line-height -->
```

### Arbitrary Font Sizes
```html
<p class="text-[14px]">
<p class="text-[clamp(1rem,2vw,2rem)]">
```

---

## Font Weight

| Class | CSS | Value |
|-------|-----|-------|
| `font-thin` | `font-weight: 100` | 100 |
| `font-extralight` | `font-weight: 200` | 200 |
| `font-light` | `font-weight: 300` | 300 |
| `font-normal` | `font-weight: 400` | 400 |
| `font-medium` | `font-weight: 500` | 500 |
| `font-semibold` | `font-weight: 600` | 600 |
| `font-bold` | `font-weight: 700` | 700 |
| `font-extrabold` | `font-weight: 800` | 800 |
| `font-black` | `font-weight: 900` | 900 |

---

## Font Family

| Class | CSS |
|-------|-----|
| `font-sans` | `font-family: var(--font-sans)` → `ui-sans-serif, system-ui, sans-serif, "Apple Color Emoji", "Segoe UI Emoji"` |
| `font-serif` | `font-family: var(--font-serif)` → `ui-serif, Georgia, Cambria, "Times New Roman", Times, serif` |
| `font-mono` | `font-family: var(--font-mono)` → `ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace` |

### Custom Font Family
```css
@theme {
  --font-display: "Satoshi", "Inter", sans-serif;
}
```
```html
<h1 class="font-display">...</h1>
```

---

## Text Color

Uses the color palette with `text-{color}-{shade}`:

| Class | CSS |
|-------|-----|
| `text-inherit` | `color: inherit` |
| `text-current` | `color: currentColor` |
| `text-transparent` | `color: transparent` |
| `text-black` | `color: var(--color-black)` → `#000` |
| `text-white` | `color: var(--color-white)` → `#fff` |
| `text-gray-500` | `color: var(--color-gray-500)` |
| `text-red-600` | `color: var(--color-red-600)` |
| `text-blue-700` | `color: var(--color-blue-700)` |

### Opacity Modifier
```html
<p class="text-black/75">    <!-- 75% opacity black text -->
<p class="text-blue-500/50">  <!-- 50% opacity blue text -->
```

---

## Text Alignment

| Class | CSS |
|-------|-----|
| `text-left` | `text-align: left` |
| `text-center` | `text-align: center` |
| `text-right` | `text-align: right` |
| `text-justify` | `text-align: justify` |
| `text-start` | `text-align: start` |
| `text-end` | `text-align: end` |

---

## Line Height

| Class | CSS |
|-------|-----|
| `leading-none` | `line-height: 1` |
| `leading-tight` | `line-height: 1.25` |
| `leading-snug` | `line-height: 1.375` |
| `leading-normal` | `line-height: 1.5` |
| `leading-relaxed` | `line-height: 1.625` |
| `leading-loose` | `line-height: 2` |
| `leading-{n}` | `line-height: calc(var(--spacing) * n)` |

---

## Letter Spacing

| Class | CSS |
|-------|-----|
| `tracking-tighter` | `letter-spacing: -0.05em` |
| `tracking-tight` | `letter-spacing: -0.025em` |
| `tracking-normal` | `letter-spacing: 0em` |
| `tracking-wide` | `letter-spacing: 0.025em` |
| `tracking-wider` | `letter-spacing: 0.05em` |
| `tracking-widest` | `letter-spacing: 0.1em` |

---

## Text Transform

| Class | CSS |
|-------|-----|
| `uppercase` | `text-transform: uppercase` |
| `lowercase` | `text-transform: lowercase` |
| `capitalize` | `text-transform: capitalize` |
| `normal-case` | `text-transform: none` |

---

## Text Decoration

| Class | CSS |
|-------|-----|
| `underline` | `text-decoration-line: underline` |
| `overline` | `text-decoration-line: overline` |
| `line-through` | `text-decoration-line: line-through` |
| `no-underline` | `text-decoration-line: none` |

### Decoration Style
| Class | CSS |
|-------|-----|
| `decoration-solid` | `text-decoration-style: solid` |
| `decoration-double` | `text-decoration-style: double` |
| `decoration-dotted` | `text-decoration-style: dotted` |
| `decoration-dashed` | `text-decoration-style: dashed` |
| `decoration-wavy` | `text-decoration-style: wavy` |

### Decoration Thickness
| Class | CSS |
|-------|-----|
| `decoration-auto` | `text-decoration-thickness: auto` |
| `decoration-from-font` | `text-decoration-thickness: from-font` |
| `decoration-0` | `text-decoration-thickness: 0px` |
| `decoration-1` | `text-decoration-thickness: 1px` |
| `decoration-2` | `text-decoration-thickness: 2px` |
| `decoration-4` | `text-decoration-thickness: 4px` |
| `decoration-8` | `text-decoration-thickness: 8px` |

### Decoration Color
```html
<a class="underline decoration-blue-500">
<a class="underline decoration-red-500/50">
```

### Underline Offset
| Class | CSS |
|-------|-----|
| `underline-offset-auto` | `text-underline-offset: auto` |
| `underline-offset-0` | `text-underline-offset: 0px` |
| `underline-offset-1` | `text-underline-offset: 1px` |
| `underline-offset-2` | `text-underline-offset: 2px` |
| `underline-offset-4` | `text-underline-offset: 4px` |
| `underline-offset-8` | `text-underline-offset: 8px` |

---

## Text Overflow & Wrapping

| Class | CSS |
|-------|-----|
| `truncate` | `overflow: hidden; text-overflow: ellipsis; white-space: nowrap` |
| `text-ellipsis` | `text-overflow: ellipsis` |
| `text-clip` | `text-overflow: clip` |
| `text-wrap` | `text-wrap: wrap` |
| `text-nowrap` | `text-wrap: nowrap` |
| `text-balance` | `text-wrap: balance` |
| `text-pretty` | `text-wrap: pretty` |
| `break-normal` | `overflow-wrap: normal; word-break: normal` |
| `break-words` | `overflow-wrap: break-word` |
| `break-all` | `word-break: break-all` |
| `break-keep` | `word-break: keep-all` |

### Line Clamping
```html
<p class="line-clamp-1">   <!-- Truncate to 1 line -->
<p class="line-clamp-2">   <!-- Truncate to 2 lines -->
<p class="line-clamp-3">   <!-- Truncate to 3 lines -->
<p class="line-clamp-none"> <!-- Remove clamping -->
```

---

## Font Style

| Class | CSS |
|-------|-----|
| `italic` | `font-style: italic` |
| `not-italic` | `font-style: normal` |

---

## Whitespace

| Class | CSS |
|-------|-----|
| `whitespace-normal` | `white-space: normal` |
| `whitespace-nowrap` | `white-space: nowrap` |
| `whitespace-pre` | `white-space: pre` |
| `whitespace-pre-line` | `white-space: pre-line` |
| `whitespace-pre-wrap` | `white-space: pre-wrap` |
| `whitespace-break-spaces` | `white-space: break-spaces` |

---

## List Style

| Class | CSS |
|-------|-----|
| `list-none` | `list-style-type: none` |
| `list-disc` | `list-style-type: disc` |
| `list-decimal` | `list-style-type: decimal` |
| `list-inside` | `list-style-position: inside` |
| `list-outside` | `list-style-position: outside` |

---

## Vertical Align

| Class | CSS |
|-------|-----|
| `align-baseline` | `vertical-align: baseline` |
| `align-top` | `vertical-align: top` |
| `align-middle` | `vertical-align: middle` |
| `align-bottom` | `vertical-align: bottom` |
| `align-text-top` | `vertical-align: text-top` |
| `align-text-bottom` | `vertical-align: text-bottom` |
| `align-sub` | `vertical-align: sub` |
| `align-super` | `vertical-align: super` |

---

## Theme Customization

```css
@theme {
  --text-tiny: 0.625rem;          /* Custom font size */
  --font-weight-hairline: 50;     /* Custom weight */
  --font-display: "Inter", sans-serif; /* Custom family */
}
```
