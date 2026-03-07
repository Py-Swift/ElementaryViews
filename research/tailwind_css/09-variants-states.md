# Tailwind CSS — Variants (Hover, Focus, States & More)

Every utility can be applied conditionally with a variant prefix: `{variant}:{utility}`.

Multiple variants can be stacked: `dark:md:hover:bg-fuchsia-600`.

---

## Pseudo-Class Variants

### Interactive States

| Variant | Selector | Example |
|---------|----------|---------|
| `hover` | `@media (hover: hover) { &:hover }` | `hover:bg-blue-600` |
| `focus` | `&:focus` | `focus:outline-2` |
| `focus-within` | `&:focus-within` | `focus-within:shadow-lg` |
| `focus-visible` | `&:focus-visible` | `focus-visible:outline-2` |
| `active` | `&:active` | `active:bg-blue-700` |
| `visited` | `&:visited` | `visited:text-purple-600` |
| `target` | `&:target` | `target:shadow-lg` |

### Structural Pseudo-Classes

| Variant | Selector | Example |
|---------|----------|---------|
| `first` | `&:first-child` | `first:pt-0` |
| `last` | `&:last-child` | `last:pb-0` |
| `only` | `&:only-child` | `only:py-0` |
| `odd` | `&:nth-child(odd)` | `odd:bg-gray-100` |
| `even` | `&:nth-child(even)` | `even:bg-gray-50` |
| `first-of-type` | `&:first-of-type` | `first-of-type:ml-6` |
| `last-of-type` | `&:last-of-type` | `last-of-type:mr-6` |
| `only-of-type` | `&:only-of-type` | `only-of-type:mx-6` |
| `nth-{n}` | `&:nth-child(n)` | `nth-3:underline` |
| `nth-last-{n}` | `&:nth-last-child(n)` | `nth-last-5:underline` |
| `nth-of-type-{n}` | `&:nth-of-type(n)` | `nth-of-type-4:underline` |
| `nth-last-of-type-{n}` | `&:nth-last-of-type(n)` | `nth-last-of-type-6:underline` |
| `empty` | `&:empty` | `empty:hidden` |

### Form State Pseudo-Classes

| Variant | Selector | Example |
|---------|----------|---------|
| `disabled` | `&:disabled` | `disabled:opacity-50` |
| `enabled` | `&:enabled` | `enabled:hover:border-gray-400` |
| `checked` | `&:checked` | `checked:bg-blue-500` |
| `indeterminate` | `&:indeterminate` | `indeterminate:bg-gray-300` |
| `default` | `&:default` | `default:outline-2` |
| `optional` | `&:optional` | `optional:border-red-500` |
| `required` | `&:required` | `required:border-red-500` |
| `valid` | `&:valid` | `valid:border-green-500` |
| `invalid` | `&:invalid` | `invalid:border-red-500` |
| `user-valid` | `&:user-valid` | `user-valid:border-green-500` |
| `user-invalid` | `&:user-invalid` | `user-invalid:border-red-500` |
| `in-range` | `&:in-range` | `in-range:border-green-500` |
| `out-of-range` | `&:out-of-range` | `out-of-range:border-red-500` |
| `placeholder-shown` | `&:placeholder-shown` | `placeholder-shown:border-gray-500` |
| `autofill` | `&:autofill` | `autofill:bg-yellow-200` |
| `read-only` | `&:read-only` | `read-only:bg-gray-100` |

### Conditional Pseudo-Classes

| Variant | Selector | Example |
|---------|----------|---------|
| `has-[...]` | `&:has(...)` | `has-checked:bg-indigo-50` |
| `not-[...]` | `&:not(...)` | `not-focus:hover:bg-indigo-700` |

---

## Parent/Sibling State Variants

### group — Style Based on Parent State

Mark a parent with `group`, then use `group-*` on children:

```html
<a href="#" class="group">
  <h3 class="text-gray-900 group-hover:text-white">Title</h3>
  <p class="text-gray-500 group-hover:text-white">Description</p>
</a>
```

**Named groups** — differentiate nested groups:
```html
<li class="group/item">
  <a class="group/edit invisible group-hover/item:visible">
    <span class="group-hover/edit:text-gray-700">Call</span>
  </a>
</li>
```

**Arbitrary groups:**
```html
<div class="group is-published">
  <div class="hidden group-[.is-published]:block">Published</div>
</div>
```

### in-* — Implicit Groups (No group Class Needed)

```html
<div tabindex="0">
  <div class="opacity-50 in-focus:opacity-100">...</div>
</div>
```

