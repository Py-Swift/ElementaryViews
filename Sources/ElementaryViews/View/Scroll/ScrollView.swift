//
//  ScrollView.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView(.div)
public struct ScrollView<ScrollContent: View> {

    let axis: Axis
    let showsIndicators: Bool
    let scrollContent: ScrollContent

    public init(
        _ axis: Axis = .vertical,
        showsIndicators: Bool = true,
        @HTMLBuilder content: () -> ScrollContent
    ) {
        self.axis = axis
        self.showsIndicators = showsIndicators
        self.scrollContent = content()
    }

    private var overflowClass: String {
        switch axis {
        case .vertical: "overflow-y-auto"
        case .horizontal: "overflow-x-auto"
        case .both: "overflow-auto"
        }
    }

    private var scrollbarClass: String {
        showsIndicators ? "" : " scrollbar-hide"
    }

    public var body: some View {
        div(.class("\(overflowClass)\(scrollbarClass)")) {
            scrollContent
        }
    }
}

extension ScrollView {
    public enum Axis: Sendable {
        case vertical
        case horizontal
        case both
    }
}
