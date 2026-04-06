//
//  ScrollView.swift
//  ElementaryViews
//
import ElementaryUI

public enum ScrollViewAxis: Sendable {
    case vertical
    case horizontal
    case both
}

public func ScrollView<C: View>(
    _ axis: ScrollViewAxis = .vertical,
    showsIndicators: Bool = true,
    @HTMLBuilder content: () -> C
) -> some View {
    let overflow: String
    switch axis {
    case .vertical:   overflow = "overflow-y-auto"
    case .horizontal: overflow = "overflow-x-auto"
    case .both:       overflow = "overflow-auto"
    }
    let scrollbarClass = showsIndicators ? "" : " scrollbar-hide"
    return div(.class("\(overflow)\(scrollbarClass)")) {
        content()
    }
}

