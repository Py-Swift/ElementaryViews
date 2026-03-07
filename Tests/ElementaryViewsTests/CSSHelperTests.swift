//
//  CSSHelperTests.swift
//  ElementaryViewsTests
//
import ElementaryUI
import Testing
@testable import ElementaryViews

@Suite("CSS Helper Types")
struct CSSHelperTests {

    // MARK: - CSSTextSize

    @Test func textSizeRawValues() {
        #expect(CSSTextSize.xs.rawValue == "text-xs")
        #expect(CSSTextSize.sm.rawValue == "text-sm")
        #expect(CSSTextSize.base.rawValue == "text-base")
        #expect(CSSTextSize.lg.rawValue == "text-lg")
        #expect(CSSTextSize.xl.rawValue == "text-xl")
        #expect(CSSTextSize.xl2.rawValue == "text-2xl")
        #expect(CSSTextSize.xl3.rawValue == "text-3xl")
        #expect(CSSTextSize.xl9.rawValue == "text-9xl")
    }

    // MARK: - CSSTextAlign

    @Test func textAlignRawValues() {
        #expect(CSSTextAlign.left.rawValue == "text-left")
        #expect(CSSTextAlign.center.rawValue == "text-center")
        #expect(CSSTextAlign.right.rawValue == "text-right")
        #expect(CSSTextAlign.justify.rawValue == "text-justify")
        #expect(CSSTextAlign.start.rawValue == "text-start")
        #expect(CSSTextAlign.end.rawValue == "text-end")
    }

    // MARK: - TextWidthStyle

    @Test func textWidthStyleRawValues() {
        #expect(TextWidthStyle.w_full.rawValue == "w-full")
        #expect(TextWidthStyle.w_1_2.rawValue == "w-1/2")
        #expect(TextWidthStyle.w_1_3.rawValue == "w-1/3")
        #expect(TextWidthStyle.w_1_4.rawValue == "w-1/4")
        #expect(TextWidthStyle.w_2_3.rawValue == "w-2/3")
        #expect(TextWidthStyle.w_3_4.rawValue == "w-3/4")
        #expect(TextWidthStyle.flex_1.rawValue == "flex-1")
    }

    // MARK: - CSSColorKey (spot checks)

    @Test func colorKeyRawValues() {
        #expect(CSSColorKey.gray_200.rawValue == "gray-200")
        #expect(CSSColorKey.blue_500.rawValue == "blue-500")
        #expect(CSSColorKey.red_300.rawValue == "red-300")
        #expect(CSSColorKey.slate_950.rawValue == "slate-950")
    }

    // MARK: - CSSPadding

    @Test func paddingDefaults() {
        let p = CSSPadding()
        #expect(p.css == "px-3 py-1.5")
    }

    @Test func paddingCustom() {
        let p = CSSPadding(px: 4, py: 2.0)
        #expect(p.css == "px-4 py-2.0")
    }

    @Test func paddingZero() {
        let p = CSSPadding.zero
        #expect(p.css == "px-0 py-0.0")
    }

    // MARK: - CSSBorderInfo

    @Test func borderInfoDefault() {
        let b = CSSBorderInfo(color: .gray_200)
        #expect(b.css == "border border-gray-200 rounded")
    }

    @Test func borderInfoWithWidth() {
        let b = CSSBorderInfo(color: .blue_500, width: 2)
        #expect(b.css == "border-2 border-blue-500 rounded")
    }

    // MARK: - CSSFontInfo

    @Test func fontInfoDefaults() {
        let f = CSSFontInfo()
        #expect(f.css == "text-sm")
    }

    @Test func fontInfoWithColor() {
        let f = CSSFontInfo(size: .lg, color: .red_500)
        #expect(f.css == "text-lg text-red-500")
    }

    @Test func fontInfoWithColorAndAlign() {
        let f = CSSFontInfo(size: .base, color: .blue_500, align: .center)
        #expect(f.css == "text-base text-blue-500 text-center")
    }

    @Test func fontInfoSizeOnly() {
        let f = CSSFontInfo(size: .xl2)
        #expect(f.css == "text-2xl")
    }

