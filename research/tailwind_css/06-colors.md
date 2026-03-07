# Tailwind CSS — Colors

## Color Utilities

All colors can be used with these utility prefixes:

| Prefix | CSS Property |
|--------|-------------|
| `bg-{color}` | `background-color` |
| `text-{color}` | `color` |
| `border-{color}` | `border-color` |
| `outline-{color}` | `outline-color` |
| `decoration-{color}` | `text-decoration-color` |
| `shadow-{color}` | Box shadow color |
| `inset-shadow-{color}` | Inset box shadow color |
| `ring-{color}` | Ring shadow color |
| `inset-ring-{color}` | Inset ring shadow color |
| `accent-{color}` | Form control accent color |
| `caret-{color}` | Text input caret color |
| `fill-{color}` | SVG fill color |
| `stroke-{color}` | SVG stroke color |
| `placeholder-{color}` | Placeholder text color (via `placeholder:text-{color}`) |

## Syntax

```
{utility}-{color}-{shade}
```

Examples:
```html
<div class="bg-blue-500">
<p class="text-gray-900">
<div class="border-red-300">
```

## Opacity Modifier

Append `/{opacity}` to any color:

```html
<div class="bg-black/75">       <!-- 75% opacity black -->
<div class="bg-sky-500/50">     <!-- 50% opacity sky-500 -->
<div class="bg-white/10">       <!-- 10% opacity white -->
<div class="bg-pink-500/[71.37%]">  <!-- arbitrary opacity -->
<div class="bg-cyan-400/(--my-alpha)">  <!-- CSS variable opacity -->
```

## Special Color Values

| Class | CSS |
|-------|-----|
| `{util}-inherit` | `inherit` |
| `{util}-current` | `currentColor` |
| `{util}-transparent` | `transparent` |
| `{util}-black` | `#000` |
| `{util}-white` | `#fff` |

## Default Color Palette

All colors have shades: **50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950**

Colors use `oklch()` format. Names available:

### Chromatic Colors
| Name | Description/Hue |
|------|----------------|
| `red` | Red |
| `orange` | Orange |
| `amber` | Amber/warm yellow |
| `yellow` | Yellow |
| `lime` | Lime green |
| `green` | Green |
| `emerald` | Emerald green |
| `teal` | Teal |
| `cyan` | Cyan |
| `sky` | Sky blue |
| `blue` | Blue |
| `indigo` | Indigo |
| `violet` | Violet |
| `purple` | Purple |
| `fuchsia` | Fuchsia/magenta |
| `pink` | Pink |
| `rose` | Rose/red-pink |

### Neutral Colors
| Name | Description |
|------|------------|
| `slate` | Blue-gray |
| `gray` | Neutral with slight blue |
| `zinc` | Neutral with slight purple |
| `neutral` | True neutral (0 chroma) |
| `stone` | Warm neutral |
| `taupe` | Warm brownish neutral |
| `mauve` | Slightly purple neutral |
| `mist` | Slightly teal/cool neutral |
| `olive` | Slightly green neutral |

## Color Scale Quick Reference

Shade meanings (approximate):
- **50** — Lightest tint (backgrounds, subtle fills)
- **100** — Very light
- **200** — Light (borders on light backgrounds)
- **300** — Light-medium (borders, disabled states)
- **400** — Medium (icons, secondary text on dark)
- **500** — Base/medium (primary brand color, icons)
- **600** — Medium-dark (hover states on 500)
- **700** — Dark (text on light backgrounds)
- **800** — Very dark (headings)
- **900** — Near-black (primary text)
- **950** — Darkest (near-black backgrounds)

## CSS Variables

Colors are available as CSS variables:

```css
var(--color-blue-500)
var(--color-gray-900)
var(--color-red-200)
```

### Using in CSS
```css
@layer components {
  .brand-link {
    color: var(--color-blue-500);
    &:hover {
      color: var(--color-blue-800);
    }
  }
}
```

### Adjusting opacity in CSS with `--alpha()`
```css
.overlay {
  background-color: --alpha(var(--color-gray-950) / 10%);
}
```

## Customizing Colors

### Add Custom Colors
```css
@theme {
  --color-brand: #3b82f6;
  --color-midnight: #121063;
  --color-tahiti: #3ab7bf;
}
```
→ Generates `bg-brand`, `text-midnight`, `fill-tahiti`, etc.

### Override Default Colors
```css
@theme {
  --color-gray-50: oklch(0.984 0.003 247.858);
  --color-gray-100: oklch(0.968 0.007 247.896);
  /* ... */
}
```

### Disable Default Colors
```css
@theme {
  --color-lime-*: initial;       /* Remove lime */
  --color-fuchsia-*: initial;    /* Remove fuchsia */
}
```

### Replace Entire Palette
```css
@theme {
  --color-*: initial;            /* Remove ALL defaults */
  --color-white: #fff;
  --color-primary: #3f3cbb;
  --color-secondary: #78dcca;
}
```

### Reference Other Variables
```css
:root {
  --acme-canvas-color: oklch(0.967 0.003 264.542);
}
[data-theme="dark"] {
  --acme-canvas-color: oklch(0.21 0.034 264.665);
}
@theme inline {
  --color-canvas: var(--acme-canvas-color);
}
```

## Dark Mode Colors

```html
<div class="bg-white dark:bg-gray-900">
  <h3 class="text-gray-900 dark:text-white">Title</h3>
  <p class="text-gray-500 dark:text-gray-400">Description</p>
</div>
```

## Common Color Patterns

```html
<!-- Primary button -->
<button class="bg-blue-500 text-white hover:bg-blue-600">

<!-- Danger/error -->
<span class="text-red-600 bg-red-50 border border-red-200">

<!-- Success -->
<span class="text-green-700 bg-green-50 border border-green-200">

<!-- Warning -->
<span class="text-amber-700 bg-amber-50 border border-amber-200">

<!-- Muted/secondary text -->
<p class="text-gray-500 dark:text-gray-400">

<!-- Subtle background -->
<div class="bg-gray-50 dark:bg-gray-900">

<!-- Card -->
<div class="bg-white dark:bg-gray-800 shadow-md">
```
