//
//  ProgressView.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView
public struct ProgressView {

    let value: Double
    let total: Double
    let color: CSSColorKey

    public init(
        value: Double,
        total: Double = 1.0,
        color: CSSColorKey = .blue_500
    ) {
        self.value = value
        self.total = total
        self.color = color
    }

    private var percentage: Double {
        guard total > 0 else { return 0 }
        return min(max(value / total, 0), 1) * 100
    }

    public var body: some View {
        div(.class("w-full bg-gray-200 rounded-full h-2.5 overflow-hidden")) {
            div(
                .class("bg-\(color.rawValue) h-2.5 rounded-full transition-all duration-300"),
                .style("width: \(percentage)%")
            ) { "" }
        }
    }
}
