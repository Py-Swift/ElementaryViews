//
//  GraphicsContext.swift
//  ElementaryViews
//
//  An immediate-mode drawing context matching SwiftUI's GraphicsContext API.
//  Wraps Canvas2DContext for HTML <canvas> rendering via JavaScriptKit.
//

import JavaScriptKit

/// An immediate mode drawing destination, matching SwiftUI's `GraphicsContext`.
///
/// Use a context to execute 2D drawing primitives. For example, you can draw
/// filled shapes using the `fill(_:with:style:)` method inside a `Canvas` view:
///
/// ```swift
/// Canvas(width: 300, height: 200) { context, size in
///     context.fill(
///         Path(ellipseIn: Rect(x: 0, y: 0, width: size.width, height: size.height)),
///         with: .color(.green))
/// }
/// ```
public struct GraphicsContext {

    /// The underlying Canvas 2D rendering context.
    internal var ctx: Canvas2DContext

    /// Creates a graphics context wrapping a Canvas2DContext.
    public init(_ ctx: Canvas2DContext) {
        self.ctx = ctx
    }

    // MARK: - Opacity

    /// The opacity of drawing operations in the context.
    public var opacity: Double {
        get { ctx.globalAlpha }
        set { ctx.globalAlpha = newValue }
    }

    // MARK: - Blend Mode

    /// The blend mode used by drawing operations in the context.
    public var blendMode: BlendMode {
        get { BlendMode(canvasValue: ctx.globalCompositeOperation) }
        set { ctx.globalCompositeOperation = newValue.canvasValue }
    }

    // MARK: - Transform

    /// Scales subsequent drawing operations by an amount in each dimension.
    public mutating func scaleBy(x: Double, y: Double) {
        ctx.scale(x, y)
    }

    /// Moves subsequent drawing operations by an amount in each dimension.
    public mutating func translateBy(x: Double, y: Double) {
        ctx.translate(x, y)
    }

    /// Rotates subsequent drawing operations by an angle.
    public mutating func rotate(by angle: Angle) {
        ctx.rotate(angle.radians)
    }

    // MARK: - Clip

    /// Adds a path to the context's array of clip shapes.
    public mutating func clip(to path: Path, style: FillStyle = FillStyle(), options: ClipOptions = ClipOptions()) {
        ctx.addPath(path)
        if style.isEOFilled {
            _ = ctx.jsContext.clip!("evenodd")
        } else {
            ctx.clip()
        }
    }

    // MARK: - Fill & Stroke

    /// Draws a path into the context and fills the outlined region.
    public func fill(_ path: Path, with shading: Shading, style: FillStyle = FillStyle()) {
        applyShading(shading, asFill: true)
        ctx.addPath(path)
        if style.isEOFilled {
            _ = ctx.jsContext.fill!("evenodd")
        } else {
            ctx.fill()
        }
    }

    /// Draws a path into the context with a specified stroke style.
    public func stroke(_ path: Path, with shading: Shading, style: StrokeStyle) {
        applyShading(shading, asFill: false)
        applyStrokeStyle(style)
        ctx.addPath(path)
        ctx.stroke()
    }

    /// Draws a path into the context with a specified line width.
    public func stroke(_ path: Path, with shading: Shading, lineWidth: Double = 1) {
        applyShading(shading, asFill: false)
        ctx.lineWidth = lineWidth
        ctx.addPath(path)
        ctx.stroke()
    }

    // MARK: - Draw Layer

    /// Draws a new layer, created by drawing code that you provide, into the context.
    ///
    /// Equivalent to save/restore in canvas — changes made inside the closure
    /// do not affect the outer context state.
    public func drawLayer(content: (inout GraphicsContext) throws -> Void) rethrows {
        ctx.save()
        var layerCtx = GraphicsContext(ctx)
        try content(&layerCtx)
        ctx.restore()
    }

    // MARK: - Filter

