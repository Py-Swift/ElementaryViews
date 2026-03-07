# CLAUDE.md — ElementaryViews Project Rules

## Project Overview

ElementaryViews is a SwiftUI-inspired component library built on **ElementaryUI** (Swift WebAssembly framework) with **Tailwind CSS** styling. It provides reusable UI components, layout macros, and CSS helper types for building web applications in Swift.

## Research References

**ALWAYS cross-reference these before implementing new components or modifiers:**

- `research/elementary-ui/` — ElementaryUI framework guide (views, state, reactivity, events, animations)
- `research/SwiftUI-api/SwiftUI.swift` and `SwiftUICore.swift` — Full SwiftUI API reference (~109K lines)
- `research/tailwind_css/` — Tailwind CSS v4 utility class reference

## Code Conventions

### Component Pattern

All public view components use `@PublicView` (local clone of ElementaryUI's `@View` macro):

```swift
import ElementaryUI

@PublicView
public struct MyComponent {
    // stored properties (no default `public` needed — macro handles it)
    let text: String

    public init(text: String) {
        self.text = text
    }

    public var body: some View {
        span(.class("text-sm")) { text }
    }
}
```

### Generic View Components

Generic structs MUST set `typealias Tag` inside the struct body to bypass macro limitations:

```swift
@PublicView
public struct MyGenericView<Label: View> {
    let label: Label
    public typealias Tag = HTMLTag.div  // required for generic @PublicView structs

    public init(@HTMLBuilder label: () -> Label) {
        self.label = label()
    }

    public var body: some View {
        div { label }
    }
}
```

### CSS Composition

- CSS helper types (`CSSFontInfo`, `CSSBorderInfo`, `CSSPadding`, etc.) expose a `.css` computed property returning Tailwind classes
- Enum types use `.rawValue` for direct Tailwind class mapping
- Classes are string-interpolated into `.class(...)` HTML attributes
- **Never hardcode Tailwind classes** in components when a reusable CSS type exists

### Layout Macros

Freestanding expression macros for common layouts:

- `#HStack(alignment:spacing:wrap:)` → `div(.class("flex flex-row ..."))`
- `#VStack(alignment:spacing:)` → `div(.class("flex flex-col ..."))`
- `#Border(color:radius:padding:)` → `div(.class("border ..."))`
- `#Table(layout:)`, `#TableRow`, `#TableCell(width:)`

### State Management

Follows ElementaryUI patterns (same as SwiftUI):

- `@State` for local mutable state
- `@Binding` for parent-owned state (use `$` prefix for binding projection)
- `@Environment` for hierarchical value injection (requires `#Key(\.prop)` macro)

### Imports

- Components: `import ElementaryUI` (re-exports `Elementary`)
- Macros: `import SwiftSyntaxMacros`, `import SwiftCompilerPlugin`
- CSS enums: No imports needed (pure Swift)

## Testing Rules

### MANDATORY

- **ALWAYS create tests for new view components** — no exceptions
- **Verify tests pass** before considering work complete
- **Commit one successful view/component at a time**

### Test Strategy

1. **CSS Helper Tests** — Test `.css` / `.rawValue` output of all CSS enum/struct types
2. **Macro Expansion Tests** — Test `#HStack`, `#VStack`, etc. macro expansions using `SwiftSyntaxMacrosTestSupport`
3. **HTML Structure Tests** — Build equivalent HTML primitives (matching component `body` output) and verify via Elementary's `.render()` method

### Test Utilities

```swift
// For HTML rendering verification
import Elementary
import Testing

func HTMLExpect(_ html: some HTML, toBe expected: String) {
    #expect(html.render() == expected)
}
```

## File Organization

```
Sources/
  ElementaryViews/
    ViewMacros.swift          — Macro declarations + phantom types
    ViewModifiers.swift       — View extension methods
    Components/               — @PublicView component structs
    Enums/                    — CSS helper types (CSSFontInfo, CSSColorKey, etc.)
  ViewMacros/
    LayoutMacros.swift        — Macro implementations
    ViewMacro.swift           — @PublicView/@View macro implementation
Tests/
  ViewMacrosTests/            — Macro expansion tests
  ElementaryViewsTests/       — CSS + component tests
```

## Naming Conventions

- Components: PascalCase matching SwiftUI where possible (`Text`, `Button`, `Toggle`)
- Use `Web` prefix when name conflicts with HTML element types (`WebImage` not `Image`, `WebLink` not `Link`)
- CSS enums: `CSS` prefix (`CSSFontInfo`, `CSSColorKey`, `CSSShadow`)
- Tailwind classes: Use the canonical Tailwind v4 class names

## Common Patterns

### Conditional CSS classes

```swift
private var bgClass: String {
    if let bg_color { "bg-\(bg_color.rawValue)" } else { "" }
}
```

### HTML attributes

```swift
// Via initializer
div(.class("flex"), .id("main")) { ... }

// Via modifier (supports conditions)
div { ... }
    .attributes(.class("fancy"), when: isFancy)
```

### Event handling

```swift
button { "Click" }.onClick { doSomething() }
input(.type(.text)).bindValue($text)
input(.type(.checkbox)).bindChecked($isOn)
```
