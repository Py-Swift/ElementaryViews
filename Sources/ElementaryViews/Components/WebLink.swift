//
//  WebLink.swift
//  ElementaryViews
//
import ElementaryUI

/// A hyperlink view. Named `WebLink` to avoid conflict with HTML `a` element.
/// Equivalent to SwiftUI's `Link`.
@PublicView
public struct WebLink<Label: View> {

    let destination: String
    let label: Label
    let opensInNewTab: Bool

    public typealias Tag = HTMLTag.a

    public init(destination: String, opensInNewTab: Bool = false, @HTMLBuilder label: () -> Label) {
        self.destination = destination
        self.opensInNewTab = opensInNewTab
        self.label = label()
    }

    public init(_ text: Label, destination: String, opensInNewTab: Bool = false) where Label: StringProtocol {
        self.destination = destination
        self.opensInNewTab = opensInNewTab
        self.label = text
    }

    public var body: some View {
        if opensInNewTab {
            a(.href(destination), .target(.blank), .class("cursor-pointer")) { label }
        } else {
            a(.href(destination), .class("cursor-pointer")) { label }
        }
    }
}