    /// Adds a filter that applies to subsequent drawing operations.
    public mutating func addFilter(_ filter: Filter) {
        switch filter.storage {
        case .blur(let radius):
            ctx.jsContext.filter = .string("blur(\(radius)px)")
        case .shadow(let color, let radius, let x, let y):
            ctx.jsContext.filter = .string("drop-shadow(\(x)px \(y)px \(radius)px \(color.hexString))")
        case .brightness(let amount):
            ctx.jsContext.filter = .string("brightness(\(1 + amount))")
        case .contrast(let amount):
            ctx.jsContext.filter = .string("contrast(\(amount))")
        case .saturation(let amount):
            ctx.jsContext.filter = .string("saturate(\(amount))")
        case .grayscale(let amount):
            ctx.jsContext.filter = .string("grayscale(\(amount))")
        case .hueRotation(let angle):
            ctx.jsContext.filter = .string("hue-rotate(\(angle.degrees)deg)")
        case .colorInvert(let amount):
            ctx.jsContext.filter = .string("invert(\(amount))")
        case .opacity(let amount):
            ctx.jsContext.filter = .string("opacity(\(amount))")
        case .none:
            ctx.jsContext.filter = .string("none")
        }
    }

    // MARK: - Text Drawing

    /// Fills text at the specified point.
    public func drawText(_ text: String, at point: Point, font: String? = nil) {
        if let font { ctx.font = font }
        ctx.fillText(text, point.x, point.y)
    }

    /// Strokes text at the specified point.
    public func strokeText(_ text: String, at point: Point, font: String? = nil) {
        if let font { ctx.font = font }
        ctx.strokeText(text, point.x, point.y)
    }

    // MARK: - Clear

    /// Clears a rectangular area, making it fully transparent.
    public func clear(in rect: Rect) {
        ctx.clearRect(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
    }

    // MARK: - Internal Helpers

    /// Applies a Shading value to the context as either fill or stroke style.
    private func applyShading(_ shading: Shading, asFill: Bool) {
        switch shading.storage {
        case .color(let color):
            let css = color.hexString
            if asFill { ctx.fillStyle = css } else { ctx.strokeStyle = css }

        case .foreground:
            // Default to black in canvas context
            if asFill { ctx.fillStyle = "#000000" } else { ctx.strokeStyle = "#000000" }

        case .linearGradient(let gradient, let start, let end):
            let jsGrad = ctx.createLinearGradient(
                x0: start.x, y0: start.y, x1: end.x, y1: end.y)
            addColorStops(to: jsGrad, from: gradient)
            if asFill {
                ctx.jsContext.fillStyle = .object(jsGrad)
            } else {
                ctx.jsContext.strokeStyle = .object(jsGrad)
            }

        case .radialGradient(let gradient, let center, let startRadius, let endRadius):
            let jsGrad = ctx.createRadialGradient(
                x0: center.x, y0: center.y, r0: startRadius,
                x1: center.x, y1: center.y, r1: endRadius)
            addColorStops(to: jsGrad, from: gradient)
            if asFill {
                ctx.jsContext.fillStyle = .object(jsGrad)
            } else {
                ctx.jsContext.strokeStyle = .object(jsGrad)
            }

        case .conicGradient(let gradient, let center, let angle):
            let jsGrad = ctx.createConicGradient(
                startAngle: angle.radians, x: center.x, y: center.y)
            addColorStops(to: jsGrad, from: gradient)
            if asFill {
                ctx.jsContext.fillStyle = .object(jsGrad)
            } else {
                ctx.jsContext.strokeStyle = .object(jsGrad)
            }
        }
    }

    /// Adds color stops from a Gradient to a JS gradient object.
    private func addColorStops(to jsGrad: JSObject, from gradient: Gradient) {
        let count = gradient.stops.count
        for (i, stop) in gradient.stops.enumerated() {
            let location = stop.location ?? (count > 1 ? Double(i) / Double(count - 1) : 0)
            let colorValue = stop.cssColorValue
            _ = jsGrad.addColorStop!(location, colorValue)
        }
    }

    /// Applies a StrokeStyle to the underlying canvas context.
    private func applyStrokeStyle(_ style: StrokeStyle) {
        ctx.lineWidth = style.lineWidth
        ctx.lineCap = style.lineCap.rawValue
        ctx.lineJoin = style.lineJoin.rawValue
        ctx.miterLimit = style.miterLimit
        if !style.dash.isEmpty {
            ctx.setLineDash(style.dash)
        }
        ctx.lineDashOffset = style.dashPhase
    }
}

// MARK: - GraphicsContext.BlendMode

extension GraphicsContext {
    /// The ways that a graphics context combines new content with background content.
    ///
    /// Matches SwiftUI's `GraphicsContext.BlendMode`.
    public struct BlendMode: Equatable, Sendable {
        let canvasValue: String

