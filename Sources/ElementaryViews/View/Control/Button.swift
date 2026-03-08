//
//  Button.swift
//  ElementaryViews
//
import ElementaryUI
import Foundation

extension HTMLAttribute where Tag == HTMLTag.button {
    public static var defaultRed: Self {
        .class("text-red-500 hover:text-red-700 text-sm cursor-pointer px-2")
    }
}

@PublicView
public struct __Button {
    
    let text: String
    let onClick: () -> Void
    
    //@State private var updateCount = 0
    
    
//    public init(@HTMLBuilder label: () -> Label, onClick: @escaping () -> Void) {
//        self.label = label()
//        self.onClick = onClick
//    }
//    
//    public init(label: Label, onClick: @escaping () -> Void) {
//        self.label = label
//        self.onClick = onClick
//    }
    
    public init(text: String, onClick: @escaping () -> Void)  {
        self.text = text
        self.onClick = onClick
    }
    
    public var body: some View {
        button { text }
//            .onClick {
//                onClick()
//                //updateCount += 1
//            }
    }
}

@PublicView(.button)
public struct Button<Label: View> {

    let label: Label
    let onClick: () -> Void
    
    @State private var updateCount = 0
    

    public init(@HTMLBuilder label: () -> Label, onClick: @escaping () -> Void) {
        self.label = label()
        self.onClick = onClick
    }

    public init(label: Label, onClick: @escaping () -> Void) {
        self.label = label
        self.onClick = onClick
    }

    public init(text: String, onClick: @escaping () -> Void) where Label == Text {
        self.label = Text(text)
        self.onClick = onClick
    }

    public var body: some View {
        button { label }
            .onClick {
                onClick()
                updateCount += 1
            }
    }
}

extension Button {
    //public typealias Tag = HTMLTag.button
}
