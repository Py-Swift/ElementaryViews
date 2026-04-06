//
//  NavigationLink.swift
//  ElementaryViews
//
import ElementaryUI

/// A styled anchor link for URL navigation.
@HTMLBuilder
public func NavigationLink<L: View>(
    destination: String,
    openInNewTab: Bool = false,
    @HTMLBuilder label: () -> L
) -> some View {
    if openInNewTab {
        a(.href(destination), .target(.blank), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
            label()
            span(.class("text-gray-400 text-xs")) { "↗" }
        }
    } else {
        a(.href(destination), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
            label()
            span(.class("text-gray-400 text-xs")) { "›" }
        }
    }
}

/// A value-based navigation link that appends to a `NavigationStack` path.
public func NavigationLink<V: Hashable, L: View>(
    value: V,
    path: Binding<[V]>,
    @HTMLBuilder label: () -> L
) -> some View {
    a(.href("#"), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
        label()
        span(.class("text-gray-400 text-xs")) { "›" }
    }
    .onClick { path.wrappedValue.append(value) }
}

/// Creates a navigation link with a text label for URL navigation.
public func NavigationLink(_ title: String, destination: String, openInNewTab: Bool = false) -> some View {
    NavigationLink(destination: destination, openInNewTab: openInNewTab) { Text(title) }
}

/// Creates a value-based navigation link with a text label.
public func NavigationLink<V: Hashable>(_ title: String, value: V, path: Binding<[V]>) -> some View {
    NavigationLink(value: value, path: path) { Text(title) }
}

