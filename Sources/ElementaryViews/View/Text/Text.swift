//
//  Text.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView
public struct Text {
    let text: String
    let font: CSSFontInfo

    public init(_ text: String, font: CSSFontInfo = .init()) {
        self.text = text
        self.font = font
    }

    public init<T>(_ text: T, font: CSSFontInfo = .init()) where T: RawRepresentable, T.RawValue == String {
        self.text = text.rawValue
        self.font = font
    }

    public var body: some View {
        span(.class("\(font.css)")) {
            text
        }
    }
}
