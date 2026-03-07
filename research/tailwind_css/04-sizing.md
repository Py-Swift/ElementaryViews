# Tailwind CSS — Sizing (Width, Height, Min/Max)

## Width

### Spacing-Based Width

Uses `calc(var(--spacing) * n)`:

| Class | Value |
|-------|-------|
| `w-0` | `0px` |
| `w-px` | `1px` |
| `w-0.5` | `0.125rem` (2px) |
| `w-1` | `0.25rem` (4px) |
| `w-2` | `0.5rem` (8px) |
| `w-4` | `1rem` (16px) |
| `w-8` | `2rem` (32px) |
| `w-12` | `3rem` (48px) |
| `w-16` | `4rem` (64px) |
| `w-24` | `6rem` (96px) |
| `w-32` | `8rem` (128px) |
| `w-48` | `12rem` (192px) |
| `w-64` | `16rem` (256px) |
| `w-96` | `24rem` (384px) |

### Fractional Width

| Class | CSS |
|-------|-----|
| `w-1/2` | `width: 50%` |
| `w-1/3` | `width: 33.333333%` |
| `w-2/3` | `width: 66.666667%` |
| `w-1/4` | `width: 25%` |
| `w-2/4` | `width: 50%` |
| `w-3/4` | `width: 75%` |
| `w-1/5` | `width: 20%` |
| `w-2/5` | `width: 40%` |
| `w-3/5` | `width: 60%` |
| `w-4/5` | `width: 80%` |
| `w-1/6` | `width: 16.666667%` |
| `w-5/6` | `width: 83.333333%` |
| `w-1/12` | `width: 8.333333%` |
| `w-5/12` | `width: 41.666667%` |
| `w-7/12` | `width: 58.333333%` |
| `w-11/12` | `width: 91.666667%` |

### Named Width Sizes

| Class | CSS |
|-------|-----|
| `w-3xs` | `width: var(--container-3xs)` → `16rem` (256px) |
| `w-2xs` | `width: var(--container-2xs)` → `18rem` (288px) |
| `w-xs` | `width: var(--container-xs)` → `20rem` (320px) |
| `w-sm` | `width: var(--container-sm)` → `24rem` (384px) |
| `w-md` | `width: var(--container-md)` → `28rem` (448px) |
| `w-lg` | `width: var(--container-lg)` → `32rem` (512px) |
| `w-xl` | `width: var(--container-xl)` → `36rem` (576px) |
| `w-2xl` | `width: var(--container-2xl)` → `42rem` (672px) |
| `w-3xl` | `width: var(--container-3xl)` → `48rem` (768px) |
| `w-4xl` | `width: var(--container-4xl)` → `56rem` (896px) |
| `w-5xl` | `width: var(--container-5xl)` → `64rem` (1024px) |
| `w-6xl` | `width: var(--container-6xl)` → `72rem` (1152px) |
| `w-7xl` | `width: var(--container-7xl)` → `80rem` (1280px) |

### Special Width Values

| Class | CSS |
|-------|-----|
| `w-auto` | `width: auto` |
| `w-full` | `width: 100%` |
| `w-screen` | `width: 100vw` |
| `w-dvw` | `width: 100dvw` |
| `w-lvw` | `width: 100lvw` |
| `w-svw` | `width: 100svw` |
| `w-min` | `width: min-content` |
| `w-max` | `width: max-content` |
| `w-fit` | `width: fit-content` |

---

## Height

### Spacing-Based Height

Same scale as width: `h-0`, `h-px`, `h-0.5`, `h-1` through `h-96`.

### Fractional Height

| Class | CSS |
|-------|-----|
| `h-1/2` | `height: 50%` |
| `h-1/3` | `height: 33.333333%` |
| `h-2/3` | `height: 66.666667%` |
| `h-1/4` | `height: 25%` |
| `h-3/4` | `height: 75%` |
| `h-1/5` | `height: 20%` |
| `h-4/5` | `height: 80%` |
| `h-1/6` | `height: 16.666667%` |
| `h-5/6` | `height: 83.333333%` |

