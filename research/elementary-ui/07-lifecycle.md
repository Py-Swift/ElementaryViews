# Lifecycle Events

> **Source**: [elementary.codes/guide/essentials/lifecycle-events](https://elementary.codes/guide/essentials/lifecycle-events.html)

ElementaryUI provides lifecycle modifiers to perform side effects as views enter or leave the view hierarchy, or when a value changes over time.

## `onAppear`

Run an action when a view is first added to the hierarchy.

```swift
@View
struct MyView {
    var body: some View {
        div { "Hello" }
            .onAppear {
                print("View appeared!")
            }
    }
}
```

## `onDisappear`

Run an action when a view is removed from the hierarchy.

```swift
@View
struct MyView {
    var body: some View {
        div { "Goodbye" }
            .onDisappear {
                print("View disappeared!")
            }
    }
}
```

## `onChange`

Trigger an action whenever a specific value changes.

```swift
@View
struct CounterView {
    @State var count = 0

    var body: some View {
        button { "Increment" }
            .onClick { count += 1 }
            .onChange(of: count) {
                print("Count is now \(count)")
            }
    }
}
```

## `task`

Run an **asynchronous** operation when a view enters the hierarchy. The task is automatically **cancelled** when the view is removed.

```swift
@View
struct MyView {
    @State var data: String?

    var body: some View {
        div {
            if let data = data {
                data
            } else {
                "Loading..."
            }
        }
        .task {
            data = await fetchData()
        }
    }
}
```

## Summary

| Modifier | Trigger | Async | Auto-cancel |
|----------|---------|-------|-------------|
| `.onAppear { }` | View enters hierarchy | No | N/A |
| `.onDisappear { }` | View leaves hierarchy | No | N/A |
| `.onChange(of: value) { }` | Value changes | No | N/A |
| `.task { }` | View enters hierarchy | Yes | Yes (on removal) |
