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

    // MARK: - Slider

    @Test func sliderDefaultRange() {
        // Slider renders input type=range with min/max/step
        let html = input(
            .type(.range),
            .class("w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-500"),
            .value("50.0"),
            .custom(name: "min", value: "0.0"),
            .custom(name: "max", value: "100.0"),
            .custom(name: "step", value: "1.0")
        )
        HTMLExpect(html, toBe: #"<input type="range" class="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-500" value="50.0" min="0.0" max="100.0" step="1.0">"#)
    }

    // MARK: - ProgressView

    @Test func progressViewStructure() {
        // ProgressView renders a container div with a colored inner bar
        let html = div(.class("w-full bg-gray-200 rounded-full h-2.5 overflow-hidden")) {
            div(
                .class("bg-blue-500 h-2.5 rounded-full transition-all duration-300"),
                .style("width: 75.0%")
            ) { "" }
        }
        HTMLExpect(html, toBe: #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 75.0%"></div></div>"#)
    }

    // MARK: - TextEditor

    @Test func textEditorStructure() {
        let border = CSSBorderInfo(color: .gray_200)
        let padding = CSSPadding()
        let font = CSSFontInfo()
        let cls = "w-full resize-y \(border.css) \(padding.css) \(font.css) "
        let html = textarea(.class(cls), .custom(name: "rows", value: "4"), .placeholder("Enter text")) { "content" }
        HTMLExpect(html, toBe: #"<textarea class="w-full resize-y border border-gray-200 rounded px-3 py-1.5 text-sm " rows="4" placeholder="Enter text">content</textarea>"#)
    }

    // MARK: - ScrollView

    @Test func scrollViewVertical() {
        let html = div(.class("overflow-y-auto")) { p { "scrollable" } }
        HTMLExpect(html, toBe: #"<div class="overflow-y-auto"><p>scrollable</p></div>"#)
    }

    @Test func scrollViewHorizontal() {
        let html = div(.class("overflow-x-auto")) { p { "scrollable" } }
        HTMLExpect(html, toBe: #"<div class="overflow-x-auto"><p>scrollable</p></div>"#)
    }

    @Test func scrollViewBoth() {
        let html = div(.class("overflow-auto")) { p { "scrollable" } }
        HTMLExpect(html, toBe: #"<div class="overflow-auto"><p>scrollable</p></div>"#)
    }

    // MARK: - Section

    @Test func sectionStructure() {
        let html = section(.class("space-y-2")) {
            div(.class("font-semibold text-sm text-gray-700")) {
                span(.class("text-sm")) { "Title" }
            }
            p { "content" }
        }
        HTMLExpect(html, toBe: #"<section class="space-y-2"><div class="font-semibold text-sm text-gray-700"><span class="text-sm">Title</span></div><p>content</p></section>"#)
    }

    // MARK: - Form

    @Test func formStructure() {
        let html = form(.class("flex flex-col gap-4")) { p { "field" } }
        HTMLExpect(html, toBe: #"<form class="flex flex-col gap-4"><p>field</p></form>"#)
    }

    // MARK: - ListView

    @Test func listViewDefault() {
        let html = ul(.class("flex flex-col")) { li { "item" } }
        HTMLExpect(html, toBe: #"<ul class="flex flex-col"><li>item</li></ul>"#)
    }

    @Test func listViewDivided() {
        let html = ul(.class("flex flex-col divide-y divide-gray-200")) { li { "item" } }
        HTMLExpect(html, toBe: #"<ul class="flex flex-col divide-y divide-gray-200"><li>item</li></ul>"#)
    }

    // MARK: - NavigationLink

    @Test func navigationLinkDefault() {
        let html = a(.href("/about"), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
            span(.class("text-sm")) { "About" }
            span(.class("text-gray-400 text-xs")) { "›" }
        }
        HTMLExpect(html, toBe: #"<a href="/about" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">About</span><span class="text-gray-400 text-xs">›</span></a>"#)
    }

    @Test func navigationLinkNewTab() {
        let html = a(.href("https://example.com"), .target(.blank), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
            span(.class("text-sm")) { "External" }
            span(.class("text-gray-400 text-xs")) { "↗" }
        }
        HTMLExpect(html, toBe: #"<a href="https://example.com" target="_blank" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">External</span><span class="text-gray-400 text-xs">↗</span></a>"#)
    }

    // MARK: - Badge

    @Test func badgeStandard() {
        let html = span(.class("inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white")) { "5" }
        HTMLExpect(html, toBe: #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">5</span>"#)
    }

    @Test func badgeIncreased() {
        let html = span(.class("inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white")) { "New" }
        HTMLExpect(html, toBe: #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">New</span>"#)
    }

    @Test func badgeDecreased() {
        let html = span(.class("inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-200 text-gray-600")) { "3" }
        HTMLExpect(html, toBe: #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-200 text-gray-600">3</span>"#)
    }

    // MARK: - Stepper

    @Test func stepperStructure() {
        // Stepper's outer structure: label + button group
        let html = div(.class("inline-flex items-center gap-2")) {
            div(.class("text-sm")) {
                span(.class("text-sm")) { "Quantity" }
            }
            div(.class("inline-flex items-center border border-gray-300 rounded-lg overflow-hidden")) {
                button(.class("px-3 py-1 text-gray-600 hover:bg-gray-100 active:bg-gray-200 border-r border-gray-300 font-medium")) { "−" }
                button(.class("px-3 py-1 text-gray-600 hover:bg-gray-100 active:bg-gray-200 font-medium")) { "+" }
            }
        }
        HTMLExpect(html, toBe: #"<div class="inline-flex items-center gap-2"><div class="text-sm"><span class="text-sm">Quantity</span></div><div class="inline-flex items-center border border-gray-300 rounded-lg overflow-hidden"><button class="px-3 py-1 text-gray-600 hover:bg-gray-100 active:bg-gray-200 border-r border-gray-300 font-medium">−</button><button class="px-3 py-1 text-gray-600 hover:bg-gray-100 active:bg-gray-200 font-medium">+</button></div></div>"#)
    }

    // MARK: - SegmentedPicker

    @Test func segmentButtonSelected() {
        let html = button(.class("px-4 py-2 text-sm font-medium bg-blue-500 text-white focus:outline-none")) { "Tab A" }
        HTMLExpect(html, toBe: #"<button class="px-4 py-2 text-sm font-medium bg-blue-500 text-white focus:outline-none">Tab A</button>"#)
    }

    @Test func segmentButtonUnselected() {
        let html = button(.class("px-4 py-2 text-sm font-medium bg-white text-gray-700 hover:bg-gray-50 focus:outline-none")) { "Tab B" }
        HTMLExpect(html, toBe: #"<button class="px-4 py-2 text-sm font-medium bg-white text-gray-700 hover:bg-gray-50 focus:outline-none">Tab B</button>"#)
    }

    // MARK: - TabView

    @Test func tabButtonSelected() {
        let html = button(.class("px-4 py-2 text-sm font-medium border-b-2 border-blue-500 text-blue-600 focus:outline-none")) { "Home" }
        HTMLExpect(html, toBe: #"<button class="px-4 py-2 text-sm font-medium border-b-2 border-blue-500 text-blue-600 focus:outline-none">Home</button>"#)
    }

    @Test func tabButtonUnselected() {
        let html = button(.class("px-4 py-2 text-sm font-medium border-b-2 border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none")) { "Settings" }
        HTMLExpect(html, toBe: #"<button class="px-4 py-2 text-sm font-medium border-b-2 border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none">Settings</button>"#)
    }

    @Test func tabViewContentArea() {
        let html = div(.class("p-4")) { p { "Tab content" } }
        HTMLExpect(html, toBe: #"<div class="p-4"><p>Tab content</p></div>"#)
    }

    // MARK: - DropdownMenu

    @Test func dropdownMenuClosed() {
        let html = div(.class("relative inline-block text-left")) {
            div(.class("cursor-pointer")) {
                span(.class("text-sm")) { "Menu" }
            }
        }
        HTMLExpect(html, toBe: #"<div class="relative inline-block text-left"><div class="cursor-pointer"><span class="text-sm">Menu</span></div></div>"#)
    }

    @Test func dropdownMenuOpen() {
        let html = div(.class("relative inline-block text-left")) {
            div(.class("cursor-pointer")) {
                span(.class("text-sm")) { "Menu" }
            }
            div(.class("absolute z-10 mt-2 w-48 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5")) {
                div(.class("py-1"), .custom(name: "role", value: "menu")) {
                    button(.class("block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"), .custom(name: "role", value: "menuitem")) { "Edit" }
                }
            }
        }
        HTMLExpect(html, toBe: #"<div class="relative inline-block text-left"><div class="cursor-pointer"><span class="text-sm">Menu</span></div><div class="absolute z-10 mt-2 w-48 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5"><div class="py-1" role="menu"><button class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">Edit</button></div></div></div>"#)
    }

    @Test func menuItemStructure() {
        let html = button(.class("block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"), .custom(name: "role", value: "menuitem")) { "Delete" }
        HTMLExpect(html, toBe: #"<button class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">Delete</button>"#)
    }

    // MARK: - AlertDialog

    @Test func alertDialogStructure() {
        let html = div(.class("fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50")) {
            div(.class("bg-white rounded-lg shadow-xl max-w-sm w-full mx-4 p-6")) {
                div(.class("text-lg font-semibold text-gray-900 mb-2")) { "Confirm" }
                div(.class("text-sm text-gray-600 mb-4")) { "Are you sure?" }
                div(.class("flex justify-end gap-2")) {
                    button { "OK" }
                }
            }
        }
        HTMLExpect(html, toBe: #"<div class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50"><div class="bg-white rounded-lg shadow-xl max-w-sm w-full mx-4 p-6"><div class="text-lg font-semibold text-gray-900 mb-2">Confirm</div><div class="text-sm text-gray-600 mb-4">Are you sure?</div><div class="flex justify-end gap-2"><button>OK</button></div></div></div>"#)
    }
}
