//
//  Edge.swift
//  ElementaryViews
//

/// The edges of a rectangle.
///
/// Mirrors SwiftUI's `Edge` (`research/SwiftUI-api/SwiftUICore.swift`) —
/// same cases, same nested `Set` with `.all` / `.horizontal` / `.vertical`.
public enum Edge: CaseIterable, Sendable {
    case top
    case leading
    case bottom
    case trailing

    /// The suffix Tailwind uses for this edge on `border-*`, `p-*`, `m-*`
    /// and friends. `leading`/`trailing` map to the logical `s`/`e`
    /// (start/end) rather than `l`/`r`, which is what keeps them leading and
    /// trailing in a right-to-left document.
    public var token: String {
        switch self {
        case .top: "t"
        case .leading: "s"
        case .bottom: "b"
        case .trailing: "e"
        }
    }

    /// An efficient set of edges.
    ///
    /// A struct of named members rather than SwiftUI's `OptionSet`: Tailwind
    /// spells each combination as its own utility (`border`, `border-x`,
    /// `border-y`, `border-t`…) rather than composing per-edge ones, so an
    /// arbitrary union such as `[.top, .leading]` has no class to emit. The
    /// members below are exactly the combinations that do.
    public struct Set: Sendable, Equatable {
        /// The Tailwind suffix for this set — empty for `.all`.
        public let token: String

        public init(_ edge: Edge) { self.token = edge.token }
        private init(token: String) { self.token = token }

        public static let top = Set(.top)
        public static let leading = Set(.leading)
        public static let bottom = Set(.bottom)
        public static let trailing = Set(.trailing)
        public static let all = Set(token: "")
        public static let horizontal = Set(token: "x")
        public static let vertical = Set(token: "y")

        /// Appends this set's suffix to a Tailwind utility root, so `.all`
        /// yields the bare `border` rather than a trailing hyphen.
        public func utility(_ root: String) -> String {
            token.isEmpty ? root : "\(root)-\(token)"
        }
    }
}
