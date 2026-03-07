//
//  CSSFontInfo.swift
//  ElementaryViews
//

public struct CSSFontInfo: Sendable {
    public let size: CSSTextSize
    public let color: CSSColorKey?
    public let align: CSSTextAlign?

    public init(size: CSSTextSize = .sm, color: CSSColorKey? = nil, align: CSSTextAlign? = nil) {
        self.size = size
        self.color = color
        self.align = align
    }

    public var css: String {
        var parts = [size.rawValue]
        if let color {
            parts.append("text-\(color.rawValue)")
        }
        if let align {
            parts.append(align.rawValue)
        }
        return parts.joined(separator: " ")
    }
}
