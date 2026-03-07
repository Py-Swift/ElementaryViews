//
//  CanvasTests.swift
//  ElementaryViewsTests
//
//  Tests for Canvas 2D types: FillStyle, StrokeStyle, LineCap, LineJoin,
//  GraphicsContext.BlendMode, GraphicsContext.Shading, GraphicsContext.Filter,
//  GraphicsContext.ClipOptions, and Gradient.Stop.cssColorValue.
//
import Testing
@testable import ElementaryViews

@Suite("Canvas Types")
struct CanvasTests {

    // MARK: - FillStyle

    @Test func fillStyleDefaults() {
        let style = FillStyle()
        #expect(style.isEOFilled == false)
        #expect(style.isAntialiased == true)
    }

    @Test func fillStyleEOFill() {
        let style = FillStyle(eoFill: true)
        #expect(style.isEOFilled == true)
        #expect(style.isAntialiased == true)
    }

    @Test func fillStyleNoAntialiasing() {
        let style = FillStyle(antialiased: false)
        #expect(style.isEOFilled == false)
        #expect(style.isAntialiased == false)
    }

    @Test func fillStyleCustom() {
        let style = FillStyle(eoFill: true, antialiased: false)
        #expect(style.isEOFilled == true)
        #expect(style.isAntialiased == false)
    }

    @Test func fillStyleEquatable() {
        let a = FillStyle(eoFill: true, antialiased: false)
        let b = FillStyle(eoFill: true, antialiased: false)
        let c = FillStyle()
        #expect(a == b)
        #expect(a != c)
    }

    // MARK: - LineCap

    @Test func lineCapRawValues() {
        #expect(LineCap.butt.rawValue == "butt")
        #expect(LineCap.round.rawValue == "round")
        #expect(LineCap.square.rawValue == "square")
    }

    @Test func lineCapEquatable() {
        #expect(LineCap.butt == LineCap.butt)
        #expect(LineCap.round != LineCap.square)
    }

    // MARK: - LineJoin

    @Test func lineJoinRawValues() {
        #expect(LineJoin.miter.rawValue == "miter")
        #expect(LineJoin.round.rawValue == "round")
        #expect(LineJoin.bevel.rawValue == "bevel")
    }

    @Test func lineJoinEquatable() {
        #expect(LineJoin.miter == LineJoin.miter)
        #expect(LineJoin.round != LineJoin.bevel)
    }

    // MARK: - StrokeStyle

    @Test func strokeStyleDefaults() {
        let style = StrokeStyle()
        #expect(style.lineWidth == 1)
        #expect(style.lineCap == .butt)
        #expect(style.lineJoin == .miter)
        #expect(style.miterLimit == 10)
        #expect(style.dash.isEmpty)
        #expect(style.dashPhase == 0)
    }

    @Test func strokeStyleCustom() {
        let style = StrokeStyle(
            lineWidth: 3,
            lineCap: .round,
            lineJoin: .bevel,
            miterLimit: 5,
            dash: [10, 5, 2],
            dashPhase: 3
        )
        #expect(style.lineWidth == 3)
        #expect(style.lineCap == .round)
        #expect(style.lineJoin == .bevel)
        #expect(style.miterLimit == 5)
        #expect(style.dash == [10, 5, 2])
        #expect(style.dashPhase == 3)
    }

    @Test func strokeStylePartialCustom() {
        let style = StrokeStyle(lineWidth: 2.5, lineCap: .square)
        #expect(style.lineWidth == 2.5)
        #expect(style.lineCap == .square)
        #expect(style.lineJoin == .miter)
        #expect(style.miterLimit == 10)
    }

    @Test func strokeStyleEquatable() {
        let a = StrokeStyle(lineWidth: 2, lineCap: .round)
        let b = StrokeStyle(lineWidth: 2, lineCap: .round)
        let c = StrokeStyle(lineWidth: 3, lineCap: .round)
        #expect(a == b)
        #expect(a != c)
    }

    // MARK: - BlendMode

    @Test func blendModeStandardValues() {
        #expect(GraphicsContext.BlendMode.normal.canvasValue == "source-over")
        #expect(GraphicsContext.BlendMode.multiply.canvasValue == "multiply")
        #expect(GraphicsContext.BlendMode.screen.canvasValue == "screen")
        #expect(GraphicsContext.BlendMode.overlay.canvasValue == "overlay")
        #expect(GraphicsContext.BlendMode.darken.canvasValue == "darken")
        #expect(GraphicsContext.BlendMode.lighten.canvasValue == "lighten")
        #expect(GraphicsContext.BlendMode.colorDodge.canvasValue == "color-dodge")
        #expect(GraphicsContext.BlendMode.colorBurn.canvasValue == "color-burn")
        #expect(GraphicsContext.BlendMode.softLight.canvasValue == "soft-light")
        #expect(GraphicsContext.BlendMode.hardLight.canvasValue == "hard-light")
        #expect(GraphicsContext.BlendMode.difference.canvasValue == "difference")
        #expect(GraphicsContext.BlendMode.exclusion.canvasValue == "exclusion")
    }

