//
//  FillStyle.swift
//  ElementaryViews
//
//  Matches SwiftUI's FillStyle API.
//

/// A style for rasterizing vector paths, matching SwiftUI's `FillStyle`.
public struct FillStyle: Equatable, Sendable {

    /// Whether to use the even-odd rule when rendering a shape.
    ///
    /// When `false`, uses the non-zero winding number rule.
    public var isEOFilled: Bool

    /// Whether to apply antialiasing to the edges of a shape.
    public var isAntialiased: Bool

    /// Creates a new fill style with the specified settings.
    ///
    /// - Parameters:
    ///   - eoFill: Whether to use the even-odd rule. Defaults to `false`.
    ///   - antialiased: Whether to antialias edges. Defaults to `true`.
    public init(eoFill: Bool = false, antialiased: Bool = true) {
        self.isEOFilled = eoFill
        self.isAntialiased = antialiased
    }
}
