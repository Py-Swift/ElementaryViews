//
//  SecureField.swift
//  ElementaryViews
//
import ElementaryUI

/// A password input field. Equivalent to SwiftUI's `SecureField`.
@PublicView
public struct SecureField {

    let title: String
    @Binding var text: String
    let width: TextWidthStyle
    let font: CSSFontInfo
    let padding: CSSPadding
    let border: CSSBorderInfo
    let bg_color: CSSColorKey?

    public init(
        _ title: String,
        text: Binding<String>,
        width: TextWidthStyle = .flex_1,
        font: CSSFontInfo = .init(),
        padding: CSSPadding = .init(),
        border: CSSBorderInfo = .init(color: .gray_200),
        bg_color: CSSColorKey? = nil
    ) {
        self.title = title
        self._text = text
        self.width = width
        self.font = font
        self.padding = padding
        self.border = border
        self.bg_color = bg_color
    }

    private var bgClass: String {
        if let bg_color {
            "bg-\(bg_color.rawValue)"
        } else {
            ""
        }
    }

    public var body: some View {
        input(
            .type(.password),
            .class("\(width.rawValue) \(border.css) \(padding.css) \(font.css) \(bgClass)"),
            .placeholder(title)
        )
        .bindValue($text)
    }
}
