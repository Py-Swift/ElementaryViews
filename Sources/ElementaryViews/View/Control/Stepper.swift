//
//  Stepper.swift
//  ElementaryViews
//
import ElementaryUI

/// A control for incrementing and decrementing a value.
/// Renders as a label with minus/plus buttons, similar to SwiftUI's `Stepper`.
public func Stepper<L: View>(
    onIncrement: (() -> Void)? = nil,
    onDecrement: (() -> Void)? = nil,
    @HTMLBuilder label: () -> L
) -> some View {
    div(.class("inline-flex items-center gap-2")) {
        div(.class("text-sm")) { label() }
        div(.class("inline-flex items-center border border-gray-300 rounded-lg overflow-hidden")) {
            button(.class("px-3 py-1 text-gray-600 hover:bg-gray-100 active:bg-gray-200 border-r border-gray-300 font-medium")) {
                "−"
            }.onClick { onDecrement?() }
            button(.class("px-3 py-1 text-gray-600 hover:bg-gray-100 active:bg-gray-200 font-medium")) {
                "+"
            }.onClick { onIncrement?() }
        }
    }
}

/// Creates a stepper with a text label.
public func Stepper(
    _ title: String,
    onIncrement: (() -> Void)? = nil,
    onDecrement: (() -> Void)? = nil
) -> some View {
    Stepper(onIncrement: onIncrement, onDecrement: onDecrement) { Text(title) }
}

