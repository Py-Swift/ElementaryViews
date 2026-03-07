# Tailwind CSS — Effects, Transitions & Transforms

## Box Shadow

| Class | CSS |
|-------|-----|
| `shadow-2xs` | `box-shadow: var(--shadow-2xs)` → `0 1px rgba(0,0,0,0.05)` |
| `shadow-xs` | `box-shadow: var(--shadow-xs)` → `0 1px 2px rgba(0,0,0,0.05)` |
| `shadow-sm` | `box-shadow: var(--shadow-sm)` → `0 1px 3px, 0 1px 2px` |
| `shadow` | `box-shadow: var(--shadow)` → `0 1px 3px, 0 1px 2px` |
| `shadow-md` | `box-shadow: var(--shadow-md)` → `0 4px 6px, 0 2px 4px` |
| `shadow-lg` | `box-shadow: var(--shadow-lg)` → `0 10px 15px, 0 4px 6px` |
| `shadow-xl` | `box-shadow: var(--shadow-xl)` → `0 20px 25px, 0 8px 10px` |
| `shadow-2xl` | `box-shadow: var(--shadow-2xl)` → `0 25px 50px` |
| `shadow-none` | `box-shadow: none` |

### Shadow Color
```html
<div class="shadow-lg shadow-blue-500/50">
<div class="shadow-xl shadow-black/10">
```

### Inset Shadow

| Class | CSS |
|-------|-----|
| `inset-shadow-2xs` | Inset version of shadow-2xs |
| `inset-shadow-xs` | Inset version of shadow-xs |
| `inset-shadow-sm` | Inset version of shadow-sm |
| `inset-shadow` | Inset version of shadow |
| `inset-shadow-none` | No inset shadow |

```html
<div class="inset-shadow-sm inset-shadow-gray-500/20">
```

---

## Opacity

| Class | CSS |
|-------|-----|
| `opacity-0` | `opacity: 0` |
| `opacity-5` | `opacity: 0.05` |
| `opacity-10` | `opacity: 0.1` |
| `opacity-15` | `opacity: 0.15` |
| `opacity-20` | `opacity: 0.2` |
| `opacity-25` | `opacity: 0.25` |
| `opacity-30` | `opacity: 0.3` |
| `opacity-35` | `opacity: 0.35` |
| `opacity-40` | `opacity: 0.4` |
| `opacity-45` | `opacity: 0.45` |
| `opacity-50` | `opacity: 0.5` |
| `opacity-55` | `opacity: 0.55` |
| `opacity-60` | `opacity: 0.6` |
| `opacity-65` | `opacity: 0.65` |
| `opacity-70` | `opacity: 0.7` |
| `opacity-75` | `opacity: 0.75` |
| `opacity-80` | `opacity: 0.8` |
| `opacity-85` | `opacity: 0.85` |
| `opacity-90` | `opacity: 0.9` |
| `opacity-95` | `opacity: 0.95` |
| `opacity-100` | `opacity: 1` |

Any integer 0–100 works: `opacity-37` → `opacity: 0.37`.

---

## Transitions

### Transition Property

| Class | CSS |
|-------|-----|
| `transition` | `transition-property: color, background-color, border-color, text-decoration-color, fill, stroke, opacity, box-shadow, transform, translate, scale, rotate, filter, backdrop-filter` |
| `transition-all` | `transition-property: all` |
| `transition-colors` | `transition-property: color, background-color, border-color, text-decoration-color, fill, stroke` |
| `transition-opacity` | `transition-property: opacity` |
| `transition-shadow` | `transition-property: box-shadow` |
| `transition-transform` | `transition-property: transform, translate, scale, rotate` |
| `transition-none` | `transition-property: none` |

Default: `duration-150` + `ease-in-out` (when using `transition`).

### Transition Duration

| Class | CSS |
|-------|-----|
| `duration-0` | `transition-duration: 0s` |
| `duration-75` | `transition-duration: 75ms` |
| `duration-100` | `transition-duration: 100ms` |
| `duration-150` | `transition-duration: 150ms` |
| `duration-200` | `transition-duration: 200ms` |
| `duration-300` | `transition-duration: 300ms` |
| `duration-500` | `transition-duration: 500ms` |
| `duration-700` | `transition-duration: 700ms` |
| `duration-1000` | `transition-duration: 1000ms` |

### Transition Timing Function

| Class | CSS |
|-------|-----|
| `ease-linear` | `transition-timing-function: linear` |
| `ease-in` | `transition-timing-function: cubic-bezier(0.4, 0, 1, 1)` |
| `ease-out` | `transition-timing-function: cubic-bezier(0, 0, 0.2, 1)` |
| `ease-in-out` | `transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1)` |

