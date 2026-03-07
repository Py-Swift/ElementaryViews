//
//  TabView.swift
//  ElementaryViews
//
import ElementaryUI

/// A container that switches between child views using a tab bar.
/// Similar to SwiftUI's `TabView` with a horizontal tab bar.
@PublicView(.div)
public struct TabView<TabContent: View> {

    let tabItems: [TabItem]
    let tabContent: TabContent

    /// Creates a tab view with labeled tabs and content.
    /// Mark the active tab by setting `isSelected: true` on the corresponding `TabItem`.
    public init(
        tabs: [TabItem],
        @HTMLBuilder content: () -> TabContent
    ) {
        self.tabItems = tabs
        self.tabContent = content()
    }

    public var body: some View {
        div(.class("flex flex-col")) {
            // Tab bar
            div(.class("flex border-b border-gray-200")) {
                ForEach(tabItems, key: \.title) { tab in
                    TabButton(tab: tab)
                }
            }

            // Content area
            div(.class("p-4")) {
                tabContent
            }
        }
    }
}

/// A single tab button inside a `TabView` tab bar.
@PublicView
struct TabButton {

    let tab: TabItem

    init(tab: TabItem) {
        self.tab = tab
    }

    private var buttonClass: String {
        let sc = tab.isSelected
            ? "border-blue-500 text-blue-600"
            : "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300"
        return "px-4 py-2 text-sm font-medium border-b-2 \(sc) focus:outline-none"
    }

    var body: some View {
        button(.class(buttonClass)) {
            tab.title
        }.onClick { tab.onSelect() }
    }
}

/// Describes a single tab in a `TabView`.
public struct TabItem: Sendable {
    public let title: String
    public let isSelected: Bool
    public let onSelect: @Sendable () -> Void

    public init(title: String, isSelected: Bool = false, onSelect: @escaping @Sendable () -> Void) {
        self.title = title
        self.isSelected = isSelected
        self.onSelect = onSelect
    }
}
