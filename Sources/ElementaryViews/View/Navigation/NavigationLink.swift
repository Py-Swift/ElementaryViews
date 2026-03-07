//
//  NavigationLink.swift
//  ElementaryViews
//
import ElementaryUI

/// A styled navigation link that renders as an anchor element.
///
/// Supports two navigation modes:
/// - **URL-based**: Navigates to a URL via standard `<a href>` (full page navigation).
/// - **Value-based**: Pushes a value onto a `NavigationStack` path (SPA-style navigation).
///
/// ## URL Navigation
/// ```swift
/// NavigationLink(destination: "/about") {
///     Text("About")
/// }
/// ```
///
/// ## Value-Based Navigation
/// ```swift
/// NavigationLink(value: park, path: $parks) {
///     Text(park.name)
/// }
/// ```
@PublicView(.a)
public struct NavigationLink<Label: View> {

    let destination: String
    let label: Label
    let openInNewTab: Bool
    let isValueBased: Bool
    let action: () -> Void

    /// Creates a navigation link with a custom label view for URL navigation.
    public init(
        destination: String,
        openInNewTab: Bool = false,
        @HTMLBuilder label: () -> Label
    ) {
        self.destination = destination
        self.openInNewTab = openInNewTab
        self.isValueBased = false
        self.action = {}
        self.label = label()
    }

    /// Creates a value-based navigation link that pushes a value onto a navigation stack path.
    ///
    /// When tapped, the link appends `value` to the bound `path` array,
    /// causing the parent `NavigationStack` to display the corresponding destination view.
    ///
    /// - Parameters:
    ///   - value: The hashable value to push onto the path.
    ///   - path: A binding to the navigation stack's path array.
    ///   - label: The label view.
    public init<V: Hashable>(
        value: V,
        path: Binding<[V]>,
        @HTMLBuilder label: () -> Label
    ) {
        self.destination = "#"
        self.openInNewTab = false
        self.isValueBased = true
        self.action = { path.wrappedValue.append(value) }
        self.label = label()
    }

    public var body: some View {
        if isValueBased {
            a(.href("#"), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
                label
                span(.class("text-gray-400 text-xs")) { "›" }
            }
            .onClick { action() }
        } else if openInNewTab {
            a(.href(destination), .target(.blank), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
                label
                span(.class("text-gray-400 text-xs")) { "↗" }
            }
        } else {
            a(.href(destination), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
                label
                span(.class("text-gray-400 text-xs")) { "›" }
            }
        }
    }
}

extension NavigationLink where Label == Text {
    /// Creates a navigation link with a text label for URL navigation.
    public init(_ title: String, destination: String, openInNewTab: Bool = false) {
        self.destination = destination
        self.openInNewTab = openInNewTab
        self.isValueBased = false
        self.action = {}
        self.label = Text(title)
    }

    /// Creates a value-based navigation link with a text label.
    ///
    /// - Parameters:
    ///   - title: The text to display.
    ///   - value: The hashable value to push onto the path.
    ///   - path: A binding to the navigation stack's path array.
    public init<V: Hashable>(_ title: String, value: V, path: Binding<[V]>) {
        self.destination = "#"
        self.openInNewTab = false
        self.isValueBased = true
        self.action = { path.wrappedValue.append(value) }
        self.label = Text(title)
    }
}
