//
//  Toggle.swift
//  ElementaryViews
//
import ElementaryUI

/// A toggle switch control. Equivalent to SwiftUI's `Toggle`.
/// Renders as a styled checkbox input with a sliding switch appearance.
@PublicView(.label)
public struct Toggle<Label: View> {

    @Binding var isOn: Bool
    let label: Label

    public init(isOn: Binding<Bool>, @HTMLBuilder label: () -> Label) {
        self._isOn = isOn
        self.label = label()
    }

    public init(_ text: Label, isOn: Binding<Bool>) where Label: StringProtocol {
        self._isOn = isOn
        self.label = text
    }

    public var body: some View {
        Elementary.label(.class("inline-flex items-center gap-2 cursor-pointer")) {
            input(.type(.checkbox), .class("sr-only peer"))
                .bindChecked($isOn)
            div(
                .class("relative w-9 h-5 bg-gray-200 dark:bg-gray-700 peer-checked:bg-indigo-600 rounded-full after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:rounded-full after:h-4 after:w-4 after:transition-all peer-checked:after:translate-x-full")
            ) {}
            span(.class("text-sm")) { label }
        }
    }
}
