//
//  NavigationStack.swift
//  ElementaryViews
//
import ElementaryUI

/// Displays `root` when `path` is empty; otherwise renders `destination` for the topmost element.
///
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
public func NavigationStack<Data: Hashable, Root: View, Detail: View>(
    path: Binding<[Data]>,
    @HTMLBuilder root: () -> Root,
    @HTMLBuilder destination: (Data) -> Detail
) -> some View {
    div {
        if let current = path.wrappedValue.last {
            destination(current)
        } else {
            root()
        }
    }
}

