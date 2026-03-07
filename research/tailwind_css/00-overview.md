# Tailwind CSS v4.2 — Overview & Core Concepts

> Reference guide for Tailwind CSS utility classes, for use in HTML/CSS generation.

## What is Tailwind CSS?

Tailwind CSS is a **utility-first CSS framework** where you style elements by composing small, single-purpose CSS utility classes directly in your HTML markup instead of writing custom CSS.

```html
<div class="mx-auto max-w-sm rounded-xl bg-white p-6 shadow-lg">
  <h3 class="text-lg font-semibold text-gray-900">Hello Tailwind</h3>
  <p class="mt-2 text-sm text-gray-500">Styled entirely with utility classes.</p>
</div>
```

## Installation (v4)

```css
/* app.css */
@import "tailwindcss";
```

Or via CDN (for prototyping):
```html
<script src="https://cdn.tailwindcss.com"></script>
```

## Utility-First Fundamentals

- Every CSS property has one or more corresponding **utility classes**.
- Classes are composed together to build any design directly in markup.
- **No need to invent class names** or write custom CSS for most things.

### Example

```html
<!-- Traditional CSS approach -->
<div class="chat-notification">...</div>

<!-- Tailwind utility-first approach -->
<div class="flex items-center gap-4 rounded-xl bg-white p-6 shadow-lg">...</div>
```

## Variants (Conditional Styling)

Variants let you apply any utility **conditionally** by prefixing it:

```
{variant}:{utility}
```

### Syntax Examples
```html
hover:bg-sky-700       /* on hover */
focus:outline-2        /* on focus */
dark:bg-gray-800       /* in dark mode */
md:flex                /* at medium breakpoint and up */
active:bg-violet-700   /* while being clicked */
disabled:opacity-50    /* when disabled */
```

### Stacking Variants
```html
dark:md:hover:bg-fuchsia-600
```

## Arbitrary Values

Use any custom value with square brackets:

```html
bg-[#1da1f2]           /* arbitrary color */
text-[22px]            /* arbitrary size */
top-[117px]            /* arbitrary position */
grid-cols-[1fr_2fr]    /* arbitrary grid */
p-[clamp(1rem,5vw,3rem)]  /* arbitrary expression */
```

### CSS Variable Shorthand

```html
bg-(--my-color)        /* equivalent to bg-[var(--my-color)] */
text-(--brand-size)
```

## Theme Customization

Tailwind v4 uses CSS `@theme` to define design tokens as CSS variables:

```css
@import "tailwindcss";

@theme {
  --color-primary: #3b82f6;
  --color-secondary: #6366f1;
  --font-display: "Satoshi", sans-serif;
  --breakpoint-3xl: 120rem;
}
```

All theme tokens are exposed as CSS variables:
- `--color-*` → colors
- `--font-*` → font families
- `--text-*` → font sizes
- `--font-weight-*` → font weights
- `--spacing` → base spacing multiplier
- `--radius-*` → border radii
- `--shadow-*` → box shadows
- `--breakpoint-*` → responsive breakpoints
- `--container-*` → container query sizes

### Overriding Defaults

```css
@theme {
  --color-gray-50: oklch(0.984 0.003 247.858);
  /* Override any default token */
}
```

### Disabling Defaults

```css
@theme {
  --color-lime-*: initial;    /* Remove lime palette */
  --color-*: initial;         /* Remove ALL default colors */
}
```

## Class Composition & Conflicts

- Last class in the source order wins when there's a conflict.
- Use `@apply` in CSS to extract repeated patterns:

```css
@layer components {
  .btn-primary {
    @apply rounded-full bg-blue-500 px-4 py-2 font-bold text-white;
  }
}
```

## File Organization

- `@import "tailwindcss"` — single import for everything
- `@theme {}` — define/override design tokens
- `@layer components {}` — reusable component styles
- `@layer utilities {}` — custom utility classes
- `@custom-variant` — define custom variant selectors
