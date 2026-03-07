# Tailwind CSS — Backgrounds & Borders

## Background Color

See [06-colors.md](06-colors.md) for the full color palette.

```html
<div class="bg-white">
<div class="bg-gray-100">
<div class="bg-blue-500">
<div class="bg-black/75">        <!-- with opacity -->
<div class="bg-[#1da1f2]">      <!-- arbitrary -->
<div class="bg-[--my-bg]">      <!-- CSS variable -->
```

## Background Gradient

| Class | CSS |
|-------|-----|
| `bg-linear-to-t` | `background-image: linear-gradient(to top, ...)` |
| `bg-linear-to-tr` | `background-image: linear-gradient(to top right, ...)` |
| `bg-linear-to-r` | `background-image: linear-gradient(to right, ...)` |
| `bg-linear-to-br` | `background-image: linear-gradient(to bottom right, ...)` |
| `bg-linear-to-b` | `background-image: linear-gradient(to bottom, ...)` |
| `bg-linear-to-bl` | `background-image: linear-gradient(to bottom left, ...)` |
| `bg-linear-to-l` | `background-image: linear-gradient(to left, ...)` |
| `bg-linear-to-tl` | `background-image: linear-gradient(to top left, ...)` |
| `bg-none` | `background-image: none` |

### Gradient Color Stops
```html
<div class="bg-linear-to-r from-cyan-500 to-blue-500">
<div class="bg-linear-to-r from-indigo-500 via-purple-500 to-pink-500">
<div class="from-blue-500/50">  <!-- with opacity -->
```

## Background Size

| Class | CSS |
|-------|-----|
| `bg-auto` | `background-size: auto` |
| `bg-cover` | `background-size: cover` |
| `bg-contain` | `background-size: contain` |

## Background Position

| Class | CSS |
|-------|-----|
| `bg-bottom` | `background-position: bottom` |
| `bg-center` | `background-position: center` |
| `bg-left` | `background-position: left` |
| `bg-left-bottom` | `background-position: left bottom` |
| `bg-left-top` | `background-position: left top` |
| `bg-right` | `background-position: right` |
| `bg-right-bottom` | `background-position: right bottom` |
| `bg-right-top` | `background-position: right top` |
| `bg-top` | `background-position: top` |

## Background Repeat

| Class | CSS |
|-------|-----|
| `bg-repeat` | `background-repeat: repeat` |
| `bg-no-repeat` | `background-repeat: no-repeat` |
| `bg-repeat-x` | `background-repeat: repeat-x` |
| `bg-repeat-y` | `background-repeat: repeat-y` |
| `bg-repeat-round` | `background-repeat: round` |
| `bg-repeat-space` | `background-repeat: space` |

## Background Attachment

| Class | CSS |
|-------|-----|
| `bg-fixed` | `background-attachment: fixed` |
| `bg-local` | `background-attachment: local` |
| `bg-scroll` | `background-attachment: scroll` |

## Background Clip

| Class | CSS |
|-------|-----|
| `bg-clip-border` | `background-clip: border-box` |
| `bg-clip-padding` | `background-clip: padding-box` |
| `bg-clip-content` | `background-clip: content-box` |
| `bg-clip-text` | `background-clip: text` |

### Gradient text example
```html
<span class="bg-linear-to-r from-pink-500 to-violet-500 bg-clip-text text-transparent">
  Gradient text
</span>
```

---

## Border Radius

| Class | CSS | Value |
|-------|-----|-------|
| `rounded-none` | `border-radius: 0` | 0 |
| `rounded-xs` | `border-radius: var(--radius-xs)` | 0.125rem (2px) |
| `rounded-sm` | `border-radius: var(--radius-sm)` | 0.25rem (4px) |
| `rounded` | `border-radius: var(--radius)` | 0.25rem (4px) |
| `rounded-md` | `border-radius: var(--radius-md)` | 0.375rem (6px) |
| `rounded-lg` | `border-radius: var(--radius-lg)` | 0.5rem (8px) |
| `rounded-xl` | `border-radius: var(--radius-xl)` | 0.75rem (12px) |
| `rounded-2xl` | `border-radius: var(--radius-2xl)` | 1rem (16px) |
| `rounded-3xl` | `border-radius: var(--radius-3xl)` | 1.5rem (24px) |
| `rounded-4xl` | `border-radius: var(--radius-4xl)` | 2rem (32px) |
| `rounded-full` | `border-radius: 9999px` | Pill/circle |

