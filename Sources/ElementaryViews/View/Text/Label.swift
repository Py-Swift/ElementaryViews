//
//  Label.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView
public struct Label {
    let text: String
    let font: CSSFontInfo
    let width: TextWidthStyle
    let padding: CSSPadding
    let bg_color: CSSColorKey

    public init(text: String, font: CSSFontInfo = .init(), width: TextWidthStyle = .w_1_3, padding: CSSPadding = .init(), bg_color: CSSColorKey) {
        self.text = text
        self.font = font
        self.width = width
        self.padding = padding
        self.bg_color = bg_color
    }

    public init<T>(text: T, font: CSSFontInfo = .init(), width: TextWidthStyle = .w_1_3, padding: CSSPadding = .init(), bg_color: CSSColorKey) where T: RawRepresentable, T.RawValue == String {
        self.text = text.rawValue
        self.font = font
        self.width = width
        self.padding = padding
        self.bg_color = bg_color
    }

    public var body: some View {
        span(.class("\(width.rawValue) inline-block rounded \(padding.css) \(font.css) bg-\(bg_color.rawValue)")) {
            text
        }
    }
}
