//
//  Divider.swift
//  ElementaryViews
//
import ElementaryUI

/// A visual separator line. Equivalent to SwiftUI's `Divider`.
@PublicView
public struct Divider {

    let color: CSSColorKey

    public init(color: CSSColorKey = .gray_200) {
        self.color = color
    }

    public var body: some View {
        hr(.class("border-t border-\(color.rawValue) my-2 w-full"))
    }
}
