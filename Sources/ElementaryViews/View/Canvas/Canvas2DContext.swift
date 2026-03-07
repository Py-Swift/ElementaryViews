//
//  Canvas2DContext.swift
//  ElementaryViews
//
//  Swift wrapper around the JavaScript CanvasRenderingContext2D API.
//  Uses JavaScriptKit (via JavaScriptKitExtensions) to call canvas methods.
//
//  This type is only functional in a browser/Wasm environment.
//  On native platforms it compiles but operations are no-ops.
//

import JavaScriptKit
import JavaScriptKitExtensions

/// A Swift wrapper around the HTML Canvas 2D rendering context.
///
/// Provides a type-safe API for drawing shapes, paths, text, and images
/// on an HTML `<canvas>` element.
///
/// ```swift
/// // In a browser/Wasm environment:
/// let canvas = JSObject.global.document.getElementById("myCanvas")
/// let ctx = Canvas2DContext(canvas: canvas.object!)
/// ctx.fillStyle = "blue"
/// ctx.fillRect(10, 10, 100, 80)
/// ```
public struct Canvas2DContext: @unchecked Sendable {
    /// The underlying JS `CanvasRenderingContext2D` object.
    public let jsContext: JSObject

    /// Creates a context from an existing `CanvasRenderingContext2D` JS object.
    public init(context: JSObject) {
        self.jsContext = context
    }

    /// Creates a context by calling `getContext("2d")` on a canvas element.
    public init(canvas: JSObject) {
        self.jsContext = canvas.getContext!("2d").object!
    }

    // MARK: - Fill & Stroke Style

    /// The fill color or style (`ctx.fillStyle`).
    public var fillStyle: String {
        get { jsContext.fillStyle.string! }
        nonmutating set { jsContext.fillStyle = .string(newValue) }
    }

    /// The stroke color or style (`ctx.strokeStyle`).
    public var strokeStyle: String {
        get { jsContext.strokeStyle.string! }
        nonmutating set { jsContext.strokeStyle = .string(newValue) }
    }

    // MARK: - Line Style

    /// The line width (`ctx.lineWidth`).
    public var lineWidth: Double {
        get { jsContext.lineWidth.number! }
        nonmutating set { jsContext.lineWidth = .number(newValue) }
    }

    /// The line cap style: "butt", "round", or "square".
    public var lineCap: String {
        get { jsContext.lineCap.string! }
        nonmutating set { jsContext.lineCap = .string(newValue) }
    }

    /// The line join style: "round", "bevel", or "miter".
    public var lineJoin: String {
        get { jsContext.lineJoin.string! }
        nonmutating set { jsContext.lineJoin = .string(newValue) }
    }

    /// The miter limit ratio.
    public var miterLimit: Double {
        get { jsContext.miterLimit.number! }
        nonmutating set { jsContext.miterLimit = .number(newValue) }
    }

    // MARK: - Shadow

    /// The shadow color.
    public var shadowColor: String {
        get { jsContext.shadowColor.string! }
        nonmutating set { jsContext.shadowColor = .string(newValue) }
    }

    /// The shadow blur level.
    public var shadowBlur: Double {
        get { jsContext.shadowBlur.number! }
        nonmutating set { jsContext.shadowBlur = .number(newValue) }
    }

    /// The horizontal shadow offset.
    public var shadowOffsetX: Double {
        get { jsContext.shadowOffsetX.number! }
        nonmutating set { jsContext.shadowOffsetX = .number(newValue) }
    }

    /// The vertical shadow offset.
    public var shadowOffsetY: Double {
        get { jsContext.shadowOffsetY.number! }
        nonmutating set { jsContext.shadowOffsetY = .number(newValue) }
    }

    // MARK: - Text

    /// The font setting (e.g. "16px Arial").
    public var font: String {
        get { jsContext.font.string! }
        nonmutating set { jsContext.font = .string(newValue) }
    }

    /// The text alignment: "start", "end", "left", "right", "center".
    public var textAlign: String {
        get { jsContext.textAlign.string! }
        nonmutating set { jsContext.textAlign = .string(newValue) }
    }

