//
//  Form.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView
public struct Form<FormContent: View> {

    let formContent: FormContent
    let spacing: String

    public typealias Tag = HTMLTag.form

    public init(
        spacing: String = "4",
        @HTMLBuilder content: () -> FormContent
    ) {
        self.formContent = content()
        self.spacing = spacing
    }

    public var body: some View {
        form(.class("flex flex-col gap-\(spacing)")) {
            formContent
        }
    }
}