    @Test func blendModeColorModes() {
        #expect(GraphicsContext.BlendMode.hue.canvasValue == "hue")
        #expect(GraphicsContext.BlendMode.saturation.canvasValue == "saturation")
        #expect(GraphicsContext.BlendMode.color.canvasValue == "color")
        #expect(GraphicsContext.BlendMode.luminosity.canvasValue == "luminosity")
    }

    @Test func blendModeCompositingValues() {
        #expect(GraphicsContext.BlendMode.clear.canvasValue == "destination-out")
        #expect(GraphicsContext.BlendMode.copy.canvasValue == "copy")
        #expect(GraphicsContext.BlendMode.sourceIn.canvasValue == "source-in")
        #expect(GraphicsContext.BlendMode.sourceOut.canvasValue == "source-out")
        #expect(GraphicsContext.BlendMode.sourceAtop.canvasValue == "source-atop")
        #expect(GraphicsContext.BlendMode.destinationOver.canvasValue == "destination-over")
        #expect(GraphicsContext.BlendMode.destinationIn.canvasValue == "destination-in")
        #expect(GraphicsContext.BlendMode.destinationOut.canvasValue == "destination-out")
        #expect(GraphicsContext.BlendMode.destinationAtop.canvasValue == "destination-atop")
        #expect(GraphicsContext.BlendMode.xor.canvasValue == "xor")
    }

    @Test func blendModePlusVariants() {
        #expect(GraphicsContext.BlendMode.plusDarker.canvasValue == "darken")
        #expect(GraphicsContext.BlendMode.plusLighter.canvasValue == "lighter")
    }

    @Test func blendModeEquatable() {
        #expect(GraphicsContext.BlendMode.normal == GraphicsContext.BlendMode.normal)
        #expect(GraphicsContext.BlendMode.normal != GraphicsContext.BlendMode.multiply)
    }

    // MARK: - Shading

    @Test func shadingColorFromColor() {
        let shading = GraphicsContext.Shading.color(.red)
        if case .color(let c) = shading.storage {
            #expect(c == Color.red)
        } else {
            Issue.record("Expected .color storage")
        }
    }

    @Test func shadingColorFromRGB() {
        let shading = GraphicsContext.Shading.color(red: 0.5, green: 0.3, blue: 0.1, opacity: 0.8)
        if case .color(let c) = shading.storage {
            #expect(c.red == 0.5)
            #expect(c.green == 0.3)
            #expect(c.blue == 0.1)
            #expect(c.opacity == 0.8)
        } else {
            Issue.record("Expected .color storage")
        }
    }

    @Test func shadingColorFromWhite() {
        let shading = GraphicsContext.Shading.color(white: 0.5)
        if case .color(let c) = shading.storage {
            #expect(c.red == 0.5)
            #expect(c.green == 0.5)
            #expect(c.blue == 0.5)
            #expect(c.opacity == 1.0)
        } else {
            Issue.record("Expected .color storage")
        }
    }

    @Test func shadingForeground() {
        let shading = GraphicsContext.Shading.foreground
        if case .foreground = shading.storage {
            // OK
        } else {
            Issue.record("Expected .foreground storage")
        }
    }

    @Test func shadingLinearGradient() {
        let gradient = Gradient(colors: [.red, .blue])
        let shading = GraphicsContext.Shading.linearGradient(
            gradient, startPoint: Point(x: 0, y: 0), endPoint: Point(x: 100, y: 0))
        if case .linearGradient(let g, let start, let end) = shading.storage {
            #expect(g == gradient)
            #expect(start.x == 0)
            #expect(start.y == 0)
            #expect(end.x == 100)
            #expect(end.y == 0)
        } else {
            Issue.record("Expected .linearGradient storage")
        }
    }

    @Test func shadingRadialGradient() {
        let gradient = Gradient(colors: [.green, .yellow])
        let shading = GraphicsContext.Shading.radialGradient(
            gradient, center: Point(x: 50, y: 50), startRadius: 0, endRadius: 50)
        if case .radialGradient(let g, let center, let startR, let endR) = shading.storage {
            #expect(g == gradient)
            #expect(center.x == 50)
            #expect(center.y == 50)
            #expect(startR == 0)
            #expect(endR == 50)
        } else {
            Issue.record("Expected .radialGradient storage")
        }
    }

    @Test func shadingConicGradient() {
        let gradient = Gradient(colors: [.red, .blue, .green])
        let shading = GraphicsContext.Shading.conicGradient(
            gradient, center: Point(x: 100, y: 100), angle: .degrees(45))
        if case .conicGradient(let g, let center, let angle) = shading.storage {
            #expect(g == gradient)
            #expect(center.x == 100)
            #expect(center.y == 100)
            #expect(angle.degrees == 45)
        } else {
            Issue.record("Expected .conicGradient storage")
        }
    }

