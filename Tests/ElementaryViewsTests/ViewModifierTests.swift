//
//  ViewModifierTests.swift
//  ElementaryViewsTests
//
//  Tests that Tailwind CSS class-based view modifiers produce
//  the expected HTML output via .attributes(.class(...)).
//
import Elementary
import ElementaryUI
import Testing
@testable import ElementaryViews

@Suite("View Modifier HTML Output")
struct ViewModifierTests {

    // MARK: - Typography

    @Test func boldModifier() {
        let html = span { "text" }.bold()
        HTMLExpect(html, toBe: #"<span class="font-bold">text</span>"#)
    }

    @Test func italicModifier() {
        let html = span { "text" }.italic()
        HTMLExpect(html, toBe: #"<span class="italic">text</span>"#)
    }

    @Test func underlineModifier() {
        let html = span { "text" }.underline()
        HTMLExpect(html, toBe: #"<span class="underline">text</span>"#)
    }

    @Test func strikethroughModifier() {
        let html = span { "text" }.strikethrough()
        HTMLExpect(html, toBe: #"<span class="line-through">text</span>"#)
    }

    @Test func fontWeightModifier() {
        let html = span { "text" }.fontWeight(.semibold)
        HTMLExpect(html, toBe: #"<span class="font-semibold">text</span>"#)
    }

    @Test func fontSizeModifier() {
        let html = span { "text" }.fontSize(.lg)
        HTMLExpect(html, toBe: #"<span class="text-lg">text</span>"#)
    }

    @Test func textAlignModifier() {
        let html = p { "text" }.textAlign(.center)
        HTMLExpect(html, toBe: #"<p class="text-center">text</p>"#)
    }

    // MARK: - Colors

    @Test func foregroundColorModifier() {
        let html = span { "text" }.foregroundColor(.red_500)
        HTMLExpect(html, toBe: #"<span class="text-red-500">text</span>"#)
    }

    @Test func backgroundModifier() {
        let html = div { "content" }.background(.blue_100)
        HTMLExpect(html, toBe: #"<div class="bg-blue-100">content</div>"#)
    }

    // MARK: - Layout & Spacing

    @Test func paddingModifier() {
        let html = div { "content" }.padding(CSSPadding(px: 4, py: 2.0))
        HTMLExpect(html, toBe: #"<div class="px-4 py-2.0">content</div>"#)
    }

    @Test func cornerRadiusModifier() {
        let html = div { "content" }.cornerRadius(.lg)
        HTMLExpect(html, toBe: #"<div class="rounded-lg">content</div>"#)
    }

    @Test func frameWidthAndHeight() {
        let html = div { "content" }.frame(width: "64", height: "32")
        HTMLExpect(html, toBe: #"<div class="w-64 h-32">content</div>"#)
    }

    @Test func frameWidthOnly() {
        let html = div { "content" }.frame(width: "full")
        HTMLExpect(html, toBe: #"<div class="w-full">content</div>"#)
    }

    @Test func frameHeightOnly() {
        let html = div { "content" }.frame(height: "screen")
        HTMLExpect(html, toBe: #"<div class="h-screen">content</div>"#)
    }

    // MARK: - Effects

    @Test func shadowModifier() {
        let html = div { "content" }.shadow(.lg)
        HTMLExpect(html, toBe: #"<div class="shadow-lg">content</div>"#)
    }

    // MARK: - Visibility & Interaction

    @Test func hiddenModifier() {
        let html = div { "content" }.hidden()
        HTMLExpect(html, toBe: #"<div class="hidden">content</div>"#)
    }

    @Test func hiddenModifierFalse() {
        let html = div { "content" }.hidden(false)
        HTMLExpect(html, toBe: #"<div>content</div>"#)
    }

    @Test func disabledModifier() {
        let html = div { "content" }.disabled()
        HTMLExpect(html, toBe: #"<div class="opacity-50 pointer-events-none">content</div>"#)
    }

    @Test func disabledModifierFalse() {
        let html = div { "content" }.disabled(false)
        HTMLExpect(html, toBe: #"<div>content</div>"#)
    }

    // MARK: - Borders

    @Test func borderModifier() {
        let html = div { "content" }.border(CSSBorderInfo(color: .gray_300))
        HTMLExpect(html, toBe: #"<div class="border border-gray-300 rounded">content</div>"#)
    }

    // MARK: - Chaining

    @Test func chainedModifiers() {
        let html = span { "styled" }
            .bold()
            .foregroundColor(.blue_500)
            .italic()
        HTMLExpect(html, toBe: #"<span class="font-bold text-blue-500 italic">styled</span>"#)
    }

    @Test func chainedLayoutModifiers() {
        let html = div { "box" }
            .padding(CSSPadding(px: 2, py: 1.0))
            .cornerRadius(.md)
            .shadow(.sm)
            .background(.gray_100)
        HTMLExpect(html, toBe: #"<div class="px-2 py-1.0 rounded-md shadow-sm bg-gray-100">box</div>"#)
    }

    // MARK: - ShapeStyle Modifiers

    @Test func foregroundStyleWithCSSColorKey() {
        let html = span { "text" }.foregroundStyle(CSSColorKey.blue_500)
        HTMLExpect(html, toBe: #"<span class="text-blue-500">text</span>"#)
    }

    @Test func foregroundStyleWithColor() {
        let html = span { "text" }.foregroundStyle(Color(red: 1.0, green: 0.0, blue: 0.0))
        HTMLExpect(html, toBe: #"<span class="text-[#ff0000]">text</span>"#)
    }

    @Test func backgroundStyleWithCSSColorKey() {
        let html = div { "content" }.backgroundStyle(CSSColorKey.green_300)
        HTMLExpect(html, toBe: #"<div class="bg-green-300">content</div>"#)
    }

    @Test func backgroundStyleWithColor() {
        let html = div { "content" }.backgroundStyle(Color.blue)
        HTMLExpect(html, toBe: #"<div class="bg-[#007aff]">content</div>"#)
    }

    @Test func clipShapeCircle() {
        let html = div { "avatar" }.clipShape(Circle())
        HTMLExpect(html, toBe: #"<div class="rounded-full aspect-square">avatar</div>"#)
    }

    @Test func clipShapeCapsule() {
        let html = div { "pill" }.clipShape(Capsule())
        HTMLExpect(html, toBe: #"<div class="rounded-full">pill</div>"#)
    }

    @Test func clipShapeRoundedRectangle() {
        let html = div { "card" }.clipShape(RoundedRectangle(cornerRadius: .xl))
        HTMLExpect(html, toBe: #"<div class="rounded-xl">card</div>"#)
    }

    @Test func clipShapeRectangle() {
        let html = div { "block" }.clipShape(Rectangle())
        HTMLExpect(html, toBe: #"<div>block</div>"#)
    }
}
