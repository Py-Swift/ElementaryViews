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
}
