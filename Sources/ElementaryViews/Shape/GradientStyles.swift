//
//  GradientStyles.swift
//  ElementaryViews
//
//  ShapeStyle-conforming gradient types:
//  LinearGradient, RadialGradient, AngularGradient
//
//  Maps SwiftUI gradient APIs to Tailwind CSS gradient utilities:
//  - bg-linear-to-{dir}  + from-/via-/to- color stops
//  - bg-radial            + from-/via-/to- color stops
//  - bg-conic             + from-/via-/to- color stops
//

import ElementaryUI

// MARK: - UnitPoint Accessors

extension UnitPoint {
    /// Public accessor for the internal `x` coordinate.
    public func getX() -> Float {
        withUnsafeBytes(of: self) { buf in
            buf.load(fromByteOffset: 0, as: Float.self)
        }
    }

    /// Public accessor for the internal `y` coordinate.
    public func getY() -> Float {
        withUnsafeBytes(of: self) { buf in
            buf.load(fromByteOffset: MemoryLayout<Float>.size, as: Float.self)
        }
    }
}

// MARK: - LinearGradient

/// A linear gradient that transitions between colors along a line.
///
/// Analogous to SwiftUI's `LinearGradient`. Maps to Tailwind CSS
/// `bg-linear-to-{direction}` with `from-`, `via-`, `to-` color stops.
///
/// ```swift
/// // Left-to-right gradient with Color values
/// LinearGradient(
///     colors: [.red, .blue],
///     startPoint: .leading,
///     endPoint: .trailing
/// )
/// // → "bg-linear-to-r from-[#ff3b30] to-[#007aff]"
///
/// // Three-stop gradient with CSSColorKey values
/// LinearGradient(
///     cssColors: [.indigo_500, .purple_500, .pink_500],
///     startPoint: .topLeading,
///     endPoint: .bottomTrailing
/// )
/// // → "bg-linear-to-br from-indigo-500 via-purple-500 to-pink-500"
/// ```
public struct LinearGradient: ShapeStyle, Equatable, Sendable {

    /// The gradient's color stops.
    public let gradient: Gradient

    /// Where the gradient begins.
    public let startPoint: UnitPoint

    /// Where the gradient ends (determines the Tailwind direction).
    public let endPoint: UnitPoint

    // MARK: - Initializers

    /// Creates a linear gradient from a `Gradient`, start point, and end point.
    public init(gradient: Gradient, startPoint: UnitPoint, endPoint: UnitPoint) {
        self.gradient = gradient
        self.startPoint = startPoint
        self.endPoint = endPoint
    }

    /// Creates a linear gradient from an array of `Color` values.
    public init(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) {
        self.init(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
    }

    /// Creates a linear gradient from an array of `Gradient.Stop` values.
    public init(stops: [Gradient.Stop], startPoint: UnitPoint, endPoint: UnitPoint) {
        self.init(gradient: Gradient(stops: stops), startPoint: startPoint, endPoint: endPoint)
    }

    /// Creates a linear gradient from an array of `CSSColorKey` values.
    public init(cssColors: [CSSColorKey], startPoint: UnitPoint, endPoint: UnitPoint) {
        self.init(gradient: Gradient(cssColors: cssColors), startPoint: startPoint, endPoint: endPoint)
    }

    // MARK: - ShapeStyle

    public var description: String {
        "linearGradient(\(tailwindDirectionSuffix(for: endPoint)))"
    }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> some ShapeStyle {
        var parts = ["bg-linear-to-\(tailwindDirectionSuffix(for: endPoint))"]
        let stops = gradient.cssStopClasses
        if !stops.isEmpty { parts.append(stops) }
        if role == .text {
            parts.append("bg-clip-text text-transparent")
        }
        return parts.joined(separator: " ")
    }
}

// MARK: - RadialGradient

/// A radial gradient that transitions between colors radiating from a center point.
///
/// Analogous to SwiftUI's `RadialGradient`. Maps to Tailwind CSS
/// `bg-radial` with `from-`, `via-`, `to-` color stops.
///
/// ```swift
/// RadialGradient(
///     colors: [.yellow, .red],
///     center: .center
/// )
/// // → "bg-radial from-[#ffcc00] to-[#ff3b30]"
///
/// RadialGradient(
///     cssColors: [.blue_400, .blue_900],
///     center: .topLeading
/// )
/// // → "bg-radial-[at_0%_0%] from-blue-400 to-blue-900"
/// ```
public struct RadialGradient: ShapeStyle, Equatable, Sendable {