### Transition Delay

| Class | CSS |
|-------|-----|
| `delay-0` | `transition-delay: 0s` |
| `delay-75` | `transition-delay: 75ms` |
| `delay-100` | `transition-delay: 100ms` |
| `delay-150` | `transition-delay: 150ms` |
| `delay-200` | `transition-delay: 200ms` |
| `delay-300` | `transition-delay: 300ms` |
| `delay-500` | `transition-delay: 500ms` |
| `delay-700` | `transition-delay: 700ms` |
| `delay-1000` | `transition-delay: 1000ms` |

### Transition Examples
```html
<!-- Smooth hover color change -->
<button class="bg-blue-500 transition-colors duration-200 hover:bg-blue-600">

<!-- Scale on hover -->
<div class="transition-transform duration-300 hover:scale-105">

<!-- Fade in/out -->
<div class="opacity-0 transition-opacity duration-500 group-hover:opacity-100">
```

---

## Animations

| Class | CSS |
|-------|-----|
| `animate-spin` | Continuous 360° rotation (1s linear infinite) |
| `animate-ping` | Pulse/ping effect (scale + fade, 1s) |
| `animate-pulse` | Gentle opacity pulse (2s) |
| `animate-bounce` | Bouncing effect |
| `animate-none` | No animation |

```html
<!-- Loading spinner -->
<svg class="animate-spin h-5 w-5">...</svg>

<!-- Notification ping -->
<span class="relative flex size-3">
  <span class="animate-ping absolute inline-flex size-full rounded-full bg-sky-400 opacity-75"></span>
  <span class="relative inline-flex size-3 rounded-full bg-sky-500"></span>
</span>
```

---

## Transforms

### Scale

| Class | CSS |
|-------|-----|
| `scale-0` | `scale: 0` |
| `scale-50` | `scale: 0.5` |
| `scale-75` | `scale: 0.75` |
| `scale-90` | `scale: 0.9` |
| `scale-95` | `scale: 0.95` |
| `scale-100` | `scale: 1` |
| `scale-105` | `scale: 1.05` |
| `scale-110` | `scale: 1.1` |
| `scale-125` | `scale: 1.25` |
| `scale-150` | `scale: 1.5` |
| `scale-200` | `scale: 2` |
| `scale-x-{n}` | Horizontal only |
| `scale-y-{n}` | Vertical only |

### Rotate

| Class | CSS |
|-------|-----|
| `rotate-0` | `rotate: 0deg` |
| `rotate-1` | `rotate: 1deg` |
| `rotate-2` | `rotate: 2deg` |
| `rotate-3` | `rotate: 3deg` |
| `rotate-6` | `rotate: 6deg` |
| `rotate-12` | `rotate: 12deg` |
| `rotate-45` | `rotate: 45deg` |
| `rotate-90` | `rotate: 90deg` |
| `rotate-180` | `rotate: 180deg` |
| `-rotate-45` | `rotate: calc(45deg * -1)` |
| `-rotate-90` | `rotate: calc(90deg * -1)` |

### Translate

| Class | CSS |
|-------|-----|
| `translate-x-{n}` | `translate: calc(var(--spacing) * n) var(--tw-translate-y)` |
| `translate-y-{n}` | `translate: var(--tw-translate-x) calc(var(--spacing) * n)` |
| `translate-x-full` | `translate: 100% ...` |
| `translate-x-1/2` | `translate: 50% ...` |
| `-translate-x-{n}` | Negative translate |
| `-translate-y-1/2` | `translate: ... -50%` |

### Skew

| Class | CSS |
|-------|-----|
| `skew-x-{n}` | `transform: skewX(ndeg)` |
| `skew-y-{n}` | `transform: skewY(ndeg)` |
| `-skew-x-{n}` | Negative skew |

### Transform Origin

| Class | CSS |
|-------|-----|
| `origin-center` | `transform-origin: center` |
| `origin-top` | `transform-origin: top` |
| `origin-top-right` | `transform-origin: top right` |
| `origin-right` | `transform-origin: right` |
| `origin-bottom-right` | `transform-origin: bottom right` |
| `origin-bottom` | `transform-origin: bottom` |
| `origin-bottom-left` | `transform-origin: bottom left` |
| `origin-left` | `transform-origin: left` |
| `origin-top-left` | `transform-origin: top left` |

---

## Filters

### Blur

