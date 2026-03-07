//
//  NavigationStack.swift
//  ElementaryViews
//
import ElementaryUI

/// A view that presents a stack of views over a root view, driven by a bound path.
///
/// `NavigationStack` displays the root content when the path is empty, and
/// renders the destination view for the topmost path element otherwise.
/// It uses a homogeneous typed array as the path, where all elements share
/// the same `Data` type.
///
/// ## Basic Usage
/// ```swift
/// @State var parks: [Park] = []
///
/// NavigationStack(path: $parks) {
///     // Root view shown when parks is empty
///     ForEach(allParks) { park in
///         Button(text: park.name) { parks.append(park) }
///     }
/// } destination: { park in
///     // Detail view shown for the topmost park
///     ParkDetail(park: park)
/// }
/// ```
///
/// ## With NavigationLink
/// ```swift
/// @State var parks: [Park] = []
///
/// NavigationStack(path: $parks) {
///     ForEach(allParks) { park in
///         NavigationLink(value: park, path: $parks) {
///             Text(park.name)
///         }
///     }
/// } destination: { park in
///     Button(text: "← Back") { parks.removeLast() }
///     ParkDetail(park: park)
/// }
/// ```
///
/// ## Pop Navigation
/// ```swift
/// // Pop one level
/// parks.removeLast()
///
/// // Pop to root
/// parks.removeAll()
/// ```
@PublicView
public struct NavigationStack<Data: Hashable, Root: View, Detail: View> {

    @Binding var path: [Data]
    let root: Root
    let destination: (Data) -> Detail

    public typealias Tag = HTMLTag.div

    /// Creates a navigation stack with a homogeneous typed path.
    ///
    /// - Parameters:
    ///   - path: A binding to the array of data driving the stack.
    ///   - root: The root content shown when the path is empty.
    ///   - destination: A view builder that creates the detail view for a given data value.
    public init(
        path: Binding<[Data]>,
        @HTMLBuilder root: () -> Root,
        @HTMLBuilder destination: @escaping (Data) -> Detail
    ) {
        self._path = path
        self.root = root()
        self.destination = destination
    }

    public var body: some View {
        if let current = path.last {
            destination(current)
        } else {
            root
        }
    }
}