    /// The gradient's color stops.
    public let gradient: Gradient

    /// The center point of the radial gradient.
    public let center: UnitPoint

    // MARK: - Initializers

    /// Creates a radial gradient from a `Gradient` and center point.
    public init(gradient: Gradient, center: UnitPoint) {
        self.gradient = gradient
        self.center = center
    }

    /// Creates a radial gradient from an array of `Color` values.
    public init(colors: [Color], center: UnitPoint) {
        self.init(gradient: Gradient(colors: colors), center: center)
    }

    /// Creates a radial gradient from an array of `Gradient.Stop` values.
    public init(stops: [Gradient.Stop], center: UnitPoint) {
        self.init(gradient: Gradient(stops: stops), center: center)
    }

    /// Creates a radial gradient from an array of `CSSColorKey` values.
    public init(cssColors: [CSSColorKey], center: UnitPoint) {
        self.init(gradient: Gradient(cssColors: cssColors), center: center)
    }

    // MARK: - ShapeStyle

    public var description: String { "radialGradient" }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> some ShapeStyle {
        var parts: [String] = []

        if let pos = cssPosition(for: center) {
            parts.append("bg-radial-[\(pos)]")
        } else {
            parts.append("bg-radial")
        }

        let stops = gradient.cssStopClasses
        if !stops.isEmpty { parts.append(stops) }

        if role == .text {
            parts.append("bg-clip-text text-transparent")
        }

        return parts.joined(separator: " ")
    }
}

// MARK: - AngularGradient

/// A conic (angular) gradient that transitions between colors around a center point.
///
/// Analogous to SwiftUI's `AngularGradient`. Maps to Tailwind CSS
/// `bg-conic` with `from-`, `via-`, `to-` color stops.
///
/// ```swift
/// // Simple conic gradient
/// AngularGradient(
///     colors: [.red, .yellow, .green, .blue, .red],
///     center: .center
/// )
/// // → "bg-conic from-[#ff3b30] via-[#ffcc00] via-[#34c759] via-[#007aff] to-[#ff3b30]"
///
/// // With starting angle (degrees)
/// AngularGradient(
///     cssColors: [.blue_500, .purple_500],
///     center: .center,
///     angleDegrees: 90
/// )
/// // → "bg-conic-[from_90deg] from-blue-500 to-purple-500"
/// ```
public struct AngularGradient: ShapeStyle, Equatable, Sendable {

    /// The gradient's color stops.
    public let gradient: Gradient

    /// The center point of the conic gradient.
    public let center: UnitPoint

    /// The starting angle offset in degrees (0° = top, clockwise).
    public let angleDegrees: Double

    // MARK: - Initializers

    /// Creates a conic gradient from a `Gradient`, center, and starting angle in degrees.
    public init(gradient: Gradient, center: UnitPoint, angleDegrees: Double = 0) {
        self.gradient = gradient
        self.center = center
        self.angleDegrees = angleDegrees
    }

    /// Creates a conic gradient from an array of `Color` values.
    public init(colors: [Color], center: UnitPoint, angleDegrees: Double = 0) {
        self.init(gradient: Gradient(colors: colors), center: center, angleDegrees: angleDegrees)
    }

    /// Creates a conic gradient from an array of `Gradient.Stop` values.
    public init(stops: [Gradient.Stop], center: UnitPoint, angleDegrees: Double = 0) {
        self.init(gradient: Gradient(stops: stops), center: center, angleDegrees: angleDegrees)
    }

    /// Creates a conic gradient from an array of `CSSColorKey` values.
    public init(cssColors: [CSSColorKey], center: UnitPoint, angleDegrees: Double = 0) {
        self.init(gradient: Gradient(cssColors: cssColors), center: center, angleDegrees: angleDegrees)
    }

    // MARK: - ShapeStyle

    public var description: String { "angularGradient" }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> some ShapeStyle {
        var parts: [String] = []

        let hasAngle = abs(angleDegrees) > 0.01
        let pos = cssPosition(for: center)

        if hasAngle && pos != nil {
            parts.append("bg-conic-[from_\(Int(angleDegrees.rounded()))deg_\(pos!)]")
        } else if hasAngle {
            parts.append("bg-conic-[from_\(Int(angleDegrees.rounded()))deg]")
        } else if let pos = pos {
            parts.append("bg-conic-[\(pos)]")
        } else {
            parts.append("bg-conic")
        }

        let stops = gradient.cssStopClasses
        if !stops.isEmpty { parts.append(stops) }

        if role == .text {
            parts.append("bg-clip-text text-transparent")
        }

        return parts.joined(separator: " ")
    }
}

// MARK: - Static ShapeStyle Accessors

extension ShapeStyle where Self == LinearGradient {
    /// Creates a linear gradient shape style.
    public static func linearGradient(
        _ gradient: Gradient,
        startPoint: UnitPoint,
        endPoint: UnitPoint
    ) -> LinearGradient {
        LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
    }

