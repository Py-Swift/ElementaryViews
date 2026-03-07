//
//  Section.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView(.section)
public struct Section<SectionHeader: View, SectionContent: View> {

    let header: SectionHeader
    let sectionContent: SectionContent

    public init(
        @HTMLBuilder content: () -> SectionContent,
        @HTMLBuilder header: () -> SectionHeader
    ) {
        self.header = header()
        self.sectionContent = content()
    }

    public var body: some View {
        section(.class("space-y-2")) {
            div(.class("font-semibold text-sm text-gray-700")) { header }
            sectionContent
        }
    }
}

// Convenience init for string headers
extension Section where SectionHeader == Text {
    public init(
        _ title: String,
        font: CSSFontInfo = CSSFontInfo(size: .sm),
        @HTMLBuilder content: () -> SectionContent
    ) {
        self.header = Text(title, font: font)
        self.sectionContent = content()
    }
}