| Class | CSS |
|-------|-----|
| `blur-none` | `filter: blur(0)` |
| `blur-sm` | `filter: blur(4px)` |
| `blur` | `filter: blur(8px)` |
| `blur-md` | `filter: blur(12px)` |
| `blur-lg` | `filter: blur(16px)` |
| `blur-xl` | `filter: blur(24px)` |
| `blur-2xl` | `filter: blur(40px)` |
| `blur-3xl` | `filter: blur(64px)` |

### Backdrop Blur

Same scale with `backdrop-blur-*` prefix:
```html
<div class="backdrop-blur-sm bg-white/30">  <!-- Frosted glass -->
```

### Other Filters

| Class | CSS |
|-------|-----|
| `brightness-{n}` | `filter: brightness(n%)` (0, 50, 75, 90, 95, 100, 105, 110, 125, 150, 200) |
| `contrast-{n}` | `filter: contrast(n%)` |
| `grayscale` | `filter: grayscale(100%)` |
| `grayscale-0` | `filter: grayscale(0)` |
| `hue-rotate-{n}` | `filter: hue-rotate(ndeg)` (0, 15, 30, 60, 90, 180) |
| `invert` | `filter: invert(100%)` |
| `invert-0` | `filter: invert(0)` |
| `saturate-{n}` | `filter: saturate(n%)` (0, 50, 100, 150, 200) |
| `sepia` | `filter: sepia(100%)` |
| `sepia-0` | `filter: sepia(0)` |
| `drop-shadow-*` | `filter: drop-shadow(...)` |

All filters have corresponding `backdrop-*` variants for backdrop effects.

---

## Mix Blend Mode

| Class | CSS |
|-------|-----|
| `mix-blend-normal` | `mix-blend-mode: normal` |
| `mix-blend-multiply` | `mix-blend-mode: multiply` |
| `mix-blend-screen` | `mix-blend-mode: screen` |
| `mix-blend-overlay` | `mix-blend-mode: overlay` |
| `mix-blend-darken` | `mix-blend-mode: darken` |
| `mix-blend-lighten` | `mix-blend-mode: lighten` |
| `mix-blend-color-dodge` | `mix-blend-mode: color-dodge` |
| `mix-blend-color-burn` | `mix-blend-mode: color-burn` |
| `mix-blend-hard-light` | `mix-blend-mode: hard-light` |
| `mix-blend-soft-light` | `mix-blend-mode: soft-light` |
| `mix-blend-difference` | `mix-blend-mode: difference` |
| `mix-blend-exclusion` | `mix-blend-mode: exclusion` |
| `mix-blend-hue` | `mix-blend-mode: hue` |
| `mix-blend-saturation` | `mix-blend-mode: saturation` |
| `mix-blend-color` | `mix-blend-mode: color` |
| `mix-blend-luminosity` | `mix-blend-mode: luminosity` |
| `mix-blend-plus-lighter` | `mix-blend-mode: plus-lighter` |

Background blend mode uses `bg-blend-*` prefix with same values.

---

## Cursor

| Class | CSS |
|-------|-----|
| `cursor-auto` | `cursor: auto` |
| `cursor-default` | `cursor: default` |
| `cursor-pointer` | `cursor: pointer` |
| `cursor-wait` | `cursor: wait` |
| `cursor-text` | `cursor: text` |
| `cursor-move` | `cursor: move` |
| `cursor-help` | `cursor: help` |
| `cursor-not-allowed` | `cursor: not-allowed` |
| `cursor-none` | `cursor: none` |
| `cursor-grab` | `cursor: grab` |
| `cursor-grabbing` | `cursor: grabbing` |
| `cursor-crosshair` | `cursor: crosshair` |
| `cursor-col-resize` | `cursor: col-resize` |
| `cursor-row-resize` | `cursor: row-resize` |
| `cursor-zoom-in` | `cursor: zoom-in` |
| `cursor-zoom-out` | `cursor: zoom-out` |

---

## Pointer Events

| Class | CSS |
|-------|-----|
| `pointer-events-none` | `pointer-events: none` |
| `pointer-events-auto` | `pointer-events: auto` |

## User Select

| Class | CSS |
|-------|-----|
| `select-none` | `user-select: none` |
| `select-text` | `user-select: text` |
| `select-all` | `user-select: all` |
| `select-auto` | `user-select: auto` |

## Appearance

| Class | CSS |
|-------|-----|
| `appearance-none` | `appearance: none` |
| `appearance-auto` | `appearance: auto` |

## Accent Color

```html
<input type="checkbox" class="accent-pink-500" />
<input type="range" class="accent-blue-600" />
```
