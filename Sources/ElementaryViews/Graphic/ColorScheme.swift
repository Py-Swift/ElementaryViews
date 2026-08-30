//
//  ColorScheme.swift
//  ElementaryViews
//
import ElementaryUI

/// The possible color schemes, corresponding to the light and dark appearances.
///
/// Mirrors SwiftUI's `ColorScheme` (`research/SwiftUI-api/SwiftUICore.swift`).
public enum ColorScheme: String, CaseIterable, Sendable, Equatable {
    /// The color scheme that corresponds to a light appearance.
    case light
    /// The color scheme that corresponds to a dark appearance.
    case dark
}

extension EnvironmentValues {
    /// The color scheme of this environment.
    ///
    /// Read this only when a view has to *branch* on the appearance — pick a
    /// different icon, say. Colors don't need it: a ``SchemeColor`` emits
    /// Tailwind's `dark:` variant and the browser resolves it, so styling
    /// adapts without the value ever being read.
    @Entry public var colorScheme: ColorScheme = .light
}

/// A `ShapeStyle` holding one color per ``ColorScheme``.
///
/// SwiftUI resolves a light/dark pair at render time from
/// `EnvironmentValues.colorScheme`; Tailwind resolves it in CSS instead, via
/// the `dark:` variant. So this emits *both* classes — `border-gray-200
/// dark:border-gray-700` — and the appearance follows the document without a
/// re-render. That's why `resolve(in:for:)` ignores the environment it's
/// handed rather than picking one of the two.
///
/// ```swift
/// let separator = CSSColorKey.gray_200.dark(.gray_700)
/// div { … }.border(separator, edges: .bottom)
/// ```
public struct SchemeColor: ShapeStyle {
    public let light: CSSColorKey
    public let dark: CSSColorKey

    public init(light: CSSColorKey, dark: CSSColorKey) {
        self.light = light
        self.dark = dark
    }

    public func resolve(in environment: EnvironmentValues?, for role: CSSStyleRole) -> String {
        "\(role.rawValue)-\(light.rawValue) dark:\(role.rawValue)-\(dark.rawValue)"
    }

    public var description: String { "\(light.rawValue)/\(dark.rawValue)" }
}

extension CSSColorKey {
    /// Pairs this color, used in light mode, with `dark` for dark mode.
    ///
    /// ```swift
    /// CSSColorKey.gray_200.dark(.gray_700)
    /// ```
    public func dark(_ dark: CSSColorKey) -> SchemeColor {
        SchemeColor(light: self, dark: dark)
    }
}

extension ShapeStyle where Self == SchemeColor {
    /// A style appropriate for foreground separators or divider lines.
    ///
    /// Named for SwiftUI's `ShapeStyle.separator`. Unlike SwiftUI's, this one
    /// is a concrete pair rather than a system-resolved style, since there is
    /// no platform appearance to ask — Tailwind's palette is the whole
    /// vocabulary.
    public static var separator: SchemeColor { CSSColorKey.gray_200.dark(.gray_700) }
}
