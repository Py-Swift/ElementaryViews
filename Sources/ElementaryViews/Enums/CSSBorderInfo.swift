//
//  CSSBorderInfo.swift
//  ElementaryViews
//

public struct CSSBorderInfo: Sendable {
    public let color: CSSColorKey
    public let width: Int?

    public init(color: CSSColorKey, width: Int? = nil) {
        self.color = color
        self.width = width
    }

    public var widthClass: String {
        if let width {
            "border-\(width)"
        } else {
            "border"
        }
    }

    public var css: String {
        "\(widthClass) border-\(color.rawValue) rounded"
    }
}
