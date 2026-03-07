# HTML Elements & DOM Interaction

> **Sources**: 
> - [HTML Elements](https://elementary.codes/guide/dom-interaction/html-elements.html)
> - [Input Bindings](https://elementary.codes/guide/dom-interaction/input-bindings.html)
> - [Handling Events](https://elementary.codes/guide/dom-interaction/handling-events.html)

## HTML Elements

HTML elements in ElementaryUI are [views](https://elementary.codes/guide/essentials/views.html) — types that compose into your view hierarchy.

> The HTML element types come from the [elementary](https://github.com/elementary-swift/elementary) package, which provides the low-level rendering primitives.

### Using HTML in Views

Build HTML using lower-case types: `div`, `p`, `button`, `h1`, `span`, `ul`, `li`, `input`, etc.

```swift
@View
struct MyView {
    var body: some View {
        div {
            h1 { "Title" }
            p { "Paragraph text" }
            button { "Click me" }
        }
    }
}
```

### Attributes

Set HTML attributes via the element's initializer:

```swift
div(.class("container"), .id("main")) {
    p(.style(["color": "crimson"])) {
        "Styled text"
    }
    input(.type(.text), .placeholder("Enter something"))
}
```

Attributes can also be set via modifier syntax (supports conditional attributes):

```swift
div {
    p { "Hello" }
        .attributes(.id("maybe-fancy"))
        .attributes(.class("fancy"), when: isFancy)
}
```

## Input Bindings

> 🚧 Section incomplete in official docs

Two-way data binding for form elements:

| Modifier | Purpose |
|----------|---------|
| `.bindValue($stateVar)` | Bind input/textarea value to state |
| `.bindChecked($boolVar)` | Bind checkbox checked state |

See: [bindValue(_:)](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/view/bindvalue(_:)), [bindChecked(_:)](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/view/bindchecked(_:))

## Handling Events

ElementaryUI provides `onEvent` modifiers to handle DOM events like clicks, key presses, or mouse events.

> 🚧 Section incomplete in official docs

### Mouse Events

```swift
@State var x = 0.0
@State var y = 0.0

var body: some View {
    div {
        p { "Move your mouse over this area" }
        p { "X: \(x), Y: \(y)" }
    }
    .onMouseMove { event in
        x = event.offsetX
        y = event.offsetY
    }
}
```

### Common Event Modifiers

| Modifier | Event |
|----------|-------|
| `.onClick { }` | Click / tap |
| `.onMouseMove { event in }` | Mouse movement |
| `.onKeyDown { event in }` | Key press |
| `.onInput { event in }` | Input value change |
| `.onSubmit { event in }` | Form submission |

## Common HTML Elements

| Element | Usage |
|---------|-------|
| `div { }` | Generic container |
| `p { }` | Paragraph |
| `span { }` | Inline container |
| `h1 { }` ... `h6 { }` | Headings |
| `button { }` | Button |
| `a(.href("url")) { }` | Link |
| `img(.src("url"))` | Image |
| `input(.type(.text))` | Input field |
| `ul { }` / `ol { }` | Lists |
| `li { }` | List item |
| `form { }` | Form |
| `table { }` / `tr { }` / `td { }` | Table elements |
