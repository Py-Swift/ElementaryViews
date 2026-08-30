//
//  GroupBox.swift
//  ElementaryViews
//
import Elementary
import ElementaryUI

/// A stylized view with an optional label, for visually grouping a set of
/// related controls. Equivalent to SwiftUI's `GroupBox`.
///
/// A view rather than a modifier for the same reason it is one in SwiftUI: it
/// wraps content, it doesn't decorate an existing element.
///
/// ```swift
/// GroupBox {
///     Toggle(isOn: $useGlobalTools) { "Use global tools" }
///     PathField(path: $globalToolsPath)
/// }
/// ```
///
/// SwiftUI's `init(content:label:)` label overload isn't here yet — nothing
/// has wanted a titled box, and an always-empty parameter is worse than the
/// overload it saves. `color` stands in for SwiftUI's `GroupBoxStyle`, which
/// needs the style-protocol plumbing this package doesn't have; a caller
/// wanting a different frame passes one rather than writing its own box.
@PublicView
public struct GroupBox<GroupContent: View> {
    public typealias Tag = HTMLTag.div

    let color: SchemeColor
    let cornerRadius: CSSCornerRadius
    let groupContent: GroupContent

    public init(
        color: SchemeColor = .separator,
        cornerRadius: CSSCornerRadius = .lg,
        @HTMLBuilder content: () -> GroupContent
    ) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.groupContent = content()
    }

    public var body: some View {
        div(.class("\(cornerRadius.rawValue) p-3")) { groupContent }
            .border(color)
    }
}