    /// The text baseline: "top", "hanging", "middle", "alphabetic", "ideographic", "bottom".
    public var textBaseline: String {
        get { jsContext.textBaseline.string! }
        nonmutating set { jsContext.textBaseline = .string(newValue) }
    }

    /// The global alpha (opacity) level.
    public var globalAlpha: Double {
        get { jsContext.globalAlpha.number! }
        nonmutating set { jsContext.globalAlpha = .number(newValue) }
    }

    /// The global composite operation.
    public var globalCompositeOperation: String {
        get { jsContext.globalCompositeOperation.string! }
        nonmutating set { jsContext.globalCompositeOperation = .string(newValue) }
    }

    // MARK: - Path Methods

    /// Starts a new path.
    public func beginPath() {
        _ = jsContext.beginPath!()
    }

    /// Closes the current subpath.
    public func closePath() {
        _ = jsContext.closePath!()
    }

    /// Moves the pen to the given point.
    public func moveTo(_ x: Double, _ y: Double) {
        _ = jsContext.moveTo!(x, y)
    }

    /// Draws a line from the current point to the given point.
    public func lineTo(_ x: Double, _ y: Double) {
        _ = jsContext.lineTo!(x, y)
    }

    /// Adds a quadratic Bézier curve.
    public func quadraticCurveTo(cpx: Double, cpy: Double, x: Double, y: Double) {
        _ = jsContext.quadraticCurveTo!(cpx, cpy, x, y)
    }

    /// Adds a cubic Bézier curve.
    public func bezierCurveTo(cp1x: Double, cp1y: Double, cp2x: Double, cp2y: Double, x: Double, y: Double) {
        _ = jsContext.bezierCurveTo!(cp1x, cp1y, cp2x, cp2y, x, y)
    }

    /// Adds a circular arc.
    public func arc(x: Double, y: Double, radius: Double,
                    startAngle: Double, endAngle: Double,
                    counterclockwise: Bool = false) {
        _ = jsContext.arc!(x, y, radius, startAngle, endAngle, counterclockwise)
    }

    /// Adds an arc using tangent points and radius.
    public func arcTo(x1: Double, y1: Double, x2: Double, y2: Double, radius: Double) {
        _ = jsContext.arcTo!(x1, y1, x2, y2, radius)
    }

    /// Adds an ellipse to the path.
    public func ellipse(x: Double, y: Double, radiusX: Double, radiusY: Double,
                        rotation: Double, startAngle: Double, endAngle: Double,
                        counterclockwise: Bool = false) {
        _ = jsContext.ellipse!(x, y, radiusX, radiusY, rotation, startAngle, endAngle, counterclockwise)
    }

    /// Adds a rectangle to the path.
    public func rect(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
        _ = jsContext.rect!(x, y, width, height)
    }

    // MARK: - Drawing

    /// Fills the current path.
    public func fill() {
        _ = jsContext.fill!()
    }

    /// Strokes the current path.
    public func stroke() {
        _ = jsContext.stroke!()
    }

    /// Fills a rectangle.
    public func fillRect(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
        _ = jsContext.fillRect!(x, y, width, height)
    }

    /// Strokes a rectangle.
    public func strokeRect(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
        _ = jsContext.strokeRect!(x, y, width, height)
    }

    /// Clears a rectangular area.
    public func clearRect(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
        _ = jsContext.clearRect!(x, y, width, height)
    }

    /// Fills text at the given position.
    public func fillText(_ text: String, _ x: Double, _ y: Double) {
        _ = jsContext.fillText!(text, x, y)
    }

    /// Strokes text at the given position.
    public func strokeText(_ text: String, _ x: Double, _ y: Double) {
        _ = jsContext.strokeText!(text, x, y)
    }

    // MARK: - Transform

    /// Saves the current state.
    public func save() {
        _ = jsContext.save!()
    }

    /// Restores the last saved state.
    public func restore() {
        _ = jsContext.restore!()
    }

