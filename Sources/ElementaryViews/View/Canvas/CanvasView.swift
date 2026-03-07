//
//  Canvas.swift
//  ElementaryViews
//
//  A SwiftUI-compatible Canvas view that renders an HTML <canvas> element
//  and executes drawing commands via GraphicsContext at mount time.
//

import ElementaryUI
import JavaScriptKit

/// A view type that supports immediate mode drawing.
///
/// Use a `Canvas` to draw rich 2D content using a `GraphicsContext`.
/// The renderer closure receives a mutable graphics context and the
/// available size, matching SwiftUI's Canvas API:
///
/// ```swift
/// Canvas(width: 300, height: 200) { context, size in
///     let rect = Path(Rect(x: 0, y: 0, width: size.width, height: size.height))
///     context.fill(rect, with: .color(.blue))
/// }
/// ```
///
/// The canvas element is rendered as HTML `<canvas>` with the specified
/// pixel dimensions. Drawing commands execute via JavaScriptKit when
/// the view appears in the DOM.
@PublicView
public struct Canvas {
    let width: Int
    let height: Int
    let canvasClass: String
    let canvasID: String
    let opaque: Bool
    let renderer: (inout GraphicsContext, Size) -> Void

    public typealias Tag = HTMLTag.div

    /// Creates a canvas view with the given pixel dimensions and renderer.
    ///
    /// - Parameters:
    ///   - width: The pixel width of the canvas.
    ///   - height: The pixel height of the canvas.
    ///   - opaque: A Boolean that indicates whether the canvas is opaque.
    ///     If `true`, the canvas is treated as fully opaque, which can
    ///     improve compositing performance. Default is `false`.
    ///   - canvasClass: Optional Tailwind CSS classes for the container.
    ///   - renderer: A closure that receives a graphics context and size.
    public init(
        width: Int,
        height: Int,
        opaque: Bool = false,
        canvasClass: String = "",
        renderer: @escaping (inout GraphicsContext, Size) -> Void
    ) {
        self.width = width
        self.height = height
        self.opaque = opaque
        self.canvasClass = canvasClass
        self.canvasID = "canvas-\(Int.random(in: 100000...999999))"
        self.renderer = renderer
    }

    public var body: some View {
        div(.class(canvasClass)) {
            canvas(.id(canvasID),
                   .custom(name: "width", value: "\(width)"),
                   .custom(name: "height", value: "\(height)")) {
                "Canvas not supported"
            }
        }
        .onAppear {
            executeRenderer()
        }
    }

    /// Executes the renderer closure by obtaining the canvas 2D context from the DOM.
    private func executeRenderer() {
        let document = JSObject.global.document
        guard let canvasEl = document.getElementById(canvasID).object else { return }
        let ctx2d = Canvas2DContext(canvas: canvasEl)
        var graphicsCtx = GraphicsContext(ctx2d)
        let size = Size(width: Double(width), height: Double(height))
        renderer(&graphicsCtx, size)
    }
}
