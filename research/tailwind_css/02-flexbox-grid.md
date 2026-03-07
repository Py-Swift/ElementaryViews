# Tailwind CSS — Flexbox & Grid

## Flex Direction

| Class | CSS |
|-------|-----|
| `flex-row` | `flex-direction: row` |
| `flex-row-reverse` | `flex-direction: row-reverse` |
| `flex-col` | `flex-direction: column` |
| `flex-col-reverse` | `flex-direction: column-reverse` |

## Flex Wrap

| Class | CSS |
|-------|-----|
| `flex-wrap` | `flex-wrap: wrap` |
| `flex-nowrap` | `flex-wrap: nowrap` |
| `flex-wrap-reverse` | `flex-wrap: wrap-reverse` |

## Flex Grow / Shrink / Basis

| Class | CSS |
|-------|-----|
| `grow` | `flex-grow: 1` |
| `grow-0` | `flex-grow: 0` |
| `grow-{n}` | `flex-grow: n` |
| `shrink` | `flex-shrink: 1` |
| `shrink-0` | `flex-shrink: 0` |
| `shrink-{n}` | `flex-shrink: n` |
| `basis-{n}` | `flex-basis: calc(var(--spacing) * n)` |
| `basis-auto` | `flex-basis: auto` |
| `basis-full` | `flex-basis: 100%` |
| `basis-1/2` | `flex-basis: 50%` |
| `basis-1/3` | `flex-basis: 33.333333%` |
| `basis-2/3` | `flex-basis: 66.666667%` |
| `basis-1/4` | `flex-basis: 25%` |
| `basis-3/4` | `flex-basis: 75%` |

## Flex Shorthand

| Class | CSS |
|-------|-----|
| `flex-1` | `flex: 1 1 0%` |
| `flex-auto` | `flex: 1 1 auto` |
| `flex-initial` | `flex: 0 1 auto` |
| `flex-none` | `flex: none` |

## Order

| Class | CSS |
|-------|-----|
| `order-{n}` | `order: n` (1–12, or arbitrary) |
| `order-first` | `order: calc(-infinity)` |
| `order-last` | `order: calc(infinity)` |
| `order-none` | `order: 0` |
| `-order-{n}` | `order: calc(n * -1)` |

---

## Justify Content

| Class | CSS |
|-------|-----|
| `justify-start` | `justify-content: flex-start` |
| `justify-end` | `justify-content: flex-end` |
| `justify-center` | `justify-content: center` |
| `justify-between` | `justify-content: space-between` |
| `justify-around` | `justify-content: space-around` |
| `justify-evenly` | `justify-content: space-evenly` |
| `justify-stretch` | `justify-content: stretch` |
| `justify-normal` | `justify-content: normal` |

## Justify Items

| Class | CSS |
|-------|-----|
| `justify-items-start` | `justify-items: start` |
| `justify-items-end` | `justify-items: end` |
| `justify-items-center` | `justify-items: center` |
| `justify-items-stretch` | `justify-items: stretch` |
| `justify-items-normal` | `justify-items: normal` |

## Justify Self

| Class | CSS |
|-------|-----|
| `justify-self-auto` | `justify-self: auto` |
| `justify-self-start` | `justify-self: start` |
| `justify-self-end` | `justify-self: end` |
| `justify-self-center` | `justify-self: center` |
| `justify-self-stretch` | `justify-self: stretch` |

## Align Items

| Class | CSS |
|-------|-----|
| `items-start` | `align-items: flex-start` |
| `items-end` | `align-items: flex-end` |
| `items-center` | `align-items: center` |
| `items-baseline` | `align-items: baseline` |
| `items-stretch` | `align-items: stretch` |

## Align Content

| Class | CSS |
|-------|-----|
| `content-start` | `align-content: flex-start` |
| `content-end` | `align-content: flex-end` |
| `content-center` | `align-content: center` |
| `content-between` | `align-content: space-between` |
| `content-around` | `align-content: space-around` |
| `content-evenly` | `align-content: space-evenly` |
| `content-stretch` | `align-content: stretch` |
| `content-baseline` | `align-content: baseline` |
| `content-normal` | `align-content: normal` |

## Align Self

| Class | CSS |
|-------|-----|
| `self-auto` | `align-self: auto` |
| `self-start` | `align-self: flex-start` |
| `self-end` | `align-self: flex-end` |
| `self-center` | `align-self: center` |
| `self-stretch` | `align-self: stretch` |
| `self-baseline` | `align-self: baseline` |

## Place Content / Items / Self

| Class | CSS |
|-------|-----|
| `place-content-center` | `place-content: center` |
| `place-content-start` | `place-content: start` |
| `place-content-end` | `place-content: end` |
| `place-content-between` | `place-content: space-between` |
| `place-content-around` | `place-content: space-around` |
| `place-content-evenly` | `place-content: space-evenly` |
| `place-content-stretch` | `place-content: stretch` |
| `place-content-baseline` | `place-content: baseline` |
| `place-items-start` | `place-items: start` |
| `place-items-end` | `place-items: end` |
| `place-items-center` | `place-items: center` |
| `place-items-stretch` | `place-items: stretch` |
| `place-items-baseline` | `place-items: baseline` |
| `place-self-auto` | `place-self: auto` |
| `place-self-start` | `place-self: start` |
| `place-self-end` | `place-self: end` |
| `place-self-center` | `place-self: center` |
| `place-self-stretch` | `place-self: stretch` |

---

## Grid Template Columns

