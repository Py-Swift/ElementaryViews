//
//  ViewMacros.swift
//  ElementaryViews
//
import Elementary
import ElementaryUI

// MARK: - Phantom types for autocomplete

public enum HStackAlignment {
    case top, center, bottom, stretch, baseline
}

public enum VStackAlignment {
    case leading, center, trailing, stretch
}

public enum LayoutSpacing {
    case none, xs, sm, md, lg, xl
}

public enum BorderColor {
    case gray200, gray300, gray400, gray500, gray600, gray700
    case blue300, blue500
    case red300, red500
    case green300, green500
}

public enum BorderRadius {
    case none, sm, md, lg, xl, full
}

public enum BorderPadding {
    case none, xs, sm, md, lg, xl
}

// MARK: - Macro Declarations

/// Expands to `div(.class("flex flex-row {alignment} {spacing}")) { ... }`
@freestanding(expression)
public macro HStack<T: HTML>(
    alignment: HStackAlignment = .center,
    spacing: LayoutSpacing = .md,
    wrap: Bool = false,
    @HTMLBuilder _ body: () -> T
) -> HTMLElement<HTMLTag.div, T> = #externalMacro(module: "ViewMacros", type: "HStackMacro")

/// Expands to `div(.class("flex flex-col {alignment} {spacing}")) { ... }`
@freestanding(expression)
public macro VStack<T: HTML>(
    alignment: VStackAlignment = .stretch,
    spacing: LayoutSpacing = .md,
    @HTMLBuilder _ body: () -> T
) -> HTMLElement<HTMLTag.div, T> = #externalMacro(module: "ViewMacros", type: "VStackMacro")

/// Expands to `div(.class("border {color} {radius} {padding}")) { ... }`
@freestanding(expression)
public macro Border<T: HTML>(
    color: BorderColor = .gray300,
    radius: BorderRadius = .lg,
    padding: BorderPadding = .md,
    @HTMLBuilder _ body: () -> T
) -> HTMLElement<HTMLTag.div, T> = #externalMacro(module: "ViewMacros", type: "BorderMacro")

public enum TableLayout {
    case auto, fixed
}

/// Expands to `table(.class("w-full table-auto/fixed border-collapse")) { body }`
@freestanding(expression)
public macro Table<T: HTML>(
    layout: TableLayout = .auto,
    @HTMLBuilder _ body: () -> T
) -> HTMLElement<HTMLTag.table, T> = #externalMacro(module: "ViewMacros", type: "TableMacro")

/// Wraps body in a styled `tr`. Body should contain `td` or `#TableCell` elements.
@freestanding(expression)
public macro TableRow<T: HTML>(
    @HTMLBuilder _ body: () -> T
) -> HTMLElement<HTMLTag.tr, T> = #externalMacro(module: "ViewMacros", type: "TableRowMacro")

public enum CellWidth {
    /// Auto-size to content (w-auto)
    case auto
    /// Shrink to minimum content width (w-px whitespace-nowrap)
    case shrink
    case w_1_4
    case w_1_3
    case w_1_2
    case w_2_3
    case w_3_4
    case w_full
}

/// Wraps body in a styled `td` cell with optional width.
@freestanding(expression)
public macro TableCell<T: HTML>(
    width: CellWidth = .auto,
    @HTMLBuilder _ body: () -> T
) -> HTMLElement<HTMLTag.td, T> = #externalMacro(module: "ViewMacros", type: "TableCellMacro")


/// Phantom enum for specifying HTML tag types in `@PublicView`.
/// Maps to `HTMLTag.xxx` via macro expansion.
public enum ViewTag {
    case a, article, aside, b, blockquote, br, button, caption
    case code, col, colgroup, dd, details, dialog, div, dl, dt
    case em, fieldset, figcaption, figure, footer, form, h1, h2
    case h3, h4, h5, h6, head, header, hr, i, iframe, img, input
    case label, legend, li, link, main, mark, meta, nav, ol, optgroup
    case option, output, p, pre, progress, script, section, select
    case slot, small, span, strong, style, sub, summary, sup, table
    case tbody, td, template, textarea, tfoot, th, thead, time, title
    case tr, u, ul
}

@attached(
    extension,
    conformances: __FunctionView,
    __ViewEquatable,
    names: named(__initializeState),
    named(__restoreState),
    named(__applyContext),
    named(__ViewState),
    named(_MountedNode),
    named(__arePropertiesEqual),
    named(Tag)
)
@attached(memberAttribute)
public macro PublicView(_ tag: ViewTag? = nil) = #externalMacro(module: "ViewMacros", type: "ViewMacro")