        init(canvasValue: String) {
            self.canvasValue = canvasValue
        }

        public static var normal: BlendMode { BlendMode(canvasValue: "source-over") }
        public static var multiply: BlendMode { BlendMode(canvasValue: "multiply") }
        public static var screen: BlendMode { BlendMode(canvasValue: "screen") }
        public static var overlay: BlendMode { BlendMode(canvasValue: "overlay") }
        public static var darken: BlendMode { BlendMode(canvasValue: "darken") }
        public static var lighten: BlendMode { BlendMode(canvasValue: "lighten") }
        public static var colorDodge: BlendMode { BlendMode(canvasValue: "color-dodge") }
        public static var colorBurn: BlendMode { BlendMode(canvasValue: "color-burn") }
        public static var softLight: BlendMode { BlendMode(canvasValue: "soft-light") }
        public static var hardLight: BlendMode { BlendMode(canvasValue: "hard-light") }
        public static var difference: BlendMode { BlendMode(canvasValue: "difference") }
        public static var exclusion: BlendMode { BlendMode(canvasValue: "exclusion") }
        public static var hue: BlendMode { BlendMode(canvasValue: "hue") }
        public static var saturation: BlendMode { BlendMode(canvasValue: "saturation") }
        public static var color: BlendMode { BlendMode(canvasValue: "color") }
        public static var luminosity: BlendMode { BlendMode(canvasValue: "luminosity") }
        public static var clear: BlendMode { BlendMode(canvasValue: "destination-out") }
        public static var copy: BlendMode { BlendMode(canvasValue: "copy") }
        public static var sourceIn: BlendMode { BlendMode(canvasValue: "source-in") }
        public static var sourceOut: BlendMode { BlendMode(canvasValue: "source-out") }
        public static var sourceAtop: BlendMode { BlendMode(canvasValue: "source-atop") }
        public static var destinationOver: BlendMode { BlendMode(canvasValue: "destination-over") }
        public static var destinationIn: BlendMode { BlendMode(canvasValue: "destination-in") }
        public static var destinationOut: BlendMode { BlendMode(canvasValue: "destination-out") }
        public static var destinationAtop: BlendMode { BlendMode(canvasValue: "destination-atop") }
        public static var xor: BlendMode { BlendMode(canvasValue: "xor") }
        public static var plusDarker: BlendMode { BlendMode(canvasValue: "darken") }
        public static var plusLighter: BlendMode { BlendMode(canvasValue: "lighter") }
    }
}

// MARK: - GraphicsContext.Shading

extension GraphicsContext {
    /// A color or pattern that you can use to outline or fill a path.
    ///
    /// Matches SwiftUI's `GraphicsContext.Shading`.
    public struct Shading: Sendable {

        enum Storage: Sendable {
            case color(Color)
            case foreground
            case linearGradient(Gradient, startPoint: Point, endPoint: Point)
            case radialGradient(Gradient, center: Point, startRadius: Double, endRadius: Double)
            case conicGradient(Gradient, center: Point, angle: Angle)
        }

        let storage: Storage

        /// A shading instance that fills with the foreground style.
        public static var foreground: Shading {
            Shading(storage: .foreground)
        }

        /// Returns a shading instance that fills with a color.
        public static func color(_ color: Color) -> Shading {
            Shading(storage: .color(color))
        }

        /// Returns a shading instance that fills with RGB color components.
        public static func color(red: Double, green: Double, blue: Double, opacity: Double = 1) -> Shading {
            Shading(storage: .color(Color(red: red, green: green, blue: blue, opacity: opacity)))
        }

        /// Returns a shading instance that fills with a monochrome color.
        public static func color(white: Double, opacity: Double = 1) -> Shading {
            Shading(storage: .color(Color(white: white, opacity: opacity)))
        }

