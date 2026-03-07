//
//  Shape.swift
//  ElementaryViews
//
import ElementaryUI

/// A type that represents a geometric shape via CSS classes, usable as a `View`.
///
/// Analogous to SwiftUI's `Shape` protocol. In the web/Tailwind CSS context,
/// shapes produce CSS utility classes for border-radius, aspect-ratio, and
/// clip-path rather than drawing bezier paths.
///
/// All shapes are views — they render as a `<div>` with their CSS classes applied.
/// Use style modifiers like `.backgroundStyle()` or `.fill()` to color them.
///
/// ```swift
/// // Use a shape directly in a view body:
/// Circle()
///     .backgroundStyle(Color.blue)
///     .frame(width: "16", height: "16")
/// ```
///
/// ## Conforming Types
/// - ``Rectangle`` — Default block shape (no border-radius)
/// - ``RoundedRectangle`` — Shape with configurable corner radius
/// - ``Circle`` — Fully rounded shape with equal aspect ratio
/// - ``Capsule`` — Fully rounded shape (pill-shaped)
public protocol Shape: Sendable, HTML {
    /// The Tailwind CSS classes that create this shape's geometry.
    var css: String { get }
}

///// Default body for all shapes — renders as a `<div>` with the shape's CSS classes.
//extension Shape {
//    @HTMLBuilder
//    public var body: some View {
//        div(.class(css)) { "" }
//    }
//}

// MARK: - Concrete Shape Types

/// A rectangular shape with no border-radius.
///
/// Block-level HTML elements are rectangular by default, so this shape
/// produces no additional CSS classes.
@PublicView
public struct Rectangle {
    
    
    public init() {}
    
    
    public var body: some View {
        
    }
}

extension Rectangle: Shape {
    public var css: String { "" }
}

/// A rectangular shape with configurable corner radius.
///
/// Uses Tailwind's `rounded-{size}` utility classes.
@PublicView
public struct RoundedRectangle: Shape {
    public let cornerRadius: CSSCornerRadius

    public init(cornerRadius: CSSCornerRadius) {
        self.cornerRadius = cornerRadius
    }

    public var css: String { cornerRadius.rawValue }
}

/// A circular shape (equal width and height with full border-radius).
///
/// Produces `rounded-full aspect-square` Tailwind classes.
@PublicView
public struct Circle: Shape {
    public init() {}
    public var css: String { "rounded-full aspect-square" }
}

/// A pill-shaped element with fully rounded ends.
///
/// Produces the `rounded-full` Tailwind class.
@PublicView
public struct Capsule: Shape {
    public init() {}
    public var css: String { "rounded-full" }
}
