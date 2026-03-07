# Rendering (Conditional & List)

> **Sources**: 
> - [Conditional Rendering](https://elementary.codes/guide/essentials/conditional-rendering.html)
> - [List Rendering](https://elementary.codes/guide/essentials/list-rendering.html)

## Conditional Rendering

Use Swift's familiar result builder control flow inside your `body`.

### `if`

```swift
@View
struct IfView {
    @State var shouldShow = false

    var body: some View {
        button { "Toggle" }
            .onClick { shouldShow.toggle() }

        if shouldShow {
            span { " Hello, world!" }
        }
    }
}
```

### `if / else`

```swift
if isLoggedIn {
    LogOutButton()
} else {
    LogInButton()
}
```

### `switch`

```swift
switch state {
case .loading:
    "Loading…"
case .error:
    "Something went wrong."
case .ready:
    Content()
}
```

## List Rendering

### `ForEach` (with Stable Keys)

Use `ForEach` when you need a stable key for list items (reordering, insertions, animations).
Supports `Identifiable` elements or a `key` closure.

```swift
@State var items = [String]()
@State var next = 1

var body: some View {
    button { "Add" }
        .onClick {
            items.insert("Item \(next)", at: 0)
            next += 1
        }

    ul {
        ForEach(items.enumerated(), key: { $0.element }) { item in
            li { item.element }
                .onClick {
                    items.remove(at: item.offset)
                }
        }
    }
}
```

> **Note**: For Embedded Swift support, only types that are `LosslessStringConvertible` can be used as keys. Keys are compared by their UTF8 representations.

### `for ... in` (Simple Iteration)

For simple cases where stable identity doesn't matter:

```swift
div {
    for item in items {
        p { item.title }
    }
}
```