### Per-Side Border Radius
```html
<div class="rounded-t-lg">     <!-- top-left + top-right -->
<div class="rounded-r-lg">     <!-- top-right + bottom-right -->
<div class="rounded-b-lg">     <!-- bottom-left + bottom-right -->
<div class="rounded-l-lg">     <!-- top-left + bottom-left -->
<div class="rounded-tl-lg">    <!-- top-left only -->
<div class="rounded-tr-lg">    <!-- top-right only -->
<div class="rounded-bl-lg">    <!-- bottom-left only -->
<div class="rounded-br-lg">    <!-- bottom-right only -->
<div class="rounded-ss-lg">    <!-- start-start (logical) -->
<div class="rounded-se-lg">    <!-- start-end (logical) -->
<div class="rounded-es-lg">    <!-- end-start (logical) -->
<div class="rounded-ee-lg">    <!-- end-end (logical) -->
```

---

## Border Width

| Class | CSS |
|-------|-----|
| `border` | `border-width: 1px` |
| `border-0` | `border-width: 0px` |
| `border-2` | `border-width: 2px` |
| `border-4` | `border-width: 4px` |
| `border-8` | `border-width: 8px` |

### Per-Side Border Width
```html
<div class="border-t">        <!-- border-top: 1px -->
<div class="border-r-2">      <!-- border-right: 2px -->
<div class="border-b-4">      <!-- border-bottom: 4px -->
<div class="border-l-0">      <!-- border-left: 0px -->
<div class="border-x-2">      <!-- left + right: 2px -->
<div class="border-y">        <!-- top + bottom: 1px -->
<div class="border-s-2">      <!-- inline-start: 2px (logical) -->
<div class="border-e-2">      <!-- inline-end: 2px (logical) -->
```

## Border Color

```html
<div class="border border-gray-300">
<div class="border border-red-500">
<div class="border-t border-t-blue-200">
<div class="border border-black/10">  <!-- with opacity -->
```

## Border Style

| Class | CSS |
|-------|-----|
| `border-solid` | `border-style: solid` |
| `border-dashed` | `border-style: dashed` |
| `border-dotted` | `border-style: dotted` |
| `border-double` | `border-style: double` |
| `border-hidden` | `border-style: hidden` |
| `border-none` | `border-style: none` |

---

## Divide (Borders Between Children)

```html
<div class="divide-y">           <!-- Horizontal dividers -->
  <div>Item 1</div>
  <div>Item 2</div>
</div>

<div class="flex divide-x">      <!-- Vertical dividers -->
  <div>Left</div>
  <div>Right</div>
</div>
```

| Class | CSS |
|-------|-----|
| `divide-x` | `border-left-width: 1px` (on siblings) |
| `divide-x-2` | `border-left-width: 2px` |
| `divide-y` | `border-top-width: 1px` (on siblings) |
| `divide-y-2` | `border-top-width: 2px` |
| `divide-{color}` | Divider color |
| `divide-solid` | Divider style solid |
| `divide-dashed` | Divider style dashed |
| `divide-dotted` | Divider style dotted |

---

## Outline

| Class | CSS |
|-------|-----|
| `outline` | `outline-style: solid; outline-width: 1px` |
| `outline-2` | `outline-width: 2px` |
| `outline-4` | `outline-width: 4px` |
| `outline-none` | `outline: 2px solid transparent; outline-offset: 2px` |
| `outline-dashed` | `outline-style: dashed` |
| `outline-dotted` | `outline-style: dotted` |
| `outline-double` | `outline-style: double` |
| `outline-offset-0` | `outline-offset: 0px` |
| `outline-offset-1` | `outline-offset: 1px` |
| `outline-offset-2` | `outline-offset: 2px` |
| `outline-offset-4` | `outline-offset: 4px` |
| `outline-offset-8` | `outline-offset: 8px` |

```html
<button class="outline-2 outline-offset-2 outline-blue-500">
```

---

## Ring (Box Shadow Rings)

Ring creates a box-shadow-based "outline" without affecting layout:

| Class | CSS |
|-------|-----|
| `ring` | Ring with default width (1px) |
| `ring-0` | No ring |
| `ring-1` | 1px ring |
| `ring-2` | 2px ring |
| `ring-4` | 4px ring |
| `ring-8` | 8px ring |
| `ring-inset` | Inset ring |
| `ring-{color}` | Ring color |

```html
<button class="ring-2 ring-blue-500">
<div class="ring-1 ring-black/5">
<input class="ring-2 ring-inset ring-gray-300">
```

### Inset Ring
| Class | CSS |
|-------|-----|
| `inset-ring` | Inset ring with default width (1px) |
| `inset-ring-2` | 2px inset ring |
| `inset-ring-{color}` | Inset ring color |

---

## Theme Customization

```css
@theme {
  --radius-sm: 0.125rem;
  --radius-md: 0.25rem;
  --radius-lg: 0.375rem;
  --radius-xl: 0.5rem;
}
```
