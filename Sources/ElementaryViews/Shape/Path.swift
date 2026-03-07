//
//  Path.swift
//  ElementaryViews
//
//  A SwiftUI-compatible path type for defining 2D shapes.
//  Stores path elements as pure Swift data — no JS dependency.
//  Used by Canvas2DContext to draw shapes on HTML <canvas>.
//

import Foundation

// MARK: - Angle

/// An angle measurement (radians / degrees), matching SwiftUI's `Angle`.
public struct Angle: Sendable, Hashable {
    public var radians: Double

    public var degrees: Double {
        get { radians * 180 / .pi }
        set { radians = newValue * .pi / 180 }
    }

    public init(radians: Double) {
        self.radians = radians
    }

    public init(degrees: Double) {
        self.radians = degrees * .pi / 180
    }

    public static func radians(_ radians: Double) -> Angle { Angle(radians: radians) }
    public static func degrees(_ degrees: Double) -> Angle { Angle(degrees: degrees) }
    public static let zero = Angle(radians: 0)
}

// MARK: - Point / Size / Rect

/// A 2D point, equivalent to CGPoint.
public struct Point: Sendable, Hashable {
    public var x: Double
    public var y: Double

    public init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }

    public static let zero = Point(x: 0, y: 0)
}

/// A 2D size, equivalent to CGSize.
public struct Size: Sendable, Hashable {
    public var width: Double
    public var height: Double

    public init(width: Double = 0, height: Double = 0) {
        self.width = width
        self.height = height
    }

    public static let zero = Size(width: 0, height: 0)
}

/// A 2D rectangle, equivalent to CGRect.
public struct Rect: Sendable, Hashable {
    public var origin: Point
    public var size: Size

    public var minX: Double { origin.x }
    public var minY: Double { origin.y }
    public var maxX: Double { origin.x + size.width }
    public var maxY: Double { origin.y + size.height }
    public var midX: Double { origin.x + size.width / 2 }
    public var midY: Double { origin.y + size.height / 2 }
    public var width: Double { size.width }
    public var height: Double { size.height }

    public init(origin: Point = .zero, size: Size = .zero) {
        self.origin = origin
        self.size = size
    }

    public init(x: Double, y: Double, width: Double, height: Double) {
        self.origin = Point(x: x, y: y)
        self.size = Size(width: width, height: height)
    }

    public static let zero = Rect(origin: .zero, size: .zero)
}

// MARK: - Path

/// A 2D shape defined by a sequence of path elements.
///
/// Mirrors SwiftUI's `Path` API. Use `move(to:)`, `addLine(to:)`,
/// `addArc(center:radius:startAngle:endAngle:clockwise:)`, and related
/// methods to construct paths. The stored elements are later translated
/// to Canvas 2D drawing commands by `Canvas2DRenderer`.
///
/// ```swift
/// var path = Path()
/// path.move(to: Point(x: 10, y: 10))
/// path.addLine(to: Point(x: 100, y: 10))
/// path.addLine(to: Point(x: 55, y: 80))
/// path.closeSubpath()
/// ```
public struct Path: Sendable, Equatable {

    // MARK: Element

    /// A single element in a path.
    public enum Element: Sendable, Equatable {
        /// Move to a new point (starts a new subpath).
        case move(to: Point)
        /// Draw a straight line to the given point.
        case line(to: Point)
        /// Draw a quadratic Bézier curve.
        case quadCurve(to: Point, control: Point)
        /// Draw a cubic Bézier curve.
        case curve(to: Point, control1: Point, control2: Point)
        /// Close the current subpath with a line back to its start.
        case closeSubpath
    }

    // MARK: Storage

    /// The ordered elements that define this path.
    public private(set) var elements: [Element] = []

    /// Whether the path contains no elements.
    public var isEmpty: Bool { elements.isEmpty }

    /// The current point (end of the last drawn segment), or nil if empty.
    public var currentPoint: Point? {
        for element in elements.reversed() {
            switch element {
            case .move(let p), .line(let p), .quadCurve(let p, _), .curve(let p, _, _):
                return p
            case .closeSubpath:
                continue
            }
        }
        return nil
    }

    // MARK: Initializers

    /// Creates an empty path.
    public init() {}

    /// Creates a path by executing a builder closure.
    public init(_ callback: (inout Path) -> Void) {
        callback(&self)
    }