        /// Returns a shading instance that fills a linear (axial) gradient.
        public static func linearGradient(
            _ gradient: Gradient,
            startPoint: Point,
            endPoint: Point
        ) -> Shading {
            Shading(storage: .linearGradient(gradient, startPoint: startPoint, endPoint: endPoint))
        }

        /// Returns a shading instance that fills a radial gradient.
        public static func radialGradient(
            _ gradient: Gradient,
            center: Point,
            startRadius: Double,
            endRadius: Double
        ) -> Shading {
            Shading(storage: .radialGradient(gradient, center: center, startRadius: startRadius, endRadius: endRadius))
        }

        /// Returns a shading instance that fills a conic (angular) gradient.
        public static func conicGradient(
            _ gradient: Gradient,
            center: Point,
            angle: Angle = .zero
        ) -> Shading {
            Shading(storage: .conicGradient(gradient, center: center, angle: angle))
        }
    }
}

// MARK: - GraphicsContext.ClipOptions

extension GraphicsContext {
    /// Options that affect the use of clip shapes.
    public struct ClipOptions: OptionSet, Sendable {
        public let rawValue: UInt32

        public init(rawValue: UInt32) {
            self.rawValue = rawValue
        }

        /// An option to invert the shape or layer alpha as the clip mask.
        public static var inverse: ClipOptions { ClipOptions(rawValue: 1 << 0) }
    }
}

// MARK: - GraphicsContext.Filter

extension GraphicsContext {
    /// A type that applies image processing operations to rendered content.
    ///
    /// Matches a subset of SwiftUI's `GraphicsContext.Filter`.
    public struct Filter: Sendable {

        enum Storage: Sendable {
            case blur(radius: Double)
            case shadow(color: Color, radius: Double, x: Double, y: Double)
            case brightness(Double)
            case contrast(Double)
            case saturation(Double)
            case grayscale(Double)
            case hueRotation(Angle)
            case colorInvert(Double)
            case opacity(Double)
            case none
        }

        let storage: Storage

        /// Returns a filter that applies a Gaussian blur.
        public static func blur(radius: Double) -> Filter {
            Filter(storage: .blur(radius: radius))
        }

        /// Returns a filter that adds a shadow.
        public static func shadow(
            color: Color = Color(white: 0, opacity: 0.33),
            radius: Double,
            x: Double = 0,
            y: Double = 0
        ) -> Filter {
            Filter(storage: .shadow(color: color, radius: radius, x: x, y: y))
        }

        /// Returns a filter that applies a brightness adjustment.
        public static func brightness(_ amount: Double) -> Filter {
            Filter(storage: .brightness(amount))
        }

        /// Returns a filter that applies a contrast adjustment.
        public static func contrast(_ amount: Double) -> Filter {
            Filter(storage: .contrast(amount))
        }

        /// Returns a filter that applies a saturation adjustment.
        public static func saturation(_ amount: Double) -> Filter {
            Filter(storage: .saturation(amount))
        }

        /// Returns a filter that applies a grayscale adjustment.
        public static func grayscale(_ amount: Double) -> Filter {
            Filter(storage: .grayscale(amount))
        }

        /// Returns a filter that applies a hue rotation.
        public static func hueRotation(_ angle: Angle) -> Filter {
            Filter(storage: .hueRotation(angle))
        }

        /// Returns a filter that inverts colors.
        public static func colorInvert(_ amount: Double = 1) -> Filter {
            Filter(storage: .colorInvert(amount))
        }

        /// Removes filter effects.
        public static var none: Filter {
            Filter(storage: .none)
        }
    }
}

// MARK: - Gradient.Stop Canvas Extension

extension Gradient.Stop {
    /// Returns a CSS color value suitable for Canvas 2D gradient stops.
    ///
    /// Strips Tailwind arbitrary-value brackets from tokens created via `Color`.
    /// For example, `"[#ff3b30]"` becomes `"#ff3b30"`.
    var cssColorValue: String {
        if colorToken.hasPrefix("[") && colorToken.hasSuffix("]") {
            return String(colorToken.dropFirst().dropLast())
        }
        // Fallback: return as-is (may not work for Tailwind utility names)
        return colorToken
    }
}