    /// Applies a translation transform.
    public func translate(_ x: Double, _ y: Double) {
        _ = jsContext.translate!(x, y)
    }

    /// Applies a rotation transform.
    public func rotate(_ angle: Double) {
        _ = jsContext.rotate!(angle)
    }

    /// Applies a scale transform.
    public func scale(_ x: Double, _ y: Double) {
        _ = jsContext.scale!(x, y)
    }

    /// Sets the transform matrix directly.
    public func setTransform(_ a: Double, _ b: Double, _ c: Double,
                             _ d: Double, _ e: Double, _ f: Double) {
        _ = jsContext.setTransform!(a, b, c, d, e, f)
    }

    /// Resets the transform to identity.
    public func resetTransform() {
        _ = jsContext.resetTransform!()
    }

    // MARK: - Clipping

    /// Clips to the current path.
    public func clip() {
        _ = jsContext.clip!()
    }

    /// Returns true if the given point is in the current path.
    public func isPointInPath(_ x: Double, _ y: Double) -> Bool {
        jsContext.isPointInPath!(x, y).boolean!
    }

    // MARK: - Line Dash

    /// Sets the line dash pattern.
    public func setLineDash(_ segments: [Double]) {
        let jsArray = segments.map { JSValue.number($0) }
        _ = jsContext.setLineDash!(jsArray)
    }

    /// The line dash offset.
    public var lineDashOffset: Double {
        get { jsContext.lineDashOffset.number! }
        nonmutating set { jsContext.lineDashOffset = .number(newValue) }
    }

    // MARK: - Path Drawing from Path type

    /// Draws a `Path` value onto this context (builds the path, does not fill/stroke).
    ///
    /// Call `fill()` or `stroke()` after this to render the path.
    public func addPath(_ path: Path) {
        beginPath()
        var arcIndex = 0

        for (i, element) in path.elements.enumerated() {
            // Check if this element is the move-to for an arc
            if arcIndex < path._arcs.count && path._arcs[arcIndex].elementIndex == i {
                let arcInfo = path._arcs[arcIndex]
                arc(x: arcInfo.center.x, y: arcInfo.center.y,
                    radius: arcInfo.radius,
                    startAngle: arcInfo.startAngle.radians,
                    endAngle: arcInfo.endAngle.radians,
                    counterclockwise: arcInfo.clockwise)
                arcIndex += 1
                continue
            }

            switch element {
            case .move(let p):
                moveTo(p.x, p.y)
            case .line(let p):
                lineTo(p.x, p.y)
            case .quadCurve(let end, let cp):
                quadraticCurveTo(cpx: cp.x, cpy: cp.y, x: end.x, y: end.y)
            case .curve(let end, let cp1, let cp2):
                bezierCurveTo(cp1x: cp1.x, cp1y: cp1.y,
                              cp2x: cp2.x, cp2y: cp2.y,
                              x: end.x, y: end.y)
            case .closeSubpath:
                closePath()
            }
        }
    }

    /// Draws and fills a `Path`.
    public func fill(_ path: Path) {
        addPath(path)
        fill()
    }

    /// Draws and strokes a `Path`.
    public func stroke(_ path: Path) {
        addPath(path)
        stroke()
    }

    // MARK: - Gradient Creation

    /// Creates a linear gradient between two points.
    public func createLinearGradient(x0: Double, y0: Double, x1: Double, y1: Double) -> JSObject {
        jsContext.createLinearGradient!(x0, y0, x1, y1).object!
    }

    /// Creates a radial gradient between two circles.
    public func createRadialGradient(x0: Double, y0: Double, r0: Double,
                                     x1: Double, y1: Double, r1: Double) -> JSObject {
        jsContext.createRadialGradient!(x0, y0, r0, x1, y1, r1).object!
    }

    /// Creates a conic gradient around a point.
    public func createConicGradient(startAngle: Double, x: Double, y: Double) -> JSObject {
        jsContext.createConicGradient!(startAngle, x, y).object!
    }
}