    /// Creates a linear gradient shape style from colors.
    public static func linearGradient(
        colors: [Color],
        startPoint: UnitPoint,
        endPoint: UnitPoint
    ) -> LinearGradient {
        LinearGradient(colors: colors, startPoint: startPoint, endPoint: endPoint)
    }

    /// Creates a linear gradient shape style from gradient stops.
    public static func linearGradient(
        stops: [Gradient.Stop],
        startPoint: UnitPoint,
        endPoint: UnitPoint
    ) -> LinearGradient {
        LinearGradient(stops: stops, startPoint: startPoint, endPoint: endPoint)
    }
}

extension ShapeStyle where Self == RadialGradient {
    /// Creates a radial gradient shape style.
    public static func radialGradient(
        _ gradient: Gradient,
        center: UnitPoint
    ) -> RadialGradient {
        RadialGradient(gradient: gradient, center: center)
    }

    /// Creates a radial gradient shape style from colors.
    public static func radialGradient(
        colors: [Color],
        center: UnitPoint
    ) -> RadialGradient {
        RadialGradient(colors: colors, center: center)
    }

    /// Creates a radial gradient shape style from gradient stops.
    public static func radialGradient(
        stops: [Gradient.Stop],
        center: UnitPoint
    ) -> RadialGradient {
        RadialGradient(stops: stops, center: center)
    }
}

extension ShapeStyle where Self == AngularGradient {
    /// Creates a conic gradient shape style.
    public static func conicGradient(
        _ gradient: Gradient,
        center: UnitPoint,
        angleDegrees: Double = 0
    ) -> AngularGradient {
        AngularGradient(gradient: gradient, center: center, angleDegrees: angleDegrees)
    }

    /// Creates a conic gradient shape style from colors.
    public static func conicGradient(
        colors: [Color],
        center: UnitPoint,
        angleDegrees: Double = 0
    ) -> AngularGradient {
        AngularGradient(colors: colors, center: center, angleDegrees: angleDegrees)
    }

    /// Creates a conic gradient shape style from gradient stops.
    public static func conicGradient(
        stops: [Gradient.Stop],
        center: UnitPoint,
        angleDegrees: Double = 0
    ) -> AngularGradient {
        AngularGradient(stops: stops, center: center, angleDegrees: angleDegrees)
    }
}

// MARK: - Private Helpers

/// Maps a `UnitPoint` endPoint to a Tailwind linear gradient direction suffix.
///
/// Matches the 8 standard directions (r, l, t, b, tr, br, tl, bl).
/// Falls back to "b" (bottom) for non-standard points.
func tailwindDirectionSuffix(for point: UnitPoint) -> String {
    let tol: Float = 0.01
    let px = point.getX(), py = point.getY()
    func eq(_ a: Float, _ b: Float) -> Bool { abs(a - b) < tol }

    if eq(px, 1) && eq(py, 0.5) { return "r" }
    if eq(px, 0) && eq(py, 0.5) { return "l" }
    if eq(px, 0.5) && eq(py, 0) { return "t" }
    if eq(px, 0.5) && eq(py, 1) { return "b" }
    if eq(px, 1) && eq(py, 0) { return "tr" }
    if eq(px, 1) && eq(py, 1) { return "br" }
    if eq(px, 0) && eq(py, 0) { return "tl" }
    if eq(px, 0) && eq(py, 1) { return "bl" }

    // Default to bottom for non-standard directions
    return "b"
}

/// Maps a `UnitPoint` to a Tailwind CSS position string for radial/conic gradients.
///
/// Returns nil for center (the default), or `"at_{x}%_{y}%"` for other positions.
func cssPosition(for point: UnitPoint) -> String? {
    let tol: Float = 0.01
    let px = point.getX(), py = point.getY()
    func eq(_ a: Float, _ b: Float) -> Bool { abs(a - b) < tol }

    // Center is the default — no position needed
    if eq(px, 0.5) && eq(py, 0.5) { return nil }

    return "at_\(Int(px * 100))%_\(Int(py * 100))%"
}
