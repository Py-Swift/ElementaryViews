//
//  Toggle.swift
//  ElementaryViews
//
import ElementaryUI

/// A styled toggle switch. Wraps in an `Elementary.label` with a hidden checkbox,
/// animated track, and a `span` for the label content.
public func Toggle<T: View>(
    isOn: Binding<Bool>,
    @HTMLBuilder label: () -> T
) -> some View {
    Elementary.label(.class("inline-flex items-center gap-2 cursor-pointer")) {
        input(.type(.checkbox), .class("sr-only peer"))
            .bindChecked(isOn)
        div(.class("relative w-11 h-6 bg-gray-200 peer-checked:bg-blue-500 rounded-full after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:after:translate-x-full")) {}
        span(.class("text-sm")) { label() }
    }
}

