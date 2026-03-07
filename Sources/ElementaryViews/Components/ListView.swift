//
//  ListView.swift
//  ElementaryViews
//
import ElementaryUI

/// A list container that renders items in a vertical stack with optional dividers.
/// Equivalent to SwiftUI's `List` for simple static content.
@PublicView
public struct ListView<ListContent: View> {

    let listContent: ListContent
    let divided: Bool

    public typealias Tag = HTMLTag.ul

    public init(
        divided: Bool = false,
        @HTMLBuilder content: () -> ListContent
    ) {
        self.listContent = content()
        self.divided = divided
    }

    private var divideClass: String {
        divided ? " divide-y divide-gray-200" : ""
    }

    public var body: some View {
        ul(.class("flex flex-col\(divideClass)")) {
            listContent
        }
    }
}
