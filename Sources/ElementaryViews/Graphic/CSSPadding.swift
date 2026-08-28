//
//  CSSPadding.swift
//  ElementaryViews
//

public struct CSSPadding: Sendable {
    public let px: Int
    public let py: Double

    public static let zero = CSSPadding(px: 0, py: 0)

    public init(px: Int = 3, py: Double = 1.5) {
        self.px = px
        self.py = py
    }

    public var css: String {
        "px-\(px) py-\(Self.token(py))"
    }

    /// Formats a spacing value the way Tailwind's own class names do: whole
    /// numbers with no decimal point (`6`, not `6.0`), fractional values
    /// with one (`2.5`). Interpolating a bare `Double` always keeps the
    /// `.0` (`"\(6.0)"` == `"6.0"`), which isn't a real Tailwind class and
    /// silently drops the padding.
    private static func token(_ value: Double) -> String {
        value.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(value)) : String(value)
    }
}
