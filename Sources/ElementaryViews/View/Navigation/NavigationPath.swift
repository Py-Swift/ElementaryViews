//
//  NavigationPath.swift
//  ElementaryViews
//

/// A type-erased list of data representing the content of a navigation stack.
///
/// `NavigationPath` manages an ordered collection of `Hashable` values that
/// drive a `NavigationStack`. It supports heterogeneous value types, making it
/// useful when a single navigation stack may push different data types.
///
/// For homogeneous paths (single data type), prefer using `[Data]` directly
/// with `NavigationStack`.
///
/// ## Usage
/// ```swift
/// @State var path = NavigationPath()
///
/// // Push different types
/// path.append(Park(name: "Yosemite"))
/// path.append(City(name: "San Francisco"))
///
/// // Pop
/// path.removeLast()
///
/// // Pop to root
/// path.popToRoot()
/// ```
public struct NavigationPath: Equatable {

    private var elements: [AnyHashable]

    /// The number of elements in the path.
    public var count: Int { elements.count }

    /// Whether the path is empty (at the root).
    public var isEmpty: Bool { elements.isEmpty }

    // MARK: - Initializers

    /// Creates an empty navigation path.
    public init() {
        self.elements = []
    }

    /// Creates a navigation path from a sequence of hashable elements.
    public init<S: Sequence>(_ elements: S) where S.Element: Hashable {
        self.elements = elements.map { AnyHashable($0) }
    }

    // MARK: - Mutation

    /// Appends a new value to the end of the path, pushing a new view.
    public mutating func append<V: Hashable>(_ value: V) {
        elements.append(AnyHashable(value))
    }

    /// Removes the specified number of elements from the end of the path.
    ///
    /// - Parameter k: The number of elements to remove. Defaults to 1.
    ///   If `k` is 0 or greater than `count`, this method does nothing.
    public mutating func removeLast(_ k: Int = 1) {
        guard k > 0, k <= elements.count else { return }
        elements.removeLast(k)
    }

    /// Removes all elements, returning to the root.
    public mutating func popToRoot() {
        elements.removeAll()
    }

    // MARK: - Access

    /// The topmost (most recently pushed) element, or `nil` if the path is empty.
    public var last: AnyHashable? { elements.last }

    /// All elements in the path, ordered from bottom (root-adjacent) to top.
    public var allElements: [AnyHashable] { elements }

    /// Attempts to retrieve the topmost element as the specified type.
    ///
    /// - Parameter type: The expected type of the topmost element.
    /// - Returns: The typed value, or `nil` if the path is empty or the type doesn't match.
    public func last<V: Hashable>(as type: V.Type) -> V? {
        elements.last?.base as? V
    }
}
