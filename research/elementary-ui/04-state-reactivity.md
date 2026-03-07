# State and Reactivity

> **Source**: [elementary.codes/guide/essentials/state-and-reactivity](https://elementary.codes/guide/essentials/state-and-reactivity.html)

Views are throw-away values that describe UI after state changes, so the framework can determine minimal DOM updates. If you know SwiftUI, you should feel right at home.

## `@State`

Declares local, mutable state for a view. Any view derived from this state is automatically re-evaluated when it's updated.

```swift
@View
struct TinyCounter {
    @State var count = 1

    var body: some View {
        button { "Count: \(count)" }
            .onClick { count += 1 }
    }
}
```

### State Lifetime
- Initialized when the view first appears in the hierarchy
- Kept alive as long as the view remains mounted
- Released when the view is removed from the hierarchy

## `@Reactive`

Define a reference type that can be used as view state — essentially `@Observable` but with **Embedded Swift support**.

Any view that accesses properties in its `body` will automatically re-evaluate when those properties change.

```swift
@Reactive
final class CounterModel {
    private var count = 0

    var label: String { "Count: \(count)" }

    func increment() {
        count += 1
    }

    func reset() {
        count = 0
    }
}

@View
struct ReactiveCounter {
    var model: CounterModel

    var body: some View {
        button { model.label }
            .onClick { model.increment() }
        button { "Reset" }
            .onClick { model.reset() }
    }
}
```

## `@Binding`

Read/write state owned by a parent view. Use the `$` syntax on `@State` variables to create a binding.

```swift
@View
struct BindingCounterButton {
    @State var count = 0

    var body: some View {
        CounterButton(prefix: "Pirates:", count: $count)
    }
}

@View
struct CounterButton {
    var prefix: String
    @Binding var count: Int

    var body: some View {
        button { "\(prefix) \(count)" }
            .onClick { count += 1 }
    }
}
```

## Summary Table

| Wrapper | Purpose | Scope | Embedded Swift |
|---------|---------|-------|----------------|
| `@State` | Local mutable state | Single view | Yes |
| `@Binding` | Read/write parent state | Child view | Yes |
| `@Reactive` | Observable reference type | Shared across views | Yes |
| `@Environment` | Hierarchical value injection | View subtree | Yes |
