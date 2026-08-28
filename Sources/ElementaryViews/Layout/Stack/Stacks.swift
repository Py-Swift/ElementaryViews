//
//  Stacks.swift
//  ElementaryViews
//
//  Real view types for the flex/grid layout containers.
//
//  These exist as structs rather than freestanding macros because a
//  freestanding expression macro cannot nest inside itself: the outer
//  expansion necessarily contains the inner `#VStack` invocation, and Swift
//  rejects any macro that appears anywhere in its own expansion stack with
//  "recursive expansion of macro". That holds even with a different macro in
//  between (`#VStack { #Grid { #VStack { ... } } }`) and regardless of how the
//  body is spliced, so it can't be fixed inside the macro implementation.
//
//  As plain `@PublicView` structs they nest to any depth. The rendered HTML is
//  byte-identical to what the macros produced — same tag, same class string,
//  same order — so this is a drop-in replacement for the `#` call sites.
//
import Elementary
import ElementaryUI

// MARK: - CSS Mappings

extension HStackAlignment {
    var css: String {
        switch self {
        case .top:      "items-start"
        case .center:   "items-center"
        case .bottom:   "items-end"
        case .stretch:  "items-stretch"
        case .baseline: "items-baseline"
        }
    }
}

extension VStackAlignment {
    var css: String {
        switch self {
        case .leading:  "items-start"
        case .center:   "items-center"
        case .trailing: "items-end"
        case .stretch:  "items-stretch"
        }
    }
}

extension LayoutSpacing {
    var css: String {
        switch self {
        case .none: "gap-0"
        case .xs:   "gap-1"
        case .sm:   "gap-2"
        case .md:   "gap-4"
        case .lg:   "gap-6"
        case .xl:   "gap-8"
        }
    }
}

extension GridColumns {
    var css: String {
        switch self {
        case .one:   "md:grid-cols-1"
        case .two:   "md:grid-cols-2"
        case .three: "md:grid-cols-3"
        case .four:  "md:grid-cols-4"
        case .five:  "md:grid-cols-5"
        case .six:   "md:grid-cols-6"
        }
    }
}

// MARK: - HStack

/// A horizontal flex row. Mirrors `#HStack`, but nests.
@PublicView
public struct HStack<StackContent: View> {
    public typealias Tag = HTMLTag.div
    let alignment: HStackAlignment
    let spacing: LayoutSpacing
    let wrap: Bool
    let stackContent: StackContent

    public init(
        alignment: HStackAlignment = .center,
        spacing: LayoutSpacing = .md,
        wrap: Bool = false,
        @HTMLBuilder content: () -> StackContent
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.wrap = wrap
        self.stackContent = content()
    }

    private var classes: String {
        let base = "flex flex-row w-full \(alignment.css) \(spacing.css)"
        return wrap ? base + " flex-wrap" : base
    }

    public var body: some View {
        div(.class(classes)) { stackContent }
    }
}

// MARK: - VStack

/// A vertical flex column. Mirrors `#VStack`, but nests.
@PublicView
public struct VStack<StackContent: View> {
    public typealias Tag = HTMLTag.div
    let alignment: VStackAlignment
    let spacing: LayoutSpacing
    let stackContent: StackContent

    public init(
        alignment: VStackAlignment = .stretch,
        spacing: LayoutSpacing = .md,
        @HTMLBuilder content: () -> StackContent
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.stackContent = content()
    }

    private var classes: String {
        "flex flex-col w-full \(alignment.css) \(spacing.css)"
    }

    public var body: some View {
        div(.class(classes)) { stackContent }
    }
}

// MARK: - Grid

/// A responsive grid: one column below the `md` breakpoint, `columns` at or
/// above it. Mirrors `#Grid`, but nests.
@PublicView
public struct Grid<GridContent: View> {
    public typealias Tag = HTMLTag.div
    let columns: GridColumns
    let spacing: LayoutSpacing
    let gridContent: GridContent

    public init(
        columns: GridColumns = .two,
        spacing: LayoutSpacing = .md,
        @HTMLBuilder content: () -> GridContent
    ) {
        self.columns = columns
        self.spacing = spacing
        self.gridContent = content()
    }

    private var classes: String {
        "grid grid-cols-1 \(columns.css) \(spacing.css)"
    }

    public var body: some View {
        div(.class(classes)) { gridContent }
    }
}