| Class | CSS |
|-------|-----|
| `grid-cols-1` | `grid-template-columns: repeat(1, minmax(0, 1fr))` |
| `grid-cols-2` | `grid-template-columns: repeat(2, minmax(0, 1fr))` |
| `grid-cols-3` | `grid-template-columns: repeat(3, minmax(0, 1fr))` |
| `grid-cols-4` | `grid-template-columns: repeat(4, minmax(0, 1fr))` |
| `grid-cols-5` | `grid-template-columns: repeat(5, minmax(0, 1fr))` |
| `grid-cols-6` | `grid-template-columns: repeat(6, minmax(0, 1fr))` |
| `grid-cols-7` | `grid-template-columns: repeat(7, minmax(0, 1fr))` |
| `grid-cols-8` | `grid-template-columns: repeat(8, minmax(0, 1fr))` |
| `grid-cols-9` | `grid-template-columns: repeat(9, minmax(0, 1fr))` |
| `grid-cols-10` | `grid-template-columns: repeat(10, minmax(0, 1fr))` |
| `grid-cols-11` | `grid-template-columns: repeat(11, minmax(0, 1fr))` |
| `grid-cols-12` | `grid-template-columns: repeat(12, minmax(0, 1fr))` |
| `grid-cols-none` | `grid-template-columns: none` |
| `grid-cols-subgrid` | `grid-template-columns: subgrid` |
| `grid-cols-[...]` | Arbitrary value |

## Grid Template Rows

| Class | CSS |
|-------|-----|
| `grid-rows-{n}` | `grid-template-rows: repeat(n, minmax(0, 1fr))` |
| `grid-rows-none` | `grid-template-rows: none` |
| `grid-rows-subgrid` | `grid-template-rows: subgrid` |
| `grid-rows-[...]` | Arbitrary value |

## Grid Column Span

| Class | CSS |
|-------|-----|
| `col-span-{n}` | `grid-column: span n / span n` |
| `col-span-full` | `grid-column: 1 / -1` |
| `col-start-{n}` | `grid-column-start: n` |
| `col-end-{n}` | `grid-column-end: n` |
| `col-auto` | `grid-column: auto` |

## Grid Row Span

| Class | CSS |
|-------|-----|
| `row-span-{n}` | `grid-row: span n / span n` |
| `row-span-full` | `grid-row: 1 / -1` |
| `row-start-{n}` | `grid-row-start: n` |
| `row-end-{n}` | `grid-row-end: n` |
| `row-auto` | `grid-row: auto` |

## Grid Auto Flow

| Class | CSS |
|-------|-----|
| `grid-flow-row` | `grid-auto-flow: row` |
| `grid-flow-col` | `grid-auto-flow: column` |
| `grid-flow-dense` | `grid-auto-flow: dense` |
| `grid-flow-row-dense` | `grid-auto-flow: row dense` |
| `grid-flow-col-dense` | `grid-auto-flow: column dense` |

## Grid Auto Columns / Rows

| Class | CSS |
|-------|-----|
| `auto-cols-auto` | `grid-auto-columns: auto` |
| `auto-cols-min` | `grid-auto-columns: min-content` |
| `auto-cols-max` | `grid-auto-columns: max-content` |
| `auto-cols-fr` | `grid-auto-columns: minmax(0, 1fr)` |
| `auto-rows-auto` | `grid-auto-rows: auto` |
| `auto-rows-min` | `grid-auto-rows: min-content` |
| `auto-rows-max` | `grid-auto-rows: max-content` |
| `auto-rows-fr` | `grid-auto-rows: minmax(0, 1fr)` |

## Gap

| Class | CSS |
|-------|-----|
| `gap-0` | `gap: 0px` |
| `gap-px` | `gap: 1px` |
| `gap-0.5` | `gap: calc(var(--spacing) * 0.5)` → `0.125rem` |
| `gap-1` | `gap: calc(var(--spacing) * 1)` → `0.25rem` |
| `gap-2` | `gap: calc(var(--spacing) * 2)` → `0.5rem` |
| `gap-3` | `gap: calc(var(--spacing) * 3)` → `0.75rem` |
| `gap-4` | `gap: calc(var(--spacing) * 4)` → `1rem` |
| `gap-5` | `gap: calc(var(--spacing) * 5)` → `1.25rem` |
| `gap-6` | `gap: calc(var(--spacing) * 6)` → `1.5rem` |
| `gap-8` | `gap: calc(var(--spacing) * 8)` → `2rem` |
| `gap-10` | `gap: calc(var(--spacing) * 10)` → `2.5rem` |
| `gap-12` | `gap: calc(var(--spacing) * 12)` → `3rem` |
| `gap-16` | `gap: calc(var(--spacing) * 16)` → `4rem` |
| `gap-x-{n}` | `column-gap: calc(var(--spacing) * n)` |
| `gap-y-{n}` | `row-gap: calc(var(--spacing) * n)` |

**Default spacing scale:** `--spacing: 0.25rem` (4px). So `gap-4` = `1rem` = `16px`.

## Common Flex/Grid Layout Patterns

```html
<!-- Centered content -->
<div class="flex items-center justify-center">...</div>

<!-- Sidebar layout -->
<div class="flex">
  <aside class="w-64 shrink-0">...</aside>
  <main class="flex-1">...</main>
</div>

<!-- Responsive grid -->
<div class="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">...</div>

<!-- Equal-height cards -->
<div class="grid grid-cols-3 gap-6">
  <div class="flex flex-col">...</div>
</div>

<!-- Space-between navbar -->
<nav class="flex items-center justify-between">...</nav>
```