    @Test func fontInfoAlignOnly() {
        let f = CSSFontInfo(align: .right)
        #expect(f.css == "text-sm text-right")
    }

    // MARK: - CSSCornerRadius

    @Test func cornerRadiusRawValues() {
        #expect(CSSCornerRadius.none.rawValue == "rounded-none")
        #expect(CSSCornerRadius.sm.rawValue == "rounded-sm")
        #expect(CSSCornerRadius.md.rawValue == "rounded-md")
        #expect(CSSCornerRadius.lg.rawValue == "rounded-lg")
        #expect(CSSCornerRadius.xl.rawValue == "rounded-xl")
        #expect(CSSCornerRadius.xl2.rawValue == "rounded-2xl")
        #expect(CSSCornerRadius.xl3.rawValue == "rounded-3xl")
        #expect(CSSCornerRadius.full.rawValue == "rounded-full")
    }

    // MARK: - CSSObjectFit

    @Test func objectFitRawValues() {
        #expect(CSSObjectFit.contain.rawValue == "object-contain")
        #expect(CSSObjectFit.cover.rawValue == "object-cover")
        #expect(CSSObjectFit.fill.rawValue == "object-fill")
        #expect(CSSObjectFit.none.rawValue == "object-none")
        #expect(CSSObjectFit.scaleDown.rawValue == "object-scale-down")
    }

    // MARK: - CSSShadow

    @Test func shadowRawValues() {
        #expect(CSSShadow.none.rawValue == "shadow-none")
        #expect(CSSShadow.sm.rawValue == "shadow-sm")
        #expect(CSSShadow.regular.rawValue == "shadow")
        #expect(CSSShadow.md.rawValue == "shadow-md")
        #expect(CSSShadow.lg.rawValue == "shadow-lg")
        #expect(CSSShadow.xl.rawValue == "shadow-xl")
        #expect(CSSShadow.xl2.rawValue == "shadow-2xl")
        #expect(CSSShadow.inner.rawValue == "shadow-inner")
    }

    // MARK: - CSSFontWeight

    @Test func fontWeightRawValues() {
        #expect(CSSFontWeight.thin.rawValue == "font-thin")
        #expect(CSSFontWeight.extralight.rawValue == "font-extralight")
        #expect(CSSFontWeight.light.rawValue == "font-light")
        #expect(CSSFontWeight.normal.rawValue == "font-normal")
        #expect(CSSFontWeight.medium.rawValue == "font-medium")
        #expect(CSSFontWeight.semibold.rawValue == "font-semibold")
        #expect(CSSFontWeight.bold.rawValue == "font-bold")
        #expect(CSSFontWeight.extrabold.rawValue == "font-extrabold")
        #expect(CSSFontWeight.black.rawValue == "font-black")
    }

    // MARK: - CSSColorKey ShapeStyle conformance

    @Test func colorKeyShapeStyleText() {
        #expect(CSSColorKey.blue_500.cssClass(for: .text) == "text-blue-500")
    }

    @Test func colorKeyShapeStyleBackground() {
        #expect(CSSColorKey.red_300.cssClass(for: .background) == "bg-red-300")
    }

    @Test func colorKeyShapeStyleBorder() {
        #expect(CSSColorKey.gray_200.cssClass(for: .border) == "border-gray-200")
    }

    // MARK: - Shape types

    @Test func rectangleShapeCSS() {
        let shape = Rectangle()
        #expect(shape.css == "")
    }

    @Test func roundedRectangleShapeCSS() {
        let shape = RoundedRectangle(cornerRadius: .lg)
        #expect(shape.css == "rounded-lg")
    }

    @Test func circleShapeCSS() {
        let shape = Circle()
        #expect(shape.css == "rounded-full aspect-square")
    }

    @Test func capsuleShapeCSS() {
        let shape = Capsule()
        #expect(shape.css == "rounded-full")
    }

    // MARK: - Color struct

    @Test func colorRGBHex() {
        let c = Color(red: 1.0, green: 0.0, blue: 0.0)
        #expect(c.hexString == "#ff0000")
    }

    @Test func colorRGBAHex() {
        let c = Color(red: 0.0, green: 0.0, blue: 1.0, opacity: 0.5)
        #expect(c.hexString == "#0000ff7f")
    }

