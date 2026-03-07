//
//  Badge.swift
//  ElementaryViews
//
import ElementaryUI

/// A small pill-shaped indicator for displaying counts or short labels.
/// Equivalent to SwiftUI's `.badge()` modifier rendered as a standalone view.
@PublicView
public struct Badge {

    let text: String
    let prominence: BadgeProminence

    /// Creates a badge with a count value. A count of 0 produces an empty badge.
    public init(_ count: Int, prominence: BadgeProminence = .standard) {
        self.text = count > 0 ? "\(count)" : ""
        self.prominence = prominence
    }

    /// Creates a badge with a text label.
    public init(_ text: String, prominence: BadgeProminence = .standard) {
        self.text = text
        self.prominence = prominence
    }

    private var bgClass: String {
        switch prominence {
        case .decreased:
            return "bg-gray-200 text-gray-600"
        case .standard:
            return "bg-gray-500 text-white"
        case .increased:
            return "bg-red-500 text-white"
        }
    }

    public var body: some View {
        if !text.isEmpty {
            span(.class("inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full \(bgClass)")) {
                text
            }
        }
    }
}

/// The visual emphasis level of a badge.
public enum BadgeProminence: Sendable {
    /// Low emphasis — gray background.
    case decreased
    /// Default emphasis — gray-dark background.
    case standard
    /// High emphasis — red background (requires action).
    case increased
}
