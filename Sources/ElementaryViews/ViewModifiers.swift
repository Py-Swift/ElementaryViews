//
//  ViewModifiers.swift
//  ElementaryViews
//
import Elementary
import ElementaryUI

// MARK: - Internal helper: wrap a View in a Button
extension View {

    public consuming func _button(_ onClick: @escaping () -> Void) -> Button<Self> {
        Button(label: self, onClick: onClick)
    }
}

// MARK: - Tailwind CSS class-based view modifiers
// These add Tailwind utility classes via `.attributes(.class(...))` without
// adding extra DOM nodes. They preserve the original element's Tag identity.

extension HTML where Tag: HTMLTrait.Attributes.Global {

    // MARK: Typography

    /// Applies `font-bold` to the element.
    public func bold() -> _AttributedElement<Self> {
        attributes(.class("font-bold"))
    }

    /// Applies `italic` to the element.
    public func italic() -> _AttributedElement<Self> {
        attributes(.class("italic"))
    }

    /// Applies `underline` to the element.
    public func underline() -> _AttributedElement<Self> {
        attributes(.class("underline"))
    }

    /// Applies `line-through` (strikethrough) to the element.
    public func strikethrough() -> _AttributedElement<Self> {
        attributes(.class("line-through"))
    }

    /// Sets the font weight via Tailwind class.
    public func fontWeight(_ weight: CSSFontWeight) -> _AttributedElement<Self> {
        attributes(.class(weight.rawValue))
    }

    /// Sets the font size via Tailwind class.
    public func fontSize(_ size: CSSTextSize) -> _AttributedElement<Self> {
        attributes(.class(size.rawValue))
    }

    /// Sets the text alignment via Tailwind class.
    public func textAlign(_ alignment: CSSTextAlign) -> _AttributedElement<Self> {
        attributes(.class(alignment.rawValue))
    }

    // MARK: Colors

    /// Sets the text color via Tailwind `text-{color}` class.
    public func foregroundColor(_ color: CSSColorKey) -> _AttributedElement<Self> {
        attributes(.class("text-\(color.rawValue)"))
    }

    /// Sets the background color via Tailwind `bg-{color}` class.
    public func background(_ color: CSSColorKey) -> _AttributedElement<Self> {
        attributes(.class("bg-\(color.rawValue)"))
    }

    // MARK: Layout & Spacing

    /// Applies padding via Tailwind padding classes.
    public func padding(_ padding: CSSPadding) -> _AttributedElement<Self> {
        attributes(.class(padding.css))
    }

    /// Sets the corner radius via Tailwind rounded class.
    public func cornerRadius(_ radius: CSSCornerRadius) -> _AttributedElement<Self> {
        attributes(.class(radius.rawValue))
    }

    /// Sets width and/or height via Tailwind classes.
    /// Pass Tailwind size tokens like `"full"`, `"screen"`, `"64"`, `"auto"`, `"fit"`, or arbitrary values like `"[200px]"`.
    public func frame(width: String? = nil, height: String? = nil) -> _AttributedElement<Self> {
        var classes: [String] = []
        if let width { classes.append("w-\(width)") }
        if let height { classes.append("h-\(height)") }
        return attributes(.class(classes.joined(separator: " ")))
    }

    // MARK: Effects

    /// Applies a Tailwind shadow class.
    public func shadow(_ shadow: CSSShadow) -> _AttributedElement<Self> {
        attributes(.class(shadow.rawValue))
    }

    // MARK: Visibility & Interaction

    /// Conditionally applies the `hidden` Tailwind class.
    public func hidden(_ isHidden: Bool = true) -> _AttributedElement<Self> {
        attributes(.class("hidden"), when: isHidden)
    }

    /// Applies disabled visual styling: reduced opacity and no pointer events.
    public func disabled(_ isDisabled: Bool = true) -> _AttributedElement<Self> {
        attributes(.class("opacity-50 pointer-events-none"), when: isDisabled)
    }

    // MARK: Borders

    /// Applies border styling via Tailwind classes.
    public func border(_ border: CSSBorderInfo) -> _AttributedElement<Self> {
        attributes(.class(border.css))
    }
}