    @Test func colorWhite() {
        #expect(Color.white.hexString == "#ffffff")
        #expect(Color.black.hexString == "#000000")
    }

    @Test func colorClear() {
        let c = Color.clear
        #expect(c.hexString == "#00000000")
    }

    @Test func colorFromHex6() {
        let c = Color(hex: "#FF8800")
        #expect(c != nil)
        #expect(c!.hexString == "#ff8800")
    }

    @Test func colorFromHex8() {
        let c = Color(hex: "00FF0080")
        #expect(c != nil)
        #expect(c!.hexString == "#00ff0080")
    }

    @Test func colorFromHexInvalid() {
        #expect(Color(hex: "XYZ") == nil)
        #expect(Color(hex: "12345") == nil)
    }

    @Test func colorShapeStyleText() {
        let c = Color(red: 1.0, green: 0.0, blue: 0.0)
        #expect(c.cssClass(for: .text) == "text-[#ff0000]")
    }

    @Test func colorShapeStyleBackground() {
        let c = Color(red: 0.0, green: 0.0, blue: 1.0, opacity: 0.5)
        #expect(c.cssClass(for: .background) == "bg-[#0000ff7f]")
    }

    @Test func colorOpacityModifier() {
        let c = Color.red.opacity(0.5)
        #expect(c.opacity == 0.5)
        #expect(c.red == Color.red.red)
    }

    @Test func colorStaticConstants() {
        // Just verify they exist and produce valid hex
        #expect(Color.red.hexString.hasPrefix("#"))
        #expect(Color.blue.hexString.hasPrefix("#"))
        #expect(Color.green.hexString.hasPrefix("#"))
        #expect(Color.white.hexString == "#ffffff")
        #expect(Color.black.hexString == "#000000")
    }

    @Test func colorHashable() {
        let a = Color(red: 0.5, green: 0.5, blue: 0.5)
        let b = Color(red: 0.5, green: 0.5, blue: 0.5)
        #expect(a == b)
        #expect(a.hashValue == b.hashValue)
    }

    // MARK: - ForegroundStyle

    @Test func foregroundStyleDescription() {
        let style = ForegroundStyle()
        #expect(style.description == "current")
    }

    @Test func foregroundStyleResolvedCSS() {
        let style = ForegroundStyle()
        #expect(style.resolve(in: nil, for: .text).description == "text-current")
        #expect(style.resolve(in: nil, for: .background).description == "bg-current")
    }

    @Test func foregroundStyleStaticAccessor() {
        // Verify `.foreground` static accessor works
        let style: ForegroundStyle = .foreground
        #expect(style.description == "current")
    }

    // MARK: - BackgroundStyle

    @Test func backgroundStyleDescription() {
        let style = BackgroundStyle()
        #expect(style.description == "inherit")
    }

    @Test func backgroundStyleResolvedCSS() {
        let style = BackgroundStyle()
        #expect(style.resolve(in: nil, for: .background).description == "bg-inherit")
        #expect(style.resolve(in: nil, for: .text).description == "text-inherit")
    }

    @Test func backgroundStyleStaticAccessor() {
        let style: BackgroundStyle = .background
        #expect(style.description == "inherit")
    }

    // MARK: - HierarchicalShapeStyle

    @Test func hierarchicalPrimaryDescription() {
        #expect(HierarchicalShapeStyle.primary.description == "opacity-100")
    }

    @Test func hierarchicalSecondaryDescription() {
        #expect(HierarchicalShapeStyle.secondary.description == "opacity-60")
    }

    @Test func hierarchicalTertiaryDescription() {
        #expect(HierarchicalShapeStyle.tertiary.description == "opacity-40")
    }

    @Test func hierarchicalQuaternaryDescription() {
        #expect(HierarchicalShapeStyle.quaternary.description == "opacity-25")
    }

    @Test func hierarchicalQuinaryDescription() {
        #expect(HierarchicalShapeStyle.quinary.description == "opacity-15")
    }

