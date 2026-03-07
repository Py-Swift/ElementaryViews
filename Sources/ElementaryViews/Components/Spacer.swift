//
//  Spacer.swift
//  ElementaryViews
//
import ElementaryUI

/// A flexible space that expands along the major axis of its containing stack.
/// Equivalent to SwiftUI's `Spacer`.
@PublicView
public struct Spacer {

    let minLength: Int?

    public init(minLength: Int? = nil) {
        self.minLength = minLength
    }

    private var css: String {
        if let minLength {
            "flex-grow min-w-[\(minLength)px] min-h-[\(minLength)px]"
        } else {
            "flex-grow"
        }
    }

    public var body: some View {
        div(.class(css)) {}
    }
}
