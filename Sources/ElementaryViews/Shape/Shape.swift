//
//  Shape.swift
//  ElementaryViews
//

/// A type that represents a geometric shape via CSS classes.
///
/// Analogous to SwiftUI's `Shape` protocol. In the web/Tailwind CSS context,
/// shapes produce CSS utility classes for border-radius, aspect-ratio, and
/// clip-path rather than drawing bezier paths.
///
/// ## Conforming Types
/// - ``Rectangle`` — Default block shape (no border-radius)
/// - ``RoundedRectangle`` — Shape with configurable corner radius
/// - ``Circle`` — Fully rounded shape with equal aspect ratio
/// - ``Capsule`` — Fully rounded shape (pill-shaped)
public protocol Shape: Sendable {
    /// The Tailwind CSS classes that create this shape's geometry.
    var css: String { get }
}

// MARK: - Concrete Shape Types

/// A rectangular shape with no border-radius.
///
/// Block-level HTML elements are rectangular by default, so this shape
/// produces no additional CSS classes.
public struct Rectangle: Shape, Sendable {
    public init() {}
    public var css: String { "" }
}

/// A rectangular shape with configurable corner radius.
///
/// Uses Tailwind's `rounded-{size}` utility classes.
public struct RoundedRectangle: Shape, Sendable {
    public let cornerRadius: CSSCornerRadius

    public init(cornerRadius: CSSCornerRadius) {
        self.cornerRadius = cornerRadius
    }

    public var css: String { cornerRadius.rawValue }
}

/// A circular shape (equal width and height with full border-radius).
///
/// Produces `rounded-full aspect-square` Tailwind classes.
public struct Circle: Shape, Sendable {
    public init() {}
    public var css: String { "rounded-full aspect-square" }
}

/// A pill-shaped element with fully rounded ends.
///
/// Produces the `rounded-full` Tailwind class.
public struct Capsule: Shape, Sendable {
    public init() {}
    public var css: String { "rounded-full" }
}
