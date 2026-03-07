//
//  Shape.swift
//  ElementaryViews
//
import ElementaryUI

/// A type that represents a geometric shape, usable as a `View`.
///
/// Shapes have two rendering modes:
///
/// 1. **CSS mode** — The `css` property returns Tailwind classes for
///    border-radius, aspect-ratio, etc. This is used when a shape acts
///    as an HTML view element (div with rounded corners, etc.).
///
/// 2. **Canvas mode** — The `path(in:)` method returns a `Path` describing
///    the shape's geometry for drawing on an HTML `<canvas>`. This enables
///    real vector drawing via the Canvas 2D API.
///
/// ```swift
/// // CSS mode — use shape as a clipping/styling view:
/// Circle()
///     .backgroundStyle(Color.blue)
///     .frame(width: "16", height: "16")
///
/// // Canvas mode — draw shape on a canvas:
/// let path = Circle().path(in: Rect(x: 0, y: 0, width: 100, height: 100))
/// Canvas(width: 100, height: 100) { context, size in
///     context.fill(path, with: .color(.blue))
/// }
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

    /// Describes this shape as a `Path` within the given rectangle.
    ///
    /// Used for canvas rendering. The default implementation returns
    /// a rectangle path matching the bounding rect.
    func path(in rect: Rect) -> Path
}

/// Default path implementation for shapes — fills the entire rect.
extension Shape {
    public func path(in rect: Rect) -> Path {
        Path(rect)
    }
}

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

    public func path(in rect: Rect) -> Path {
        Path(rect)
    }
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

    public func path(in rect: Rect) -> Path {
        // Map CSS corner radius to approximate pixel values
        let r: Double = switch cornerRadius {
        case .none: 0
        case .sm: 2
        case .md: 6
        case .lg: 8
        case .xl: 12
        case .xl2: 16
        case .xl3: 24
        case .full: min(rect.width, rect.height) / 2
        }
        return Path(roundedRect: rect, cornerRadius: r)
    }
}

/// A circular shape (equal width and height with full border-radius).
///
/// Produces `rounded-full aspect-square` Tailwind classes.
@PublicView
public struct Circle: Shape {
    public init() {}
    public var css: String { "rounded-full aspect-square" }

    public func path(in rect: Rect) -> Path {
        Path(ellipseIn: rect)
    }
}

/// A pill-shaped element with fully rounded ends.
///
/// Produces the `rounded-full` Tailwind class.
@PublicView
public struct Capsule: Shape {
    public init() {}
    public var css: String { "rounded-full" }

    public func path(in rect: Rect) -> Path {
        let r = min(rect.width, rect.height) / 2
        return Path(roundedRect: rect, cornerRadius: r)
    }
}