### Special Height Values

| Class | CSS |
|-------|-----|
| `h-auto` | `height: auto` |
| `h-full` | `height: 100%` |
| `h-screen` | `height: 100vh` |
| `h-dvh` | `height: 100dvh` (dynamic viewport) |
| `h-lvh` | `height: 100lvh` (large viewport) |
| `h-svh` | `height: 100svh` (small viewport) |
| `h-min` | `height: min-content` |
| `h-max` | `height: max-content` |
| `h-fit` | `height: fit-content` |

---

## Size (Width + Height simultaneously)

| Class | CSS |
|-------|-----|
| `size-{n}` | `width: ...; height: ...` (same value) |
| `size-full` | `width: 100%; height: 100%` |
| `size-auto` | `width: auto; height: auto` |
| `size-min` | `width: min-content; height: min-content` |
| `size-max` | `width: max-content; height: max-content` |
| `size-fit` | `width: fit-content; height: fit-content` |

```html
<div class="size-12">    <!-- 3rem × 3rem square -->
<img class="size-10 rounded-full">  <!-- 2.5rem avatar -->
```

---

## Min/Max Width

| Class | CSS |
|-------|-----|
| `min-w-0` | `min-width: 0px` |
| `min-w-full` | `min-width: 100%` |
| `min-w-min` | `min-width: min-content` |
| `min-w-max` | `min-width: max-content` |
| `min-w-fit` | `min-width: fit-content` |
| `min-w-{n}` | `min-width: calc(var(--spacing) * n)` |
| `max-w-{n}` | `max-width: calc(var(--spacing) * n)` |
| `max-w-none` | `max-width: none` |
| `max-w-full` | `max-width: 100%` |
| `max-w-min` | `max-width: min-content` |
| `max-w-max` | `max-width: max-content` |
| `max-w-fit` | `max-width: fit-content` |
| `max-w-prose` | `max-width: 65ch` |
| `max-w-screen` | `max-width: 100vw` |

### Named Max-Width Sizes
Same `3xs`–`7xl` scale as `w-*`:
```html
<div class="max-w-sm">   <!-- max-width: 24rem (384px) -->
<div class="max-w-md">   <!-- max-width: 28rem (448px) -->
<div class="max-w-lg">   <!-- max-width: 32rem (512px) -->
<div class="max-w-xl">   <!-- max-width: 36rem (576px) -->
<div class="max-w-2xl">  <!-- max-width: 42rem (672px) -->
<div class="max-w-7xl">  <!-- max-width: 80rem (1280px) -->
```

## Min/Max Height

| Class | CSS |
|-------|-----|
| `min-h-0` | `min-height: 0px` |
| `min-h-full` | `min-height: 100%` |
| `min-h-screen` | `min-height: 100vh` |
| `min-h-dvh` | `min-height: 100dvh` |
| `min-h-svh` | `min-height: 100svh` |
| `min-h-lvh` | `min-height: 100lvh` |
| `min-h-min` | `min-height: min-content` |
| `min-h-max` | `min-height: max-content` |
| `min-h-fit` | `min-height: fit-content` |
| `max-h-{n}` | `max-height: calc(var(--spacing) * n)` |
| `max-h-none` | `max-height: none` |
| `max-h-full` | `max-height: 100%` |
| `max-h-screen` | `max-height: 100vh` |
| `max-h-dvh` | `max-height: 100dvh` |

## Common Sizing Patterns

```html
<!-- Full-page layout -->
<div class="min-h-screen">...</div>

<!-- Constrained content area -->
<div class="mx-auto max-w-7xl px-4">...</div>

<!-- Fixed aspect ratio image -->
<img class="h-48 w-full object-cover" />

<!-- Square icon -->
<svg class="size-6">...</svg>

<!-- Responsive image container -->
<div class="w-full md:w-1/2 lg:w-1/3">...</div>
```