### peer — Style Based on Sibling State

Mark a sibling with `peer`, then use `peer-*` on later siblings:

```html
<input type="email" class="peer" />
<p class="invisible peer-invalid:visible text-red-500">
  Please provide a valid email address.
</p>
```

**Named peers:**
```html
<input id="draft" class="peer/draft" type="radio" checked />
<label class="peer-checked/draft:text-sky-500">Draft</label>
```

> **Important:** `peer` only works on **previous** siblings (CSS limitation).

---

## Pseudo-Element Variants

| Variant | Selector | Example |
|---------|----------|---------|
| `before` | `&::before` | `before:content-['*'] before:text-red-500` |
| `after` | `&::after` | `after:content-[''] after:block` |
| `placeholder` | `&::placeholder` | `placeholder:text-gray-400 placeholder:italic` |
| `file` | `&::file-selector-button` | `file:mr-4 file:rounded-full file:bg-violet-50` |
| `marker` | `&::marker` | `marker:text-sky-400` |
| `selection` | `&::selection` | `selection:bg-fuchsia-300` |
| `first-letter` | `&::first-letter` | `first-letter:text-7xl first-letter:font-bold` |
| `first-line` | `&::first-line` | `first-line:uppercase first-line:tracking-widest` |
| `backdrop` | `&::backdrop` | `backdrop:bg-gray-50` |

> `before` and `after` automatically add `content: ''`.

---

## Child Selectors

| Variant | Selector | Example |
|---------|----------|---------|
| `*` | `:is(& > *)` (direct children) | `*:rounded-full *:border` |
| `**` | `:is(& *)` (all descendants) | `**:data-avatar:size-12` |

```html
<!-- Style all direct children -->
<ul class="*:rounded-full *:border *:px-2 *:py-0.5">
  <li>Sales</li>
  <li>Marketing</li>
</ul>
```

---

## Attribute Selectors

### ARIA States

| Variant | Selector |
|---------|----------|
| `aria-busy` | `&[aria-busy="true"]` |
| `aria-checked` | `&[aria-checked="true"]` |
| `aria-disabled` | `&[aria-disabled="true"]` |
| `aria-expanded` | `&[aria-expanded="true"]` |
| `aria-hidden` | `&[aria-hidden="true"]` |
| `aria-pressed` | `&[aria-pressed="true"]` |
| `aria-readonly` | `&[aria-readonly="true"]` |
| `aria-required` | `&[aria-required="true"]` |
| `aria-selected` | `&[aria-selected="true"]` |

Arbitrary: `aria-[sort=ascending]:bg-[url('/img/down-arrow.svg')]`

### Data Attributes

```html
<!-- Checks if data attribute exists -->
<div data-active class="data-active:border-purple-500">

<!-- Checks specific value -->
<div data-size="large" class="data-[size=large]:p-8">
```

### Open/Closed State

| Variant | Element |
|---------|---------|
| `open` | `<details>`, `<dialog>`, popovers |

```html
<details class="open:bg-gray-100" open>...</details>
```

### Other Attribute Variants

| Variant | Selector | Use Case |
|---------|----------|----------|
| `rtl` | `:dir(rtl)` | Right-to-left layouts |
| `ltr` | `:dir(ltr)` | Left-to-right layouts |
| `inert` | `&[inert]` | Non-interactive sections |

---

## Custom Variants

### Arbitrary Variants

Use `[selector]` for one-off conditions:

```html
<li class="[&.is-dragging]:cursor-grabbing">
<div class="[&_p]:mt-4">          <!-- all p descendants -->
<div class="[@supports(display:grid)]:grid">
```

### Registering Custom Variants

```css
@custom-variant theme-midnight (&:where([data-theme="midnight"] *));

/* Usage: */
<button class="theme-midnight:bg-black">
```

---

## Quick Reference Table

### Interactive
| `hover` | `focus` | `focus-within` | `focus-visible` | `active` | `visited` | `target` |

### Structural
| `first` | `last` | `only` | `odd` | `even` | `empty` | `nth-{n}` |

### Form
| `disabled` | `enabled` | `checked` | `required` | `invalid` | `valid` | `read-only` |

### Parent/Sibling
| `group-hover` | `group-focus` | `peer-invalid` | `peer-checked` | `in-focus` |

### Pseudo-Elements
| `before` | `after` | `placeholder` | `file` | `marker` | `selection` | `backdrop` |

### Children
| `*` (direct) | `**` (all descendants) |

### Attribute
| `aria-*` | `data-*` | `open` | `rtl` | `ltr` | `inert` |
