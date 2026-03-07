//
//  WebImage.swift
//  ElementaryViews
//
import ElementaryUI

/// An image view for web URLs. Named `WebImage` to avoid conflict with HTML `img` element.
/// Equivalent to SwiftUI's `Image` (URL-based).
@PublicView
public struct WebImage {

    let src: String
    let alt: String
    let width: String?
    let height: String?
    let cornerRadius: CSSCornerRadius
    let objectFit: CSSObjectFit

    public init(
        src: String,
        alt: String = "",
        width: String? = nil,
        height: String? = nil,
        cornerRadius: CSSCornerRadius = .none,
        objectFit: CSSObjectFit = .cover
    ) {
        self.src = src
        self.alt = alt
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.objectFit = objectFit
    }

    private var css: String {
        var parts: [String] = [objectFit.rawValue]
        if let width { parts.append(width) }
        if let height { parts.append(height) }
        if cornerRadius != .none { parts.append(cornerRadius.rawValue) }
        return parts.joined(separator: " ")
    }

    public var body: some View {
        img(.src(src), .alt(alt), .class(css))
    }
}
