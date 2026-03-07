# Application

> **Source**: [elementary.codes/guide/essentials/application](https://elementary.codes/guide/essentials/application.html)

The [Application](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/application) type defines an entry-point into your app. It holds your root view (the start of the view hierarchy) and drives rendering.

## Mounting an Application

Mounting attaches the rendered output to the DOM. After mounting, ElementaryUI keeps the DOM in sync as views change.

```swift
@main
struct MyApp {
    static func main() {
        Application(ContentView())
            .mount(in: .body)
    }
}
```

### CSS Selector Mounting

`mount(in:)` supports arbitrary CSS selectors:

```swift
Application(ContentView())
    .mount(in: "#app")
```

## Multiple Applications (Islands)

You can create and mount multiple independent applications on the same page — useful for adding "islands" of interactivity to an otherwise static page.

```swift
@main
struct IslandsApp {
    static func main() {
        Application(Navigation())
            .mount(in: "#nav-container")

        Application(CommentsSection())
            .mount(in: "#comments-island")
    }
}
```

Each `mount(in:)` call creates an **independent** application instance with its own state and lifecycle.
