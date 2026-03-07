# Animations

> **Sources**: 
> - [Transactions and Animations](https://elementary.codes/guide/animation/transactions-and-animations.html)
> - [Animatable Modifiers](https://elementary.codes/guide/animation/animatable-modifiers.html)
> - [Transitions](https://elementary.codes/guide/animation/transitions.html)
> - [Animate Layout and CSS](https://elementary.codes/guide/animation/animate-layout-and-css.html)
> - [Custom Animations](https://elementary.codes/guide/animation/custom-animations.html)

ElementaryUI's animation system is built on **transactions** — discrete units of change that flow through your application. Similar to SwiftUI's animation system.

## What Can Be Animated?

| Type | Description |
|------|-------------|
| **Built-in modifiers** | `opacity(_:)`, `offset(x:y:)`, `rotationEffect(_:anchor:)` |
| **Layout and CSS changes** | Via `animateContainerLayout()` — automatic FLIP animations |
| **Custom animations** | Views implementing the `Animatable` protocol |

All three participate in the same transaction-based animation system.

## Transactions

Every state change happens within a `Transaction`. A transaction represents a single logical update that may affect multiple views.

### Setting Animation on a Transaction

Two ways:

1. **`withAnimation` block** — wrap state mutations:

```swift
@State var isOffset = false

var body: some View {
    div {
        p { "🚀" }
            .offset(x: isOffset ? 190.0 : 0.0)
    }

    button { "Default" }
        .onClick {
            withAnimation {
                isOffset.toggle()
            }
        }

    button { "Bouncy" }
        .onClick {
            withAnimation(.bouncy.speed(0.5)) {
                isOffset.toggle()
            }
        }
}
```

2. **`.animation(_:value:)` modifier** — automatically animate when a value changes:

```swift
.animation(.snappy, value: items)
```

## Animation Types

| Type | Examples | Description |
|------|----------|-------------|
| **Springs** | `.snappy`, `.smooth`, `.bouncy` | Physics-based spring animations. Custom via `Spring` |
| **Unit Curves** | `.linear`, `.easeInOut` | Timing-curve based. Custom via `UnitCurve` |
| **Custom** | Implement `CustomAnimation` protocol | Fully custom animation logic |

### Modifying Animations

```swift
.bouncy.speed(0.5)    // Adjust speed
.smooth.delay(0.2)    // Add delay
```

### Interrupting and Stacking

- Velocity is preserved when animations are interrupted (new animations inherit current momentum)
- Animations stack seamlessly — smooth motion even when overlapping
- Especially noticeable with spring animations

## Animatable Modifiers

> 🚧 Section incomplete in official docs

Built-in animatable modifiers:

| Modifier | Description |
|----------|-------------|
| `opacity(_:)` | Animate opacity changes |
| `offset(x:y:)` | Animate position offset |
| `rotationEffect(_:anchor:)` | Animate rotation |

See: [opacity](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/view/opacity(_:)), [offset](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/view/offset(x:y:)), [rotationEffect](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/view/rotationeffect(_:anchor:))

## Transitions

> 🚧 Section incomplete in official docs

Apply transitions when views are inserted/removed from the hierarchy.

See: [Transition](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/transition), [transition(_:animation:)](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/view/transition(_:animation:))

## FLIP Animations (Layout and CSS)

FLIP (First, Last, Invert, Play) captures geometry/appearance before and after a change, then animates the difference.

### Animate Layout Containers

Enable FLIP on any HTML element with `animateContainerLayout()`:

```swift
@State var items: [Int] = []
@State var next = 1

func addItem() {
    items.append(next)
    next += 1
}

var body: some View {
    button { "Add" }
        .onClick { addItem() }

    button { "Shuffle" }
        .onClick { items.shuffle() }

    ul {
        ForEach(items.enumerated(), key: { "\($0.element)" }) { (index, item) in
            li { "Item \(item)" }
                .onClick { items.remove(at: index) }
        }
    }
    .animateContainerLayout()
    .animation(.snappy, value: items)
}
```

### Planned FLIP Features (Not Yet Implemented)

- Animate layout changes when a value changes (independent of children)
- Animate arbitrary CSS properties when a value changes
- `matchedGeometryEffect` by providing a stable identifier

## Custom Animations

> 🚧 Section incomplete in official docs

Implement the `Animatable` protocol for custom animation behavior.

See: [Animatable](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/animatable), [CustomAnimation](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation/elementaryui/customanimation)