    /// Creates a path containing a rectangle.
    public init(_ rect: Rect) {
        addRect(rect)
    }

    /// Creates a path containing an ellipse inscribed in the given rect.
    public init(ellipseIn rect: Rect) {
        addEllipse(in: rect)
    }

    /// Creates a path containing a rounded rectangle.
    public init(roundedRect rect: Rect, cornerRadius: Double) {
        addRoundedRect(in: rect, cornerRadius: cornerRadius)
    }

    // MARK: Building Methods

    /// Begins a new subpath at the specified point.
    public mutating func move(to point: Point) {
        elements.append(.move(to: point))
    }

    /// Appends a straight line from the current point to the given point.
    public mutating func addLine(to point: Point) {
        elements.append(.line(to: point))
    }

    /// Appends a quadratic Bézier curve.
    public mutating func addQuadCurve(to end: Point, control: Point) {
        elements.append(.quadCurve(to: end, control: control))
    }

    /// Appends a cubic Bézier curve.
    public mutating func addCurve(to end: Point, control1: Point, control2: Point) {
        elements.append(.curve(to: end, control1: control1, control2: control2))
    }

    /// Closes the current subpath.
    public mutating func closeSubpath() {
        elements.append(.closeSubpath)
    }

    /// Adds a rectangular subpath.
    public mutating func addRect(_ rect: Rect) {
        move(to: Point(x: rect.minX, y: rect.minY))
        addLine(to: Point(x: rect.maxX, y: rect.minY))
        addLine(to: Point(x: rect.maxX, y: rect.maxY))
        addLine(to: Point(x: rect.minX, y: rect.maxY))
        closeSubpath()
    }

    /// Adds an ellipse inscribed in the given rectangle.
    public mutating func addEllipse(in rect: Rect) {
        // Approximate ellipse with 4 cubic Bézier curves
        let cx = rect.midX, cy = rect.midY
        let rx = rect.width / 2, ry = rect.height / 2
        // Magic number for cubic Bézier circle approximation
        let k: Double = 0.5522847498
        let kx = k * rx, ky = k * ry

        move(to: Point(x: cx + rx, y: cy))
        addCurve(to: Point(x: cx, y: cy + ry),
                 control1: Point(x: cx + rx, y: cy + ky),
                 control2: Point(x: cx + kx, y: cy + ry))
        addCurve(to: Point(x: cx - rx, y: cy),
                 control1: Point(x: cx - kx, y: cy + ry),
                 control2: Point(x: cx - rx, y: cy + ky))
        addCurve(to: Point(x: cx, y: cy - ry),
                 control1: Point(x: cx - rx, y: cy - ky),
                 control2: Point(x: cx - kx, y: cy - ry))
        addCurve(to: Point(x: cx + rx, y: cy),
                 control1: Point(x: cx + kx, y: cy - ry),
                 control2: Point(x: cx + rx, y: cy - ky))
        closeSubpath()
    }

    /// Adds a rounded rectangle subpath.
    public mutating func addRoundedRect(in rect: Rect, cornerRadius r: Double) {
        let r = min(r, rect.width / 2, rect.height / 2)
        move(to: Point(x: rect.minX + r, y: rect.minY))
        addLine(to: Point(x: rect.maxX - r, y: rect.minY))
        addQuadCurve(to: Point(x: rect.maxX, y: rect.minY + r),
                     control: Point(x: rect.maxX, y: rect.minY))
        addLine(to: Point(x: rect.maxX, y: rect.maxY - r))
        addQuadCurve(to: Point(x: rect.maxX - r, y: rect.maxY),
                     control: Point(x: rect.maxX, y: rect.maxY))
        addLine(to: Point(x: rect.minX + r, y: rect.maxY))
        addQuadCurve(to: Point(x: rect.minX, y: rect.maxY - r),
                     control: Point(x: rect.minX, y: rect.maxY))
        addLine(to: Point(x: rect.minX, y: rect.minY + r))
        addQuadCurve(to: Point(x: rect.minX + r, y: rect.minY),
                     control: Point(x: rect.minX, y: rect.minY))
        closeSubpath()
    }

