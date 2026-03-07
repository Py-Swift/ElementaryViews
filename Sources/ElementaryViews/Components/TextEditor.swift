//
//  TextEditor.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView
public struct TextEditor {

    @Binding var text: String
    let placeholder: String
    let rows: Int
    let font: CSSFontInfo
    let padding: CSSPadding
    let border: CSSBorderInfo
    let bg_color: CSSColorKey?

    public init(
        text: Binding<String>,
        placeholder: String = "",
        rows: Int = 4,
        font: CSSFontInfo = .init(),
        padding: CSSPadding = .init(),
        border: CSSBorderInfo = .init(color: .gray_200),
        bg_color: CSSColorKey? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.rows = rows
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
        textarea(
            .class("w-full resize-y \(border.css) \(padding.css) \(font.css) \(bgClass)"),
            .custom(name: "rows", value: String(rows)),
            .placeholder(placeholder)
        ) { text }
        .onInput { event in
            if let newValue = event.targetValue {
                text = newValue
            }
        }
    }
}
