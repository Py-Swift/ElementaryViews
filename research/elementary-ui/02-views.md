# Views

> **Source**: [elementary.codes/guide/essentials/views](https://elementary.codes/guide/essentials/views.html)

Views are the fundamental building blocks in ElementaryUI. You describe the user interface by composing views.

## Creating a View

Apply the `@View` macro to a plain `struct`. Define a `body` property that describes the view's content.

```swift
@View
struct Greeting {
    var name: String

    var body: some View {
        p { "Hello \(name)" }
    }
}
```

- Conforms to the [View](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/view) protocol
- The `@View` macro handles protocol conformance, state storage, etc.

## Composing Views

Build larger UI by nesting smaller views. This forms the **view hierarchy**.

```swift
@View
struct Screen {
    var body: some View {
        div {
            h1 { "Welcome, mighty pirate" }
            Greeting(name: "Guybrush Threepwood")
        }
    }
}
```

## HTML Elements are Views

ElementaryUI's HTML elements (`div`, `p`, `button`, `h1`, etc.) are views too — they participate in the same composition model as custom views. You can freely mix element views and custom views in the same hierarchy.

## Key Concepts

- **Views are throw-away values**: ElementaryUI rebuilds new copies of view values whenever state changes
- **Views describe UI**: They exist to describe what the UI should look like after state changes
- **Minimal DOM updates**: The framework compares the new view hierarchy and applies minimal updates to the DOM
- **No runtime reflection**: Uses compile-time macros instead (Embedded Swift compatible)