    /// Adds an arc of a circle.
    ///
    /// - Parameters:
    ///   - center: The center of the arc.
    ///   - radius: The radius of the arc.
    ///   - startAngle: The start angle (measured from positive X axis).
    ///   - endAngle: The end angle.
    ///   - clockwise: Direction. Note: In canvas coordinates (Y-down),
    ///     clockwise means the mathematical counter-clockwise direction.
    public mutating func addArc(center: Point, radius: Double,
                                startAngle: Angle, endAngle: Angle,
                                clockwise: Bool) {
        elements.append(.move(to: Point(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )))
        // Store as a special convention: arc info encoded in a curve-to
        // We'll use a dedicated ArcInfo struct instead
        // Actually, let's just store the arc parameters for the renderer
        _arcs.append(ArcInfo(
            center: center, radius: radius,
            startAngle: startAngle, endAngle: endAngle,
            clockwise: clockwise,
            elementIndex: elements.count - 1
        ))
    }

    /// Adds an arc from the current point using a relative start angle and delta.
    public mutating func addRelativeArc(center: Point, radius: Double,
                                         startAngle: Angle, delta: Angle) {
        let endAngle = Angle(radians: startAngle.radians + delta.radians)
        let clockwise = delta.radians < 0
        addArc(center: center, radius: radius,
               startAngle: startAngle, endAngle: endAngle,
               clockwise: clockwise)
    }

    /// Adds a sequence of connected line segments.
    public mutating func addLines(_ points: [Point]) {
        guard let first = points.first else { return }
        move(to: first)
        for point in points.dropFirst() {
            addLine(to: point)
        }
    }

    /// Appends another path's elements.
    public mutating func addPath(_ other: Path) {
        elements.append(contentsOf: other.elements)
        let offset = elements.count - other.elements.count
        for arc in other._arcs {
            _arcs.append(ArcInfo(
                center: arc.center, radius: arc.radius,
                startAngle: arc.startAngle, endAngle: arc.endAngle,
                clockwise: arc.clockwise,
                elementIndex: arc.elementIndex + offset
            ))
        }
    }

    /// Calls the body closure with each element in the path.
    public func forEach(_ body: (Element) -> Void) {
        elements.forEach(body)
    }

    // MARK: Arc Storage

    /// Internal arc info stored alongside elements (arcs can't be fully
    /// represented by bezier elements alone for canvas rendering).
    public struct ArcInfo: Sendable, Equatable {
        public let center: Point
        public let radius: Double
        public let startAngle: Angle
        public let endAngle: Angle
        public let clockwise: Bool
        /// Index into `elements` where this arc's move-to lives.
        public let elementIndex: Int
    }

    /// Arc segments that need special handling during canvas rendering.
    public private(set) var _arcs: [ArcInfo] = []
}

// MARK: - Path → Canvas 2D JavaScript

extension Path {
    /// Generates the JavaScript Canvas 2D drawing commands for this path.
    ///
    /// The returned string assumes a variable `ctx` referencing a
    /// `CanvasRenderingContext2D` is in scope.
    ///
    /// Example output:
    /// ```javascript
    /// ctx.beginPath();
    /// ctx.moveTo(10, 10);
    /// ctx.lineTo(100, 10);
    /// ctx.closePath();
    /// ```
    public func toCanvasJS(contextName ctx: String = "ctx") -> String {
        var js = "\(ctx).beginPath();\n"
        var arcIndex = 0

        for (i, element) in elements.enumerated() {
            // Check if this element is the move-to for an arc
            if arcIndex < _arcs.count && _arcs[arcIndex].elementIndex == i {
                let arc = _arcs[arcIndex]
                let ccw = arc.clockwise ? "true" : "false"
                js += "\(ctx).arc(\(arc.center.x), \(arc.center.y), \(arc.radius), \(arc.startAngle.radians), \(arc.endAngle.radians), \(ccw));\n"
                arcIndex += 1
                continue
            }

            switch element {
            case .move(let p):
                js += "\(ctx).moveTo(\(p.x), \(p.y));\n"
            case .line(let p):
                js += "\(ctx).lineTo(\(p.x), \(p.y));\n"
            case .quadCurve(let end, let cp):
                js += "\(ctx).quadraticCurveTo(\(cp.x), \(cp.y), \(end.x), \(end.y));\n"
            case .curve(let end, let cp1, let cp2):
                js += "\(ctx).bezierCurveTo(\(cp1.x), \(cp1.y), \(cp2.x), \(cp2.y), \(end.x), \(end.y));\n"
            case .closeSubpath:
                js += "\(ctx).closePath();\n"
            }
        }

        return js
    }
}
