//
//  ConcreteShapeStyles.swift
//  ElementaryViews
//
//  Concrete ShapeStyle types matching SwiftUI's hierarchy:
//  ForegroundStyle, BackgroundStyle, HierarchicalShapeStyle,
//  TintShapeStyle, FillShapeStyle, AnyShapeStyle
//

import ElementaryUI

// MARK: - ForegroundStyle

/// The foreground style in the current context.
///
/// Analogous to SwiftUI's `ForegroundStyle`. Resolves to `currentColor`
/// via Tailwind's `text-current`, `bg-current`, etc.
///
/// Access via the static property: `.foreground`
/// ```swift
/// Text("Hello").foregroundStyle(.foreground)
/// ```
public struct ForegroundStyle: ShapeStyle, Sendable {

    public init() {}

    public var description: String { "current" }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> some ShapeStyle {
        "\(role.rawValue)-\(description)"
    }
}

// MARK: - BackgroundStyle

/// The background style in the current context.
///
/// Analogous to SwiftUI's `BackgroundStyle`. Resolves to `inherit`
/// via Tailwind's `bg-inherit`, `text-inherit`, etc.
///
/// Access via the static property: `.background`
/// ```swift
/// div { "content" }.backgroundStyle(.background)
/// ```
public struct BackgroundStyle: ShapeStyle, Sendable {

    public init() {}

    public var description: String { "inherit" }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> some ShapeStyle {
        "\(role.rawValue)-\(description)"
    }
}

// MARK: - HierarchicalShapeStyle

/// A shape style that maps to one of the numbered content styles.
///
/// Analogous to SwiftUI's `HierarchicalShapeStyle`. Maps hierarchy levels
/// to Tailwind CSS opacity utilities:
/// - `.primary`    → full opacity (opacity-100)
/// - `.secondary`  → reduced opacity (opacity-60)
/// - `.tertiary`   → further reduced (opacity-40)
/// - `.quaternary` → low opacity (opacity-25)
/// - `.quinary`    → very low opacity (opacity-15)
///
/// ```swift
/// Text("Hello").foregroundStyle(.secondary)
/// ```
public struct HierarchicalShapeStyle: ShapeStyle, Sendable {

    /// The hierarchy level (1 = primary, 2 = secondary, etc.)
    let level: Int

    init(level: Int) {
        self.level = level
    }

    // MARK: Static Instances

    /// A shape style that maps to the first level of the current content style.
    public static let primary = HierarchicalShapeStyle(level: 1)

    /// A shape style that maps to the second level of the current content style.
    public static let secondary = HierarchicalShapeStyle(level: 2)

    /// A shape style that maps to the third level of the current content style.
    public static let tertiary = HierarchicalShapeStyle(level: 3)

    /// A shape style that maps to the fourth level of the current content style.
    public static let quaternary = HierarchicalShapeStyle(level: 4)

    /// A shape style that maps to the fifth level of the current content style.
    public static let quinary = HierarchicalShapeStyle(level: 5)

    // MARK: Description

    /// Returns the Tailwind opacity class for this level.
    public var description: String {
        switch level {
        case 1: return "opacity-100"
        case 2: return "opacity-60"
        case 3: return "opacity-40"
        case 4: return "opacity-25"
        case 5: return "opacity-15"
        default: return "opacity-100"
        }
    }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> some ShapeStyle {
        "\(role.rawValue)-\(description)"
    }
}

// MARK: - TintShapeStyle

/// A style that reflects the current tint color.
///
/// Analogous to SwiftUI's `TintShapeStyle`. Resolves to the app's
/// accent/tint color from the environment. In Tailwind CSS, this
/// maps to the `accent-*` utility or a configured accent color.
///
/// Access via the static property: `.tint`
/// ```swift
/// Button("Action").foregroundStyle(.tint)
/// ```
public struct TintShapeStyle: ShapeStyle, Sendable {

    public init() {}

    /// Returns `"accent"` as the default tint description.
    public var description: String { "accent" }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> some ShapeStyle {
        "\(role.rawValue)-\(description)"
    }
}

// MARK: - FillShapeStyle

/// A shape style that displays one of the overlay fills.
///
/// Analogous to SwiftUI's `FillShapeStyle`. Used for overlay fills on
/// shapes — an overlay fill incorporates transparency to allow the
/// background color to show through.
///
/// In Tailwind CSS, this maps to `fill-current` for SVG contexts.
public struct FillShapeStyle: ShapeStyle, Sendable {

    public init() {}

    public var description: String { "current" }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> some ShapeStyle {
        "\(role.rawValue)-\(description)"
    }
}

// MARK: - AnyShapeStyle

/// A type-erased ShapeStyle value.
///
/// Analogous to SwiftUI's `AnyShapeStyle`. Wraps any `ShapeStyle`
/// conforming type, forwarding `resolve` and `description` calls.
///
/// ```swift
/// let style: AnyShapeStyle = AnyShapeStyle(Color.red)
/// ```
public struct AnyShapeStyle: ShapeStyle, Sendable {

    private let _description: String
    private let _resolve: @Sendable (EnvironmentValues?, CSSStyleRole) -> String

    /// Create an instance from `style`.
    public init<S: ShapeStyle>(_ style: S) {
        self._description = style.description
        self._resolve = { env, role in
            style.resolve(in: env, for: role).description
        }
    }

    public var description: String { _description }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> some ShapeStyle {
        _resolve(environment, role)
    }
}
