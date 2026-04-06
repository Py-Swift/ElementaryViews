//
//  TabView.swift
//  ElementaryViews
//
import ElementaryUI

/// A container that switches between child views using a tab bar.
/// Similar to SwiftUI's `TabView` with a horizontal tab bar.
public func TabView<T: View>(
    tabs: [TabItem],
    @HTMLBuilder content: () -> T
) -> some View {
    div(.class("flex flex-col")) {
        div(.class("flex border-b border-gray-200")) {
            ForEach(tabs, key: \.title) { tab in
                TabButton(tab: tab)
            }
        }
        div(.class("p-4")) {
            content()
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
