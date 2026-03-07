//
//  ShapeStyle.swift
//  ElementaryViews
//
import ElementaryUI
/// The context in which a `ShapeStyle` is applied, mapping to a Tailwind CSS utility prefix.
public enum CSSStyleRole: String, Sendable {
    /// Text color: `text-{value}`
    case text = "text"
    /// Background color: `bg-{value}`
    case background = "bg"
    /// Border color: `border-{value}`
    case border = "border"
    /// Ring color: `ring-{value}`
    case ring = "ring"
    /// Fill (SVG): `fill-{value}`
    case fill = "fill"
    /// Stroke (SVG): `stroke-{value}`
    case stroke = "stroke"
}

/// A type that can produce CSS class strings for styling shapes and views.
///
/// Analogous to SwiftUI's `ShapeStyle` protocol. Conforming types represent
/// visual styles (colors, gradients, etc.) that can be applied to foreground,
/// background, border, and other styling contexts via Tailwind CSS classes.
///
/// ## Conforming Types
/// - ``CSSColorKey`` — Named Tailwind color palette entries (e.g., `.blue_500`)
/// - ``Color`` — Custom RGBA colors with arbitrary CSS values
public protocol ShapeStyle: Sendable, CustomStringConvertible {
    /// Returns the Tailwind CSS class for this style in the given role context.
    ///
    /// For example, a blue color might return:
    /// - `"text-blue-500"` for `.text`
    /// - `"bg-blue-500"` for `.background`
    /// - `"border-blue-500"` for `.border`
    
    associatedtype Resolved : ShapeStyle = Never
    
    func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> Self.Resolved
}

extension StringProtocol where Self: ShapeStyle {
    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> Self {
        "\(role.rawValue)-\(self)"
    }
}

extension String: ShapeStyle {}

// MARK: - Static Style Accessors

extension ShapeStyle where Self == ForegroundStyle {
    /// The foreground style in the current context.
    public static var foreground: ForegroundStyle { ForegroundStyle() }
}

extension ShapeStyle where Self == BackgroundStyle {
    /// The background style in the current context.
    public static var background: BackgroundStyle { BackgroundStyle() }
}

extension ShapeStyle where Self == HierarchicalShapeStyle {
    /// A shape style that maps to the first level of the current content style.
    public static var primary: HierarchicalShapeStyle { HierarchicalShapeStyle(level: 1) }

    /// A shape style that maps to the second level of the current content style.
    public static var secondary: HierarchicalShapeStyle { HierarchicalShapeStyle(level: 2) }

    /// A shape style that maps to the third level of the current content style.
    public static var tertiary: HierarchicalShapeStyle { HierarchicalShapeStyle(level: 3) }

    /// A shape style that maps to the fourth level of the current content style.
    public static var quaternary: HierarchicalShapeStyle { HierarchicalShapeStyle(level: 4) }

    /// A shape style that maps to the fifth level of the current content style.
    public static var quinary: HierarchicalShapeStyle { HierarchicalShapeStyle(level: 5) }
}

extension ShapeStyle where Self == TintShapeStyle {
    /// A style that reflects the current tint color.
    public static var tint: TintShapeStyle { TintShapeStyle() }
}

