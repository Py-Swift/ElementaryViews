//
//  Button.swift
//  ElementaryViews
//
import ElementaryUI
import Foundation

/// Expands to `button { <label> }`. Chain `.onClick { }` on the result for interactivity.
@freestanding(expression)
public macro Button<T: HTML>(
    @HTMLBuilder _ label: () -> T
) -> HTMLElement<HTMLTag.button, T> = #externalMacro(module: "ViewMacros", type: "ButtonMacro")

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


