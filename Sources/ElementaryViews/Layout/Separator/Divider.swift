//
//  Divider.swift
//  ElementaryViews
//
import ElementaryUI

/// A visual separator line. Equivalent to SwiftUI's `Divider`.
@PublicView
public struct Divider {

    public enum Orientation {
        case horizontal
        case vertical
    }

    let color: CSSColorKey
    let orientation: Orientation

    public init(color: CSSColorKey = .gray_200, orientation: Orientation = .horizontal) {
        self.color = color
        self.orientation = orientation
    }

    public var body: some View {
        // Both branches stay on the `hr` tag deliberately (never `div`) so
        // the macro-inferred `Tag` for this view is unambiguous — no
        // type-erasure needed for the switch. `hr` styled as a vertical
        // bar (`border-l h-full`) instead of its default horizontal rule
        // is non-semantic HTML, but it's a visual-only element either way.
        switch orientation {
        case .horizontal:
            hr(.class("border-t border-\(color.rawValue) my-2 w-full"))
        case .vertical:
            // Tailwind Preflight resets `hr` to `height: 0` (a definite value,
            // not `auto`), which blocks `self-stretch` from taking effect per
            // the flexbox spec — `h-auto` restores the auto cross-size so the
            // stretch actually applies and the line gets real height.
            hr(.class("border-l border-\(color.rawValue) mx-2 h-auto self-stretch"))
        }
    }
}
