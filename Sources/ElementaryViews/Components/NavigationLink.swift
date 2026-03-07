//
//  NavigationLink.swift
//  ElementaryViews
//
import ElementaryUI

/// A styled navigation link that renders as an anchor element.
/// Similar to SwiftUI's `NavigationLink` but for web navigation via URLs.
@PublicView(.a)
public struct NavigationLink<Label: View> {

    let destination: String
    let label: Label
    let openInNewTab: Bool

    /// Creates a navigation link with a custom label view.
    public init(
        destination: String,
        openInNewTab: Bool = false,
        @HTMLBuilder label: () -> Label
    ) {
        self.destination = destination
        self.openInNewTab = openInNewTab
        self.label = label()
    }

    public var body: some View {
        if openInNewTab {
            a(.href(destination), .target(.blank), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
                label
                // Disclosure indicator for new tab
                span(.class("text-gray-400 text-xs")) { "↗" }
            }
        } else {
            a(.href(destination), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
                label
                // Disclosure chevron
                span(.class("text-gray-400 text-xs")) { "›" }
            }
        }
    }
}

extension NavigationLink where Label == Text {
    /// Creates a navigation link with a text label.
    public init(_ title: String, destination: String, openInNewTab: Bool = false) {
        self.destination = destination
        self.openInNewTab = openInNewTab
        self.label = Text(title)
    }
}
