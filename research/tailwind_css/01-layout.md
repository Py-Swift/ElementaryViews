# Tailwind CSS — Layout Utilities

## Display

| Class | CSS |
|-------|-----|
| `inline` | `display: inline` |
| `block` | `display: block` |
| `inline-block` | `display: inline-block` |
| `flex` | `display: flex` |
| `inline-flex` | `display: inline-flex` |
| `grid` | `display: grid` |
| `inline-grid` | `display: inline-grid` |
| `table` | `display: table` |
| `table-row` | `display: table-row` |
| `table-cell` | `display: table-cell` |
| `table-caption` | `display: table-caption` |
| `table-column` | `display: table-column` |
| `table-column-group` | `display: table-column-group` |
| `table-footer-group` | `display: table-footer-group` |
| `table-header-group` | `display: table-header-group` |
| `table-row-group` | `display: table-row-group` |
| `contents` | `display: contents` |
| `list-item` | `display: list-item` |
| `hidden` | `display: none` |
| `sr-only` | Screen reader only (positioned off-screen) |
| `not-sr-only` | Undo `sr-only` |

## Position

| Class | CSS |
|-------|-----|
| `static` | `position: static` |
| `fixed` | `position: fixed` |
| `absolute` | `position: absolute` |
| `relative` | `position: relative` |
| `sticky` | `position: sticky` |

### Inset (Top / Right / Bottom / Left)

| Class | CSS |
|-------|-----|
| `inset-0` | `inset: calc(var(--spacing) * 0)` → `0px` |
| `inset-{n}` | `inset: calc(var(--spacing) * n)` |
| `inset-auto` | `inset: auto` |
| `inset-full` | `inset: 100%` |
| `inset-1/2` | `inset: 50%` |
| `inset-x-{n}` | `left` + `right` |
| `inset-y-{n}` | `top` + `bottom` |
| `top-{n}` | `top: calc(var(--spacing) * n)` |
| `right-{n}` | `right: calc(var(--spacing) * n)` |
| `bottom-{n}` | `bottom: calc(var(--spacing) * n)` |
| `left-{n}` | `left: calc(var(--spacing) * n)` |
| `start-{n}` | `inset-inline-start` |
| `end-{n}` | `inset-inline-end` |

Negative values: prefix with `-`, e.g. `-top-4`.

## Overflow

| Class | CSS |
|-------|-----|
| `overflow-auto` | `overflow: auto` |
| `overflow-hidden` | `overflow: hidden` |
| `overflow-clip` | `overflow: clip` |
| `overflow-visible` | `overflow: visible` |
| `overflow-scroll` | `overflow: scroll` |
| `overflow-x-auto` | `overflow-x: auto` |
| `overflow-x-hidden` | `overflow-x: hidden` |
| `overflow-x-clip` | `overflow-x: clip` |
| `overflow-x-visible` | `overflow-x: visible` |
| `overflow-x-scroll` | `overflow-x: scroll` |
| `overflow-y-auto` | `overflow-y: auto` |
| `overflow-y-hidden` | `overflow-y: hidden` |
| `overflow-y-clip` | `overflow-y: clip` |
| `overflow-y-visible` | `overflow-y: visible` |
| `overflow-y-scroll` | `overflow-y: scroll` |

## Z-Index

| Class | CSS |
|-------|-----|
| `z-0` | `z-index: 0` |
| `z-10` | `z-index: 10` |
| `z-20` | `z-index: 20` |
| `z-30` | `z-index: 30` |
| `z-40` | `z-index: 40` |
| `z-50` | `z-index: 50` |
| `z-auto` | `z-index: auto` |
| `z-{n}` | `z-index: n` (any integer) |
| `-z-10` | `z-index: calc(10 * -1)` |
| `z-[100]` | `z-index: 100` (arbitrary) |

## Visibility

| Class | CSS |
|-------|-----|
| `visible` | `visibility: visible` |
| `invisible` | `visibility: hidden` |
| `collapse` | `visibility: collapse` |

## Float

| Class | CSS |
|-------|-----|
| `float-left` | `float: left` |
| `float-right` | `float: right` |
| `float-start` | `float: inline-start` |
| `float-end` | `float: inline-end` |
| `float-none` | `float: none` |

## Clear

| Class | CSS |
|-------|-----|
| `clear-left` | `clear: left` |
| `clear-right` | `clear: right` |
| `clear-both` | `clear: both` |
| `clear-start` | `clear: inline-start` |
| `clear-end` | `clear: inline-end` |
| `clear-none` | `clear: none` |

## Object Fit

| Class | CSS |
|-------|-----|
| `object-contain` | `object-fit: contain` |
| `object-cover` | `object-fit: cover` |
| `object-fill` | `object-fit: fill` |
| `object-none` | `object-fit: none` |
| `object-scale-down` | `object-fit: scale-down` |

## Object Position

| Class | CSS |
|-------|-----|
| `object-bottom` | `object-position: bottom` |
| `object-center` | `object-position: center` |
| `object-left` | `object-position: left` |
| `object-left-bottom` | `object-position: left bottom` |
| `object-left-top` | `object-position: left top` |
| `object-right` | `object-position: right` |
| `object-right-bottom` | `object-position: right bottom` |
| `object-right-top` | `object-position: right top` |
| `object-top` | `object-position: top` |

## Box Sizing

| Class | CSS |
|-------|-----|
| `box-border` | `box-sizing: border-box` |
| `box-content` | `box-sizing: content-box` |

## Isolation

| Class | CSS |
|-------|-----|
| `isolate` | `isolation: isolate` |
| `isolation-auto` | `isolation: auto` |
