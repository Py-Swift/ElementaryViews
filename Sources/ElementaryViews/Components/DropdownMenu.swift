//
//  DropdownMenu.swift
//  ElementaryViews
//
import ElementaryUI

/// A dropdown menu that shows a list of actions when triggered.
/// Similar to SwiftUI's `Menu` — renders a button that toggles a dropdown overlay.
@PublicView(.div)
public struct DropdownMenu<Label: View, MenuContent: View> {

    let label: Label
    let menuContent: MenuContent
    let isOpen: Bool

    /// Creates a dropdown menu.
    ///
    /// - Parameters:
    ///   - isOpen: Whether the menu is currently expanded.
    ///   - label: The trigger button content.
    ///   - content: The dropdown menu items.
    public init(
        isOpen: Bool = false,
        @HTMLBuilder label: () -> Label,
        @HTMLBuilder content: () -> MenuContent
    ) {
        self.isOpen = isOpen
        self.label = label()
        self.menuContent = content()
    }

    public var body: some View {
        div(.class("relative inline-block text-left")) {
            // Trigger button
            div(.class("cursor-pointer")) {
                label
            }

            // Dropdown panel
            if isOpen {
                div(.class("absolute z-10 mt-2 w-48 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5")) {
                    div(.class("py-1"), .custom(name: "role", value: "menu")) {
                        menuContent
                    }
                }
            }
        }
    }
}

extension DropdownMenu where Label == Text {
    /// Creates a dropdown menu with a text label.
    public init(
        _ title: String,
        isOpen: Bool = false,
        @HTMLBuilder content: () -> MenuContent
    ) {
        self.isOpen = isOpen
        self.label = Text(title)
        self.menuContent = content()
    }
}

/// A single item inside a `DropdownMenu`.
@PublicView
public struct MenuItem {
    let title: String
    let action: () -> Void

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        button(.class("block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"), .custom(name: "role", value: "menuitem")) {
            title
        }.onClick(action)
    }
}
