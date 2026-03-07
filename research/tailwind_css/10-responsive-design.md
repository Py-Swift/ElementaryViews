# Tailwind CSS — Responsive Design & Media Queries

## Responsive Breakpoints

Tailwind uses a **mobile-first** breakpoint system. Unprefixed utilities apply to all sizes; prefixed utilities apply at that breakpoint **and above**.

### Default Breakpoints

| Variant | Min Width | Pixels | CSS |
|---------|-----------|--------|-----|
| *(none)* | 0 | 0px | Always applies |
| `sm` | 40rem | 640px | `@media (width >= 40rem)` |
| `md` | 48rem | 768px | `@media (width >= 48rem)` |
| `lg` | 64rem | 1024px | `@media (width >= 64rem)` |
| `xl` | 80rem | 1280px | `@media (width >= 80rem)` |
| `2xl` | 96rem | 1536px | `@media (width >= 96rem)` |

### Max-Width Variants

| Variant | CSS |
|---------|-----|
| `max-sm` | `@media (width < 40rem)` |
| `max-md` | `@media (width < 48rem)` |
| `max-lg` | `@media (width < 64rem)` |
| `max-xl` | `@media (width < 80rem)` |
| `max-2xl` | `@media (width < 96rem)` |

### Usage

```html
<!-- Mobile-first approach -->
<div class="text-center sm:text-left">

<!-- Responsive grid -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">

<!-- Responsive layout -->
<div class="flex flex-col md:flex-row">

<!-- Responsive spacing -->
<div class="p-4 md:p-8 lg:p-12">

<!-- Responsive visibility -->
<div class="hidden md:block">   <!-- Hidden on mobile, visible md+ -->
<div class="md:hidden">         <!-- Visible on mobile only -->
```

### Targeting a Breakpoint Range

```html
<div class="md:max-xl:flex">   <!-- flex only between md and xl -->
```

### Targeting a Single Breakpoint

```html
<div class="md:max-lg:flex">   <!-- flex only at md -->
```

### Arbitrary Breakpoints

```html
<div class="min-[320px]:text-center">
<div class="max-[600px]:bg-sky-300">
```

### Mobile-First Key Principle

> Use **unprefixed** utilities for mobile styles. Use `sm:`, `md:`, etc. to override for larger screens.

```html
<!-- WRONG: sm: doesn't target mobile -->
<div class="sm:text-center">

<!-- RIGHT: text-center on mobile, left-align on sm+ -->
<div class="text-center sm:text-left">
```

---

## Container Queries

Style based on parent size instead of viewport.

### Setup
```html
<div class="@container">
  <div class="flex flex-col @md:flex-row">...</div>
</div>
```

### Container Size Variants

| Variant | Min Width | Pixels |
|---------|-----------|--------|
| `@3xs` | 16rem | 256px |
| `@2xs` | 18rem | 288px |
| `@xs` | 20rem | 320px |
| `@sm` | 24rem | 384px |
| `@md` | 28rem | 448px |
| `@lg` | 32rem | 512px |
| `@xl` | 36rem | 576px |
| `@2xl` | 42rem | 672px |
| `@3xl` | 48rem | 768px |
| `@4xl` | 56rem | 896px |
| `@5xl` | 64rem | 1024px |
| `@6xl` | 72rem | 1152px |
| `@7xl` | 80rem | 1280px |

### Max-Width Container Variants

| Variant | CSS |
|---------|-----|
| `@max-3xs` | `@container (width < 16rem)` |
| `@max-2xs` | `@container (width < 18rem)` |
| `@max-xs` | `@container (width < 20rem)` |
| `@max-sm` | `@container (width < 24rem)` |
| `@max-md` | `@container (width < 28rem)` |
| `@max-lg` | `@container (width < 32rem)` |
| `@max-xl` | `@container (width < 36rem)` |
| `@max-2xl` | `@container (width < 42rem)` |
| `@max-3xl` | `@container (width < 48rem)` |
| `@max-4xl` | `@container (width < 56rem)` |
| `@max-5xl` | `@container (width < 64rem)` |
| `@max-6xl` | `@container (width < 72rem)` |
| `@max-7xl` | `@container (width < 80rem)` |

