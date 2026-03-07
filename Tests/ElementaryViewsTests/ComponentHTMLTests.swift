//
//  ComponentHTMLTests.swift
//  ElementaryViewsTests
//
//  Tests HTML structure of components by building equivalent
//  HTML primitives and verifying .render() output.
//
import Elementary
import ElementaryUI
import Testing
@testable import ElementaryViews

@Suite("Component HTML Structure")
struct ComponentHTMLTests {

    // MARK: - Text

    @Test func textDefaultFont() {
        // Text("Hello") → span(.class("text-sm")) { "Hello" }
        let html = span(.class("text-sm")) { "Hello" }
        HTMLExpect(html, toBe: #"<span class="text-sm">Hello</span>"#)
    }

    @Test func textWithFont() {
        // Text("Hi", font: CSSFontInfo(size: .lg, color: .blue_500))
        let font = CSSFontInfo(size: .lg, color: .blue_500)
        let html = span(.class("\(font.css)")) { "Hi" }
        HTMLExpect(html, toBe: #"<span class="text-lg text-blue-500">Hi</span>"#)
    }

    // MARK: - Button

    @Test func buttonStructure() {
        // Button { label }.onClick(onClick) → <button>Click</button>
        let html = button { "Click" }
        HTMLExpect(html, toBe: "<button>Click</button>")
    }

    // MARK: - Label

    @Test func labelStructure() {
        let font = CSSFontInfo()
        let padding = CSSPadding()
        let width = TextWidthStyle.w_1_3
        let bg = CSSColorKey.blue_500
        let cls = "\(width.rawValue) inline-block rounded \(padding.css) \(font.css) bg-\(bg.rawValue)"
        let html = span(.class(cls)) { "Name" }
        HTMLExpect(html, toBe: #"<span class="w-1/3 inline-block rounded px-3 py-1.5 text-sm bg-blue-500">Name</span>"#)
    }

    // MARK: - BorderedLabel

    @Test func borderedLabelStructure() {
        let font = CSSFontInfo()
        let padding = CSSPadding()
        let border = CSSBorderInfo(color: .gray_200)
        let width = TextWidthStyle.w_full
        let bg = CSSColorKey.gray_50
        let cls = "\(width.rawValue) inline-block \(border.css) \(padding.css) \(font.css) bg-\(bg.rawValue)"
        let html = span(.class(cls)) { "Value" }
        HTMLExpect(html, toBe: #"<span class="w-full inline-block border border-gray-200 rounded px-3 py-1.5 text-sm bg-gray-50">Value</span>"#)
    }

    // MARK: - EqualSymbol / ColonSymbol

    @Test func equalSymbol() {
        let html = span(.class("text-gray-400")) { "=" }
        HTMLExpect(html, toBe: #"<span class="text-gray-400">=</span>"#)
    }

    @Test func colonSymbol() {
        let html = span(.class("text-gray-400")) { ":" }
        HTMLExpect(html, toBe: #"<span class="text-gray-400">:</span>"#)
    }

    // MARK: - TextField structure (without binding)

    @Test func textFieldStructure() {
        let width = TextWidthStyle.flex_1
        let border = CSSBorderInfo(color: .gray_200)
        let padding = CSSPadding()
        let font = CSSFontInfo()
        let cls = "\(width.rawValue) \(border.css) \(padding.css) \(font.css)"
        let html = input(.type(.text), .class(cls), .placeholder("Name"))
        HTMLExpect(html, toBe: #"<input type="text" class="flex-1 border border-gray-200 rounded px-3 py-1.5 text-sm" placeholder="Name">"#)
    }

    // MARK: - Spacer

    @Test func spacerDefault() {
        // Spacer() → div(.class("flex-grow")) {}
        let html = div(.class("flex-grow")) {}
        HTMLExpect(html, toBe: #"<div class="flex-grow"></div>"#)
    }

    @Test func spacerWithMinLength() {
        // Spacer(minLength: 20) → div(.class("flex-grow min-w-[20px] min-h-[20px]")) {}
        let html = div(.class("flex-grow min-w-[20px] min-h-[20px]")) {}
        HTMLExpect(html, toBe: #"<div class="flex-grow min-w-[20px] min-h-[20px]"></div>"#)
    }

    // MARK: - Divider

    @Test func dividerDefault() {
        // Divider() → hr(.class("border-t border-gray-200 my-2 w-full"))
        let html = hr(.class("border-t border-gray-200 my-2 w-full"))
        HTMLExpect(html, toBe: #"<hr class="border-t border-gray-200 my-2 w-full">"#)
    }

    @Test func dividerCustomColor() {
        // Divider(color: .blue_500)
        let color = CSSColorKey.blue_500
        let html = hr(.class("border-t border-\(color.rawValue) my-2 w-full"))
        HTMLExpect(html, toBe: #"<hr class="border-t border-blue-500 my-2 w-full">"#)
    }

    // MARK: - WebImage

    @Test func webImageDefault() {
        // WebImage(src: "pic.png") → img(.src, .alt, .class("object-cover"))
        let html = img(.src("pic.png"), .alt(""), .class("object-cover"))
        HTMLExpect(html, toBe: #"<img src="pic.png" alt="" class="object-cover">"#)
    }

    @Test func webImageWithSizing() {
        let html = img(.src("pic.png"), .alt("Photo"), .class("object-cover w-32 h-32 rounded-full"))
        HTMLExpect(html, toBe: #"<img src="pic.png" alt="Photo" class="object-cover w-32 h-32 rounded-full">"#)
    }

    // MARK: - WebLink

    @Test func webLinkBasic() {
        let html = a(.href("https://example.com"), .class("cursor-pointer")) { "Click here" }
        HTMLExpect(html, toBe: #"<a href="https://example.com" class="cursor-pointer">Click here</a>"#)
    }

    @Test func webLinkNewTab() {
        let html = a(.href("https://example.com"), .target(.blank), .class("cursor-pointer")) { "External" }
        HTMLExpect(html, toBe: #"<a href="https://example.com" target="_blank" class="cursor-pointer">External</a>"#)
    }

    // MARK: - Toggle (checkbox structure)

    @Test func toggleCheckboxStructure() {
        // The inner checkbox input element
        let html = input(.type(.checkbox), .class("sr-only peer"))
        HTMLExpect(html, toBe: #"<input type="checkbox" class="sr-only peer">"#)
    }

    // MARK: - SecureField

    @Test func secureFieldStructure() {
        let width = TextWidthStyle.flex_1
        let border = CSSBorderInfo(color: .gray_200)
        let padding = CSSPadding()
        let font = CSSFontInfo()
        let cls = "\(width.rawValue) \(border.css) \(padding.css) \(font.css) "
        let html = input(.type(.password), .class(cls), .placeholder("Password"))
        HTMLExpect(html, toBe: #"<input type="password" class="flex-1 border border-gray-200 rounded px-3 py-1.5 text-sm " placeholder="Password">"#)
    }
}
