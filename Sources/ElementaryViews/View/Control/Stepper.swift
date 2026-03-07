//
//  Stepper.swift
//  ElementaryViews
//
import ElementaryUI

/// A control for incrementing and decrementing a value.
/// Renders as a label with minus/plus buttons, similar to SwiftUI's `Stepper`.
@PublicView(.div)
public struct Stepper<Label: View> {

    let label: Label
    let onIncrement: (() -> Void)?
    let onDecrement: (() -> Void)?

    /// Creates a stepper with custom increment/decrement actions.
    public init(
        onIncrement: (() -> Void)? = nil,
        onDecrement: (() -> Void)? = nil,
        @HTMLBuilder label: () -> Label
    ) {
        self.label = label()
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
    }

    public var body: some View {
        div(.class("inline-flex items-center gap-2")) {
            // Label
            div(.class("text-sm")) { label }

            // Stepper controls
            div(.class("inline-flex items-center border border-gray-300 rounded-lg overflow-hidden")) {
                // Minus button
                button(.class("px-3 py-1 text-gray-600 hover:bg-gray-100 active:bg-gray-200 border-r border-gray-300 font-medium")) {
                    "−"
                }.onClick { onDecrement?() }

                // Plus button
                button(.class("px-3 py-1 text-gray-600 hover:bg-gray-100 active:bg-gray-200 font-medium")) {
                    "+"
                }.onClick { onIncrement?() }
            }
        }
    }
}

extension Stepper where Label == Text {
    /// Creates a stepper with a text label.
    public init(
        _ title: String,
        onIncrement: (() -> Void)? = nil,
        onDecrement: (() -> Void)? = nil
    ) {
        self.label = Text(title)
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
    }
}
