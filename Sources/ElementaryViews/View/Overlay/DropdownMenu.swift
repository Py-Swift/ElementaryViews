//
//  DropdownMenu.swift
//  ElementaryViews
//
import ElementaryUI

/// A dropdown menu that shows a list of actions when triggered.
/// Similar to SwiftUI's `Menu` — renders a button that toggles a dropdown overlay.
public func DropdownMenu<L: View, M: View>(
    isOpen: Bool = false,
    @HTMLBuilder label: () -> L,
    @HTMLBuilder content: () -> M
) -> some View {
    div(.class("relative inline-block text-left")) {
        div(.class("cursor-pointer")) { label() }
        if isOpen {
            div(.class("absolute z-10 mt-2 w-48 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5")) {
                div(.class("py-1"), .custom(name: "role", value: "menu")) {
                    content()
                }
            }
        }
    }
}

/// Creates a dropdown menu with a text label.
public func DropdownMenu<M: View>(
    _ title: String,
    isOpen: Bool = false,
    @HTMLBuilder content: () -> M
) -> some View {
    DropdownMenu(isOpen: isOpen, label: { Text(title) }, content: content)
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