### Named Containers

```html
<div class="@container/main">
  <div class="@sm/main:flex-col">...</div>
</div>
```

### Container Query Ranges

```html
<div class="@sm:@max-md:flex-col">  <!-- Only between @sm and @md -->
```

### Arbitrary Container Sizes

```html
<div class="@min-[475px]:flex-row">
<div class="@max-[960px]:flex-col">
```

### Container Query Units

```html
<div class="@container">
  <div class="w-[50cqw]">   <!-- 50% of container width -->
</div>
```

---

## Dark Mode

Uses `prefers-color-scheme` media query by default.

```html
<div class="bg-white dark:bg-gray-900">
  <h3 class="text-gray-900 dark:text-white">Title</h3>
  <p class="text-gray-500 dark:text-gray-400">Body</p>
</div>
```

| Variant | CSS |
|---------|-----|
| `dark` | `@media (prefers-color-scheme: dark)` |

---

## Other Media/Feature Query Variants

| Variant | CSS | Use Case |
|---------|-----|----------|
| `motion-safe` | `@media (prefers-reduced-motion: no-preference)` | Only add motion when OK |
| `motion-reduce` | `@media (prefers-reduced-motion: reduce)` | Remove motion |
| `contrast-more` | `@media (prefers-contrast: more)` | High contrast mode |
| `contrast-less` | `@media (prefers-contrast: less)` | Low contrast mode |
| `forced-colors` | `@media (forced-colors: active)` | Windows high contrast |
| `inverted-colors` | `@media (inverted-colors: inverted)` | Inverted display |
| `pointer-fine` | `@media (pointer: fine)` | Mouse/trackpad |
| `pointer-coarse` | `@media (pointer: coarse)` | Touch device |
| `pointer-none` | `@media (pointer: none)` | No pointer |
| `any-pointer-fine` | `@media (any-pointer: fine)` | Any connected fine pointer |
| `any-pointer-coarse` | `@media (any-pointer: coarse)` | Any connected touch |
| `portrait` | `@media (orientation: portrait)` | Portrait orientation |
| `landscape` | `@media (orientation: landscape)` | Landscape orientation |
| `noscript` | `@media (scripting: none)` | JS disabled |
| `print` | `@media print` | Print styles |
| `supports-[...]` | `@supports (...)` | Feature detection |
| `not-supports-[...]` | `@supports not (...)` | Negative feature detection |
| `starting` | `@starting-style` | Initial render with transitions |

### Examples

```html
<!-- Reduced motion -->
<button class="motion-safe:transition motion-safe:hover:-translate-y-0.5">

<!-- High contrast -->
<input class="contrast-more:border-gray-400 contrast-more:placeholder-gray-500">

<!-- Touch-friendly targets -->
<label class="p-2 pointer-coarse:p-4">

<!-- Print styles -->
<article class="print:hidden">

<!-- Feature detection -->
<div class="flex supports-[display:grid]:grid">

<!-- Hide without JS -->
<div class="hidden noscript:block">Enable JavaScript</div>
```

---

## Customizing Breakpoints

### Add/Override Breakpoints
```css
@theme {
  --breakpoint-xs: 30rem;
  --breakpoint-2xl: 100rem;
  --breakpoint-3xl: 120rem;
}
```

### Remove Breakpoints
```css
@theme {
  --breakpoint-2xl: initial;
}
```

### Replace All Breakpoints
```css
@theme {
  --breakpoint-*: initial;
  --breakpoint-tablet: 40rem;
  --breakpoint-laptop: 64rem;
  --breakpoint-desktop: 80rem;
}
```

### Custom Container Sizes
```css
@theme {
  --container-8xl: 96rem;
}
```

> Always use the same unit (rem) for all breakpoints to ensure correct sorting.