    @Test func shadingConicGradientDefaultAngle() {
        let gradient = Gradient(colors: [.red, .blue])
        let shading = GraphicsContext.Shading.conicGradient(
            gradient, center: Point(x: 0, y: 0))
        if case .conicGradient(_, _, let angle) = shading.storage {
            #expect(angle.radians == 0)
        } else {
            Issue.record("Expected .conicGradient storage")
        }
    }

    // MARK: - ClipOptions

    @Test func clipOptionsEmpty() {
        let options = GraphicsContext.ClipOptions()
        #expect(options.rawValue == 0)
    }

    @Test func clipOptionsInverse() {
        let options = GraphicsContext.ClipOptions.inverse
        #expect(options.rawValue == 1)
        #expect(options.contains(.inverse))
    }

    // MARK: - Filter Storage

    @Test func filterBlur() {
        let filter = GraphicsContext.Filter.blur(radius: 5)
        if case .blur(let r) = filter.storage {
            #expect(r == 5)
        } else {
            Issue.record("Expected .blur storage")
        }
    }

    @Test func filterShadow() {
        let filter = GraphicsContext.Filter.shadow(
            color: .black, radius: 10, x: 2, y: 3)
        if case .shadow(let c, let r, let x, let y) = filter.storage {
            #expect(c == .black)
            #expect(r == 10)
            #expect(x == 2)
            #expect(y == 3)
        } else {
            Issue.record("Expected .shadow storage")
        }
    }

    @Test func filterShadowDefaults() {
        let filter = GraphicsContext.Filter.shadow(radius: 5)
        if case .shadow(_, _, let x, let y) = filter.storage {
            #expect(x == 0)
            #expect(y == 0)
        } else {
            Issue.record("Expected .shadow storage")
        }
    }

    @Test func filterBrightness() {
        let filter = GraphicsContext.Filter.brightness(0.5)
        if case .brightness(let v) = filter.storage {
            #expect(v == 0.5)
        } else {
            Issue.record("Expected .brightness storage")
        }
    }

    @Test func filterContrast() {
        let filter = GraphicsContext.Filter.contrast(1.5)
        if case .contrast(let v) = filter.storage {
            #expect(v == 1.5)
        } else {
            Issue.record("Expected .contrast storage")
        }
    }

    @Test func filterSaturation() {
        let filter = GraphicsContext.Filter.saturation(0.0)
        if case .saturation(let v) = filter.storage {
            #expect(v == 0.0)
        } else {
            Issue.record("Expected .saturation storage")
        }
    }

    @Test func filterGrayscale() {
        let filter = GraphicsContext.Filter.grayscale(1.0)
        if case .grayscale(let v) = filter.storage {
            #expect(v == 1.0)
        } else {
            Issue.record("Expected .grayscale storage")
        }
    }

    @Test func filterHueRotation() {
        let filter = GraphicsContext.Filter.hueRotation(.degrees(90))
        if case .hueRotation(let a) = filter.storage {
            #expect(a.degrees == 90)
        } else {
            Issue.record("Expected .hueRotation storage")
        }
    }

    @Test func filterColorInvert() {
        let filter = GraphicsContext.Filter.colorInvert()
        if case .colorInvert(let v) = filter.storage {
            #expect(v == 1.0)
        } else {
            Issue.record("Expected .colorInvert storage")
        }
    }

    @Test func filterColorInvertPartial() {
        let filter = GraphicsContext.Filter.colorInvert(0.5)
        if case .colorInvert(let v) = filter.storage {
            #expect(v == 0.5)
        } else {
            Issue.record("Expected .colorInvert storage")
        }
    }

    @Test func filterNone() {
        let filter = GraphicsContext.Filter.none
        if case .none = filter.storage {
            // OK
        } else {
            Issue.record("Expected .none storage")
        }
    }

    // MARK: - Gradient.Stop.cssColorValue

    @Test func gradientStopCSSValueFromColor() {
        let stop = Gradient.Stop(color: .red)
        // Color.red hex is "#ff3b30", token is "[#ff3b30]"
        #expect(stop.cssColorValue == "#ff3b30")
    }

    @Test func gradientStopCSSValueWithLocation() {
        let stop = Gradient.Stop(color: .blue, location: 0.5)
        #expect(stop.cssColorValue == "#007aff")
        #expect(stop.location == 0.5)
    }

    @Test func gradientStopCSSValueFromCSSKey() {
        let stop = Gradient.Stop(color: .blue_500)
        // CSSColorKey token is the raw value without brackets
        #expect(stop.cssColorValue == "blue-500")
    }

    @Test func gradientStopCSSValuePlainToken() {
        // Tokens without brackets should pass through as-is
        let stop = Gradient.Stop(token: "red-500")
        #expect(stop.cssColorValue == "red-500")
    }
}
