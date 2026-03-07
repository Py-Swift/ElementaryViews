# Environment

> **Source**: [elementary.codes/guide/essentials/environment](https://elementary.codes/guide/essentials/environment.html)

The view environment is a mechanism for providing values to a view hierarchy without having to explicitly pass them to every view.

## Defining and Providing Values

Extend `EnvironmentValues` and use the `@Entry` macro to define a custom environment property:

```swift
extension EnvironmentValues {
    @Entry var themeColor: String = "blue"
}
```

Provide a value using the `environment(_:_:)` modifier. The value is accessible to all views down the hierarchy.

```swift
MyView()
    .environment(#Key(\.themeColor), "rebeccapurple")
```

> **Note**: Since key paths cannot be used in Embedded Swift, you must wrap them with the `#Key(_:)` macro for runtime use.

## Using Environment Values in a View

Access values with the `@Environment` property wrapper:

```swift
@View
struct Greeting {
    @Environment(#Key(\.themeColor)) var color

    var body: some View {
        p(.style(["color": color])) { "Hello" }
    }
}
```

> **Note**: `@Environment` only works in types annotated with the `@View` macro.

## Reactive Objects in Environment

Pass `@Reactive` objects directly in the environment. The object's type acts as the environment key.

```swift
@Reactive
final class UserProfile {
    var name: String = "Anonymous"
}

// Providing the object
let profile = UserProfile()
ContentView()
    .environment(profile)

// Reading the object in a sub view
@View
struct ProfileHeader {
    @Environment(UserProfile.self) var profile

    var body: some View {
        p {
            "User: \(profile.name)"
        }
    }
}
```

## Quick Reference

| Pattern | Syntax |
|---------|--------|
| Define entry | `@Entry var myProp: Type = default` in `extension EnvironmentValues` |
| Provide value | `.environment(#Key(\.myProp), value)` |
| Read value | `@Environment(#Key(\.myProp)) var myProp` |
| Provide reactive object | `.environment(myObject)` |
| Read reactive object | `@Environment(MyType.self) var obj` |
