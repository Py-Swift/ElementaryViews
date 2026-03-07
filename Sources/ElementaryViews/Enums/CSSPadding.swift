//
//  CSSPadding.swift
//  ElementaryViews
//

public struct CSSPadding: Sendable {
    public let px: Int
    public let py: Double

    public static let zero = CSSPadding(px: 0, py: 0)

    public init(px: Int = 3, py: Double = 1.5) {
        self.px = px
        self.py = py
    }

    public var css: String {
        "px-\(px) py-\(py)"
    }
}