    @Test func hierarchicalStaticAccessors() {
        let primary: HierarchicalShapeStyle = .primary
        let secondary: HierarchicalShapeStyle = .secondary
        #expect(primary.description == "opacity-100")
        #expect(secondary.description == "opacity-60")
    }

    @Test func hierarchicalResolvedCSS() {
        // For hierarchical styles, the resolved CSS is role-prefixed description
        let style = HierarchicalShapeStyle.secondary
        #expect(style.resolve(in: nil, for: .text).description == "text-opacity-60")
    }

    // MARK: - TintShapeStyle

    @Test func tintShapeStyleDescription() {
        let style = TintShapeStyle()
        #expect(style.description == "accent")
    }

    @Test func tintShapeStyleResolvedCSS() {
        let style = TintShapeStyle()
        #expect(style.resolve(in: nil, for: .text).description == "text-accent")
        #expect(style.resolve(in: nil, for: .background).description == "bg-accent")
    }

    @Test func tintStaticAccessor() {
        let style: TintShapeStyle = .tint
        #expect(style.description == "accent")
    }

    // MARK: - FillShapeStyle

    @Test func fillShapeStyleDescription() {
        let style = FillShapeStyle()
        #expect(style.description == "current")
    }

    @Test func fillShapeStyleResolvedCSS() {
        let style = FillShapeStyle()
        #expect(style.resolve(in: nil, for: .fill).description == "fill-current")
        #expect(style.resolve(in: nil, for: .stroke).description == "stroke-current")
    }

    // MARK: - AnyShapeStyle

    @Test func anyShapeStyleWithColor() {
        let style = AnyShapeStyle(Color.red)
        #expect(style.description == "#ff3b30")
        #expect(style.resolve(in: nil, for: .text).description == "text-[#ff3b30]")
    }

    @Test func anyShapeStyleWithColorKey() {
        let style = AnyShapeStyle(CSSColorKey.blue_500)
        #expect(style.description == "blue-500")
        #expect(style.resolve(in: nil, for: .background).description == "bg-blue-500")
    }

    @Test func anyShapeStyleWithForegroundStyle() {
        let style = AnyShapeStyle(ForegroundStyle())
        #expect(style.description == "current")
        #expect(style.resolve(in: nil, for: .text).description == "text-current")
    }

    // MARK: - CSSStyleRole

    @Test func cssStyleRoleRawValues() {
        #expect(CSSStyleRole.text.rawValue == "text")
        #expect(CSSStyleRole.background.rawValue == "bg")
        #expect(CSSStyleRole.border.rawValue == "border")
        #expect(CSSStyleRole.ring.rawValue == "ring")
        #expect(CSSStyleRole.fill.rawValue == "fill")
        #expect(CSSStyleRole.stroke.rawValue == "stroke")
    }

    // MARK: - Gradient.Stop

    @Test func gradientStopFromColor() {
        let stop = Gradient.Stop(color: Color.red)
        #expect(stop.colorToken == "[#ff3b30]")
        #expect(stop.location == nil)
    }

    @Test func gradientStopFromColorWithLocation() {
        let stop = Gradient.Stop(color: Color.blue, location: 0.5)
        #expect(stop.colorToken == "[#007aff]")
        #expect(stop.location == 0.5)
    }

    @Test func gradientStopFromCSSColorKey() {
        let stop = Gradient.Stop(color: CSSColorKey.blue_500)
        #expect(stop.colorToken == "blue-500")
        #expect(stop.location == nil)
    }

    @Test func gradientStopFromToken() {
        let stop = Gradient.Stop(token: "white", location: 0.0)
        #expect(stop.colorToken == "white")
        #expect(stop.location == 0.0)
    }

    // MARK: - Gradient

    @Test func gradientFromColors() {
        let g = Gradient(colors: [.red, .blue])
        #expect(g.stops.count == 2)
        #expect(g.stops[0].colorToken == "[#ff3b30]")
        #expect(g.stops[1].colorToken == "[#007aff]")
    }

    @Test func gradientFromCSSColors() {
        let g = Gradient(cssColors: [.blue_500, .pink_500])
        #expect(g.stops.count == 2)
        #expect(g.stops[0].colorToken == "blue-500")
        #expect(g.stops[1].colorToken == "pink-500")
    }

