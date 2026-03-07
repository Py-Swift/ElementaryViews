//
//  Button.swift
//  ElementaryViews
//
import ElementaryUI

extension HTMLAttribute where Tag == HTMLTag.button {
    public static var defaultRed: Self {
        .class("text-red-500 hover:text-red-700 text-sm cursor-pointer px-2")
    }
}

@PublicView
public struct Button<Label: View> {

    let label: Label
    let onClick: () -> Void

    public typealias Tag = HTMLTag.button

    public init(@HTMLBuilder label: () -> Label, onClick: @escaping () -> Void) {
        self.label = label()
        self.onClick = onClick
    }

    public init(label: Label, onClick: @escaping () -> Void) {
        self.label = label
        self.onClick = onClick
    }

    public init(text: Label, onClick: @escaping () -> Void) where Label: StringProtocol {
        self.label = text
        self.onClick = onClick
    }

    public var body: some View {
        button { label }
            .onClick(onClick)
    }
}
