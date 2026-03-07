//
//  ViewRenderTests.swift
//  ElementaryViewsTests
//
//  Tests that actual view struct instances render the expected HTML
//  via Elementary's .render() method. These tests verify the real
//  component output rather than manually-built HTML equivalents.
//
import Elementary
import ElementaryUI
import Testing
@testable import ElementaryViews

// MARK: - Text Views

@Suite("View Struct Rendering")
struct ViewRenderTests {

    // MARK: - Text

    @Test func textDefault() {
        let view = Text("Hello")
        HTMLExpect(view, toBe: #"<span class="text-sm">Hello</span>"#)
    }

    @Test func textWithCustomFont() {
        let view = Text("Hi", font: CSSFontInfo(size: .lg, color: .blue_500))
        HTMLExpect(view, toBe: #"<span class="text-lg text-blue-500">Hi</span>"#)
    }

    @Test func textWithLargeFont() {
        let view = Text("Title", font: CSSFontInfo(size: .xl2))
        HTMLExpect(view, toBe: #"<span class="text-2xl">Title</span>"#)
    }

    @Test func textEmptyString() {
        let view = Text("")
        HTMLExpect(view, toBe: #"<span class="text-sm"></span>"#)
    }

    // MARK: - Badge

    @Test func badgeStandard() {
        let view = Badge("5")
        HTMLExpect(view, toBe: #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">5</span>"#)
    }

    @Test func badgeIncreased() {
        let view = Badge("New", prominence: .increased)
        HTMLExpect(view, toBe: #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">New</span>"#)
    }

    @Test func badgeDecreased() {
        let view = Badge("3", prominence: .decreased)
        HTMLExpect(view, toBe: #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-200 text-gray-600">3</span>"#)
    }

    @Test func badgeFromCount() {
        let view = Badge(42)
        HTMLExpect(view, toBe: #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">42</span>"#)
    }

    @Test func badgeZeroCountRendersEmpty() {
        // Badge(0) produces empty text, so the `if !text.isEmpty` guard skips rendering
        let view = Badge(0)
        HTMLExpect(view, toBe: "")
    }

    // MARK: - Label

    @Test func labelDefault() {
        let view = Label(text: "Name", bg_color: .blue_500)
        HTMLExpect(view, toBe: #"<span class="w-1/3 inline-block rounded px-3 py-1.5 text-sm bg-blue-500">Name</span>"#)
    }

    @Test func labelCustomWidth() {
        let view = Label(text: "Wide", width: .w_full, bg_color: .green_500)
        HTMLExpect(view, toBe: #"<span class="w-full inline-block rounded px-3 py-1.5 text-sm bg-green-500">Wide</span>"#)
    }

    // MARK: - BorderedLabel

    @Test func borderedLabelDefault() {
        let view = BorderedLabel(text: "Value", border: CSSBorderInfo(color: .gray_200), bg_color: .gray_50)
        HTMLExpect(view, toBe: #"<span class="w-full inline-block border border-gray-200 rounded px-3 py-1.5 text-sm bg-gray-50">Value</span>"#)
    }

    // MARK: - RowSymbols

    @Test func equalSymbol() {
        let view = EqualSymbol()
        HTMLExpect(view, toBe: #"<span class="text-gray-400">=</span>"#)
    }

    @Test func colonSymbol() {
        let view = ColonSymbol()
        HTMLExpect(view, toBe: #"<span class="text-gray-400">:</span>"#)
    }

    // MARK: - Spacer

    @Test func spacerDefault() {
        let view = Spacer()
        HTMLExpect(view, toBe: #"<div class="flex-grow"></div>"#)
    }

    @Test func spacerWithMinLength() {
        let view = Spacer(minLength: 20)
        HTMLExpect(view, toBe: #"<div class="flex-grow min-w-[20px] min-h-[20px]"></div>"#)
    }

    @Test func spacerWithLargeMinLength() {
        let view = Spacer(minLength: 100)
        HTMLExpect(view, toBe: #"<div class="flex-grow min-w-[100px] min-h-[100px]"></div>"#)
    }

    // MARK: - Divider

    @Test func dividerDefault() {
        let view = Divider()
        HTMLExpect(view, toBe: #"<hr class="border-t border-gray-200 my-2 w-full">"#)
    }

    @Test func dividerCustomColor() {
        let view = Divider(color: .blue_500)
        HTMLExpect(view, toBe: #"<hr class="border-t border-blue-500 my-2 w-full">"#)
    }

    @Test func dividerRedColor() {
        let view = Divider(color: .red_300)
        HTMLExpect(view, toBe: #"<hr class="border-t border-red-300 my-2 w-full">"#)
    }

    // MARK: - WebImage

    @Test func webImageDefault() {
        let view = WebImage(src: "pic.png")
        HTMLExpect(view, toBe: #"<img src="pic.png" alt="" class="object-cover">"#)
    }

    @Test func webImageWithAlt() {
        let view = WebImage(src: "photo.jpg", alt: "A photo")
        HTMLExpect(view, toBe: #"<img src="photo.jpg" alt="A photo" class="object-cover">"#)
    }

    @Test func webImageWithSizing() {
        let view = WebImage(src: "avatar.png", alt: "Avatar", width: "w-32", height: "h-32", cornerRadius: .full)
        HTMLExpect(view, toBe: #"<img src="avatar.png" alt="Avatar" class="object-cover w-32 h-32 rounded-full">"#)
    }

    @Test func webImageContainFit() {
        let view = WebImage(src: "logo.svg", objectFit: .contain)
        HTMLExpect(view, toBe: #"<img src="logo.svg" alt="" class="object-contain">"#)
    }

    @Test func webImageWithCornerRadius() {
        let view = WebImage(src: "card.png", cornerRadius: .lg)
        HTMLExpect(view, toBe: #"<img src="card.png" alt="" class="object-cover rounded-lg">"#)
    }

    // MARK: - WebLink

    @Test func webLinkDefault() {
        let view = WebLink(destination: "https://example.com") { "Click here" }
        HTMLExpect(view, toBe: #"<a href="https://example.com" class="cursor-pointer">Click here</a>"#)
    }

    @Test func webLinkNewTab() {
        let view = WebLink(destination: "https://example.com", opensInNewTab: true) { "External" }
        HTMLExpect(view, toBe: #"<a href="https://example.com" target="_blank" class="cursor-pointer">External</a>"#)
    }

    @Test func webLinkWithTextContent() {
        let view = WebLink(destination: "https://example.com") { Text("Visit") }
        HTMLExpect(view, toBe: #"<a href="https://example.com" class="cursor-pointer"><span class="text-sm">Visit</span></a>"#)
    }

    // MARK: - NavigationLink (URL mode)

    @Test func navigationLinkDefault() {
        let view = NavigationLink(destination: "/about") { Text("About") }
        HTMLExpect(view, toBe: #"<a href="/about" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">About</span><span class="text-gray-400 text-xs">›</span></a>"#)
    }

    @Test func navigationLinkTextInit() {
        let view = NavigationLink("About", destination: "/about")
        HTMLExpect(view, toBe: #"<a href="/about" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">About</span><span class="text-gray-400 text-xs">›</span></a>"#)
    }

    @Test func navigationLinkNewTab() {
        let view = NavigationLink(destination: "https://example.com", openInNewTab: true) { Text("External") }
        HTMLExpect(view, toBe: #"<a href="https://example.com" target="_blank" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">External</span><span class="text-gray-400 text-xs">↗</span></a>"#)
    }

    @Test func navigationLinkTextNewTab() {
        let view = NavigationLink("External", destination: "https://example.com", openInNewTab: true)
        HTMLExpect(view, toBe: #"<a href="https://example.com" target="_blank" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">External</span><span class="text-gray-400 text-xs">↗</span></a>"#)
    }

    // MARK: - Form

    @Test func formDefault() {
        let view = Form { p { "field" } }
        HTMLExpect(view, toBe: #"<form class="flex flex-col gap-4"><p>field</p></form>"#)
    }

    @Test func formCustomSpacing() {
        let view = Form(spacing: "6") { p { "field" } }
        HTMLExpect(view, toBe: #"<form class="flex flex-col gap-6"><p>field</p></form>"#)
    }

    @Test func formWithMultipleChildren() {
        let view = Form {
            p { "name" }
            p { "email" }
        }
        HTMLExpect(view, toBe: #"<form class="flex flex-col gap-4"><p>name</p><p>email</p></form>"#)
    }

    // MARK: - ListView

    @Test func listViewDefault() {
        let view = ListView { li { "item" } }
        HTMLExpect(view, toBe: #"<ul class="flex flex-col"><li>item</li></ul>"#)
    }

    @Test func listViewDivided() {
        let view = ListView(divided: true) { li { "item" } }
        HTMLExpect(view, toBe: #"<ul class="flex flex-col divide-y divide-gray-200"><li>item</li></ul>"#)
    }

    @Test func listViewMultipleItems() {
        let view = ListView {
            li { "first" }
            li { "second" }
        }
        HTMLExpect(view, toBe: #"<ul class="flex flex-col"><li>first</li><li>second</li></ul>"#)
    }

    // MARK: - Section

    @Test func sectionWithStringHeader() {
        let view = Section("Title") { p { "content" } }
        HTMLExpect(view, toBe: #"<section class="space-y-2"><div class="font-semibold text-sm text-gray-700"><span class="text-sm">Title</span></div><p>content</p></section>"#)
    }

    @Test func sectionWithCustomHeader() {
        let view = Section(content: { p { "body" } }, header: { span { "Custom" } })
        HTMLExpect(view, toBe: #"<section class="space-y-2"><div class="font-semibold text-sm text-gray-700"><span>Custom</span></div><p>body</p></section>"#)
    }

    @Test func sectionWithMultipleContent() {
        let view = Section("Header") {
            p { "line 1" }
            p { "line 2" }
        }
        HTMLExpect(view, toBe: #"<section class="space-y-2"><div class="font-semibold text-sm text-gray-700"><span class="text-sm">Header</span></div><p>line 1</p><p>line 2</p></section>"#)
    }

    // MARK: - ScrollView

    @Test func scrollViewVertical() {
        let view = ScrollView { p { "scrollable" } }
        HTMLExpect(view, toBe: #"<div class="overflow-y-auto"><p>scrollable</p></div>"#)
    }

    @Test func scrollViewHorizontal() {
        let view = ScrollView(.horizontal) { p { "scrollable" } }
        HTMLExpect(view, toBe: #"<div class="overflow-x-auto"><p>scrollable</p></div>"#)
    }

    @Test func scrollViewBoth() {
        let view = ScrollView(.both) { p { "scrollable" } }
        HTMLExpect(view, toBe: #"<div class="overflow-auto"><p>scrollable</p></div>"#)
    }

    @Test func scrollViewHiddenIndicators() {
        let view = ScrollView(showsIndicators: false) { p { "content" } }
        HTMLExpect(view, toBe: #"<div class="overflow-y-auto scrollbar-hide"><p>content</p></div>"#)
    }

    // MARK: - ProgressView

    @Test func progressViewHalf() {
        let view = ProgressView(value: 0.5)
        HTMLExpect(view, toBe: #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 50.0%"></div></div>"#)
    }

    @Test func progressViewFull() {
        let view = ProgressView(value: 1.0)
        HTMLExpect(view, toBe: #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 100.0%"></div></div>"#)
    }

    @Test func progressViewEmpty() {
        let view = ProgressView(value: 0.0)
        HTMLExpect(view, toBe: #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 0.0%"></div></div>"#)
    }

    @Test func progressViewCustomColor() {
        let view = ProgressView(value: 0.75, color: .green_500)
        HTMLExpect(view, toBe: #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-green-500 h-2.5 rounded-full transition-all duration-300" style="width: 75.0%"></div></div>"#)
    }

    @Test func progressViewCustomTotal() {
        let view = ProgressView(value: 3, total: 4)
        HTMLExpect(view, toBe: #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 75.0%"></div></div>"#)
    }

    @Test func progressViewClampedAboveMax() {
        // Value exceeding total clamps to 100%
        let view = ProgressView(value: 2.0, total: 1.0)
        HTMLExpect(view, toBe: #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 100.0%"></div></div>"#)
    }

    // MARK: - AlertDialog

    @Test func alertDialogPresented() {
        let view = AlertDialog("Confirm", message: "Are you sure?") {
            button { "OK" }
        }
        HTMLExpect(view, toBe: #"<div class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50"><div class="bg-white rounded-lg shadow-xl max-w-sm w-full mx-4 p-6"><div class="text-lg font-semibold text-gray-900 mb-2">Confirm</div><div class="text-sm text-gray-600 mb-4">Are you sure?</div><div class="flex justify-end gap-2"><button>OK</button></div></div></div>"#)
    }

    @Test func alertDialogNotPresented() {
        let view = AlertDialog("Hidden", isPresented: false) {
            button { "OK" }
        }
        HTMLExpect(view, toBe: "")
    }

    @Test func alertDialogNoMessage() {
        let view = AlertDialog("Title") {
            button { "Close" }
        }
        HTMLExpect(view, toBe: #"<div class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50"><div class="bg-white rounded-lg shadow-xl max-w-sm w-full mx-4 p-6"><div class="text-lg font-semibold text-gray-900 mb-2">Title</div><div class="flex justify-end gap-2"><button>Close</button></div></div></div>"#)
    }

    @Test func alertDialogMultipleActions() {
        let view = AlertDialog("Delete?", message: "This cannot be undone.") {
            button { "Cancel" }
            button { "Delete" }
        }
        HTMLExpect(view, toBe: #"<div class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50"><div class="bg-white rounded-lg shadow-xl max-w-sm w-full mx-4 p-6"><div class="text-lg font-semibold text-gray-900 mb-2">Delete?</div><div class="text-sm text-gray-600 mb-4">This cannot be undone.</div><div class="flex justify-end gap-2"><button>Cancel</button><button>Delete</button></div></div></div>"#)
    }

    // MARK: - DropdownMenu (closed state — no event handlers rendered)

    @Test func dropdownMenuClosed() {
        let view = DropdownMenu(isOpen: false) {
            Text("Menu")
        } content: {
            p { "item" }
        }
        HTMLExpect(view, toBe: #"<div class="relative inline-block text-left"><div class="cursor-pointer"><span class="text-sm">Menu</span></div></div>"#)
    }

    @Test func dropdownMenuClosedTextInit() {
        let view = DropdownMenu("Actions") {
            p { "item" }
        }
        HTMLExpect(view, toBe: #"<div class="relative inline-block text-left"><div class="cursor-pointer"><span class="text-sm">Actions</span></div></div>"#)
    }

    // MARK: - NavigationStack with Binding

    @Test func navigationStackEmptyPath() {
        var path: [String] = []
        let binding = Binding(get: { path }, set: { path = $0 })
        let view = NavigationStack(path: binding) {
            p { "Root Content" }
        } destination: { (item: String) in
            p { "Detail: \(item)" }
        }
        HTMLExpect(view, toBe: #"<p>Root Content</p>"#)
    }

    @Test func navigationStackWithItem() {
        var path: [String] = ["Yosemite"]
        let binding = Binding(get: { path }, set: { path = $0 })
        let view = NavigationStack(path: binding) {
            p { "Root" }
        } destination: { (item: String) in
            span { "Detail: \(item)" }
        }
        HTMLExpect(view, toBe: #"<span>Detail: Yosemite</span>"#)
    }

    @Test func navigationStackShowsTopItem() {
        // With multiple items, only the top (last) is rendered
        var path = ["First", "Second", "Third"]
        let binding = Binding(get: { path }, set: { path = $0 })
        let view = NavigationStack(path: binding) {
            p { "Root" }
        } destination: { (item: String) in
            span { "Showing: \(item)" }
        }
        HTMLExpect(view, toBe: #"<span>Showing: Third</span>"#)
    }

    @Test func navigationStackPushViaBinding() {
        // Verify that modifying the path binding pushes correctly
        var path: [Int] = []
        let binding = Binding(get: { path }, set: { path = $0 })

        // Initially shows root
        let rootView = NavigationStack(path: binding) {
            p { "Root" }
        } destination: { (n: Int) in
            span { "Item \(n)" }
        }
        HTMLExpect(rootView, toBe: #"<p>Root</p>"#)

        // Push via binding
        path.append(42)
        let detailView = NavigationStack(path: binding) {
            p { "Root" }
        } destination: { (n: Int) in
            span { "Item \(n)" }
        }
        HTMLExpect(detailView, toBe: #"<span>Item 42</span>"#)
    }

    @Test func navigationStackPopViaBinding() {
        var path = ["A", "B"]
        let binding = Binding(get: { path }, set: { path = $0 })

        // Shows B
        let beforePop = NavigationStack(path: binding) {
            p { "Root" }
        } destination: { (item: String) in
            span { item }
        }
        HTMLExpect(beforePop, toBe: #"<span>B</span>"#)

        // Pop
        path.removeLast()
        let afterPop = NavigationStack(path: binding) {
            p { "Root" }
        } destination: { (item: String) in
            span { item }
        }
        HTMLExpect(afterPop, toBe: #"<span>A</span>"#)

        // Pop to root
        path.removeAll()
        let atRoot = NavigationStack(path: binding) {
            p { "Root" }
        } destination: { (item: String) in
            span { item }
        }
        HTMLExpect(atRoot, toBe: #"<p>Root</p>"#)
    }

    // MARK: - Composed Views

    @Test func formWithSection() {
        let view = Form {
            Section("Info") {
                p { "Name field" }
            }
        }
        HTMLExpect(view, toBe: #"<form class="flex flex-col gap-4"><section class="space-y-2"><div class="font-semibold text-sm text-gray-700"><span class="text-sm">Info</span></div><p>Name field</p></section></form>"#)
    }

    @Test func listViewWithTextItems() {
        let view = ListView {
            li { Text("Item A") }
            li { Text("Item B") }
        }
        HTMLExpect(view, toBe: #"<ul class="flex flex-col"><li><span class="text-sm">Item A</span></li><li><span class="text-sm">Item B</span></li></ul>"#)
    }

    @Test func scrollViewWithListView() {
        let view = ScrollView {
            ListView {
                li { "row" }
            }
        }
        HTMLExpect(view, toBe: #"<div class="overflow-y-auto"><ul class="flex flex-col"><li>row</li></ul></div>"#)
    }

    @Test func navigationLinkInsideListView() {
        let view = ListView {
            li {
                NavigationLink("Page 1", destination: "/page1")
            }
            li {
                NavigationLink("Page 2", destination: "/page2")
            }
        }
        HTMLExpect(view, toBe: #"<ul class="flex flex-col"><li><a href="/page1" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">Page 1</span><span class="text-gray-400 text-xs">›</span></a></li><li><a href="/page2" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">Page 2</span><span class="text-gray-400 text-xs">›</span></a></li></ul>"#)
    }

    @Test func sectionWithDivider() {
        let view = Section("Settings") {
            p { "Option A" }
            Divider()
            p { "Option B" }
        }
        HTMLExpect(view, toBe: #"<section class="space-y-2"><div class="font-semibold text-sm text-gray-700"><span class="text-sm">Settings</span></div><p>Option A</p><hr class="border-t border-gray-200 my-2 w-full"><p>Option B</p></section>"#)
    }

    @Test func formWithSpacer() {
        let view = Form {
            p { "Top" }
            Spacer()
            p { "Bottom" }
        }
        HTMLExpect(view, toBe: #"<form class="flex flex-col gap-4"><p>Top</p><div class="flex-grow"></div><p>Bottom</p></form>"#)
    }

    @Test func navigationStackWithComposedDestination() {
        var path = ["detail"]
        let binding = Binding(get: { path }, set: { path = $0 })
        let view = NavigationStack(path: binding) {
            Text("Home")
        } destination: { (item: String) in
            Section(item) {
                ProgressView(value: 0.5)
            }
        }
        HTMLExpect(view, toBe: #"<section class="space-y-2"><div class="font-semibold text-sm text-gray-700"><span class="text-sm">detail</span></div><div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 50.0%"></div></div></section>"#)
    }
}