    @Test func gradientCSSStopClassesTwoStops() {
        let g = Gradient(cssColors: [.cyan_500, .blue_500])
        #expect(g.cssStopClasses == "from-cyan-500 to-blue-500")
    }

    @Test func gradientCSSStopClassesThreeStops() {
        let g = Gradient(cssColors: [.indigo_500, .purple_500, .pink_500])
        #expect(g.cssStopClasses == "from-indigo-500 via-purple-500 to-pink-500")
    }

    @Test func gradientCSSStopClassesWithLocations() {
        let g = Gradient(stops: [
            .init(color: .blue_500, location: 0.1),
            .init(color: .purple_500, location: 0.3),
            .init(color: .pink_500, location: 0.9)
        ])
        #expect(g.cssStopClasses == "from-blue-500 from-10% via-purple-500 via-30% to-pink-500 to-90%")
    }

    @Test func gradientCSSStopClassesSingleStop() {
        let g = Gradient(cssColors: [.red_500])
        #expect(g.cssStopClasses == "from-red-500")
    }

    @Test func gradientCSSStopClassesEmpty() {
        let g = Gradient(stops: [])
        #expect(g.cssStopClasses == "")
    }

    @Test func gradientCSSStopClassesWithColorHex() {
        let g = Gradient(colors: [.red, .blue])
        #expect(g.cssStopClasses == "from-[#ff3b30] to-[#007aff]")
    }

    // MARK: - LinearGradient

    @Test func linearGradientToRight() {
        let lg = LinearGradient(
            cssColors: [.cyan_500, .blue_500],
            startPoint: .leading,
            endPoint: .trailing
        )
        let css = lg.resolve(in: nil, for: .background).description
        #expect(css == "bg-linear-to-r from-cyan-500 to-blue-500")
    }

    @Test func linearGradientToBottom() {
        let lg = LinearGradient(
            cssColors: [.red_500, .yellow_500],
            startPoint: .top,
            endPoint: .bottom
        )
        let css = lg.resolve(in: nil, for: .background).description
        #expect(css == "bg-linear-to-b from-red-500 to-yellow-500")
    }

    @Test func linearGradientToTopLeft() {
        let lg = LinearGradient(
            cssColors: [.green_400, .blue_600],
            startPoint: .bottomTrailing,
            endPoint: .topLeading
        )
        let css = lg.resolve(in: nil, for: .background).description
        #expect(css == "bg-linear-to-tl from-green-400 to-blue-600")
    }

    @Test func linearGradientAllDirections() {
        func dir(_ end: UnitPoint) -> String {
            LinearGradient(cssColors: [.red_500, .blue_500], startPoint: .center, endPoint: end)
                .resolve(in: nil, for: .background).description
        }
        #expect(dir(UnitPoint.trailing).hasPrefix("bg-linear-to-r"))
        #expect(dir(UnitPoint.leading).hasPrefix("bg-linear-to-l"))
        #expect(dir(UnitPoint.top).hasPrefix("bg-linear-to-t"))
        #expect(dir(UnitPoint.bottom).hasPrefix("bg-linear-to-b"))
        #expect(dir(UnitPoint.topTrailing).hasPrefix("bg-linear-to-tr"))
        #expect(dir(UnitPoint.bottomTrailing).hasPrefix("bg-linear-to-br"))
        #expect(dir(UnitPoint.topLeading).hasPrefix("bg-linear-to-tl"))
        #expect(dir(UnitPoint.bottomLeading).hasPrefix("bg-linear-to-bl"))
    }

    @Test func linearGradientThreeStops() {
        let lg = LinearGradient(
            cssColors: [.indigo_500, .purple_500, .pink_500],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        let css = lg.resolve(in: nil, for: .background).description
        #expect(css == "bg-linear-to-br from-indigo-500 via-purple-500 to-pink-500")
    }

    @Test func linearGradientWithColors() {
        let lg = LinearGradient(
            colors: [.red, .blue],
            startPoint: .leading,
            endPoint: .trailing
        )
        let css = lg.resolve(in: nil, for: .background).description
        #expect(css == "bg-linear-to-r from-[#ff3b30] to-[#007aff]")
    }

    @Test func linearGradientTextRole() {
        let lg = LinearGradient(
            cssColors: [.pink_500, .violet_500],
            startPoint: .leading,
            endPoint: .trailing
        )
        let css = lg.resolve(in: nil, for: .text).description
        #expect(css == "bg-linear-to-r from-pink-500 to-violet-500 bg-clip-text text-transparent")
    }

    @Test func linearGradientDescription() {
        let lg = LinearGradient(
            cssColors: [.red_500, .blue_500],
            startPoint: .leading,
            endPoint: .trailing
        )
        #expect(lg.description == "linearGradient(r)")
    }

    @Test func linearGradientStaticAccessor() {
        let lg: LinearGradient = .linearGradient(
            colors: [.red, .blue],
            startPoint: .leading,
            endPoint: .trailing
        )
        #expect(lg.gradient.stops.count == 2)
    }

    // MARK: - RadialGradient

    @Test func radialGradientDefaultCenter() {
        let rg = RadialGradient(
            cssColors: [.yellow_400, .red_500],
            center: .center
        )
        let css = rg.resolve(in: nil, for: .background).description
        #expect(css == "bg-radial from-yellow-400 to-red-500")
    }

    @Test func radialGradientCustomCenter() {
        let rg = RadialGradient(
            cssColors: [.blue_400, .blue_900],
            center: .topLeading
        )
        let css = rg.resolve(in: nil, for: .background).description
        #expect(css == "bg-radial-[at_0%_0%] from-blue-400 to-blue-900")
    }

    @Test func radialGradientTextRole() {
        let rg = RadialGradient(
            cssColors: [.green_400, .blue_600],
            center: .center
        )
        let css = rg.resolve(in: nil, for: .text).description
        #expect(css == "bg-radial from-green-400 to-blue-600 bg-clip-text text-transparent")
    }

    @Test func radialGradientStaticAccessor() {
        let rg: RadialGradient = .radialGradient(
            colors: [.red, .blue],
            center: .center
        )
        #expect(rg.gradient.stops.count == 2)
    }

    // MARK: - AngularGradient

    @Test func angularGradientDefaultAngle() {
        let ag = AngularGradient(
            cssColors: [.red_500, .yellow_500, .green_500],
            center: .center
        )
        let css = ag.resolve(in: nil, for: .background).description
        #expect(css == "bg-conic from-red-500 via-yellow-500 to-green-500")
    }

    @Test func angularGradientWithAngle() {
        let ag = AngularGradient(
            cssColors: [.blue_500, .purple_500],
            center: .center,
            angleDegrees: 90
        )
        let css = ag.resolve(in: nil, for: .background).description
        #expect(css == "bg-conic-[from_90deg] from-blue-500 to-purple-500")
    }

    @Test func angularGradientCustomCenterAndAngle() {
        let ag = AngularGradient(
            cssColors: [.red_500, .blue_500],
            center: .topTrailing,
            angleDegrees: 45
        )
        let css = ag.resolve(in: nil, for: .background).description
        #expect(css == "bg-conic-[from_45deg_at_100%_0%] from-red-500 to-blue-500")
    }

    @Test func angularGradientCustomCenterNoAngle() {
        let ag = AngularGradient(
            cssColors: [.red_500, .blue_500],
            center: .bottomLeading
        )
        let css = ag.resolve(in: nil, for: .background).description
        #expect(css == "bg-conic-[at_0%_100%] from-red-500 to-blue-500")
    }

    @Test func angularGradientTextRole() {
        let ag = AngularGradient(
            cssColors: [.red_500, .blue_500],
            center: .center
        )
        let css = ag.resolve(in: nil, for: .text).description
        #expect(css == "bg-conic from-red-500 to-blue-500 bg-clip-text text-transparent")
    }

    @Test func angularGradientStaticAccessor() {
        let ag: AngularGradient = .conicGradient(
            colors: [.red, .blue],
            center: .center,
            angleDegrees: 45
        )
        #expect(ag.gradient.stops.count == 2)
        #expect(abs(ag.angleDegrees - 45) < 0.01)
    }
}
