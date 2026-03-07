import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - CSS Mappings

private enum HStackAlignment: String {
    case top, center, bottom, stretch, baseline

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

private enum VStackAlignment: String {
    case leading, center, trailing, stretch

    var css: String {
        switch self {
        case .leading:  "items-start"
        case .center:   "items-center"
        case .trailing: "items-end"
        case .stretch:  "items-stretch"
        }
    }
}

private enum Spacing: String {
    case none, xs, sm, md, lg, xl

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

// MARK: - Argument Parsing Helpers

private func extractEnumCase(from expr: ExprSyntax) -> String? {
    // Handles `.center`, `.lg`, etc.
    if let member = expr.as(MemberAccessExprSyntax.self) {
        return member.declName.baseName.text
    }
    return nil
}

private func parseArguments(from arguments: LabeledExprListSyntax) -> (alignment: String?, spacing: String?, wrap: Bool?) {
    var alignment: String? = nil
    var spacing: String? = nil
    var wrap: Bool? = nil

    for arg in arguments {
        let label = arg.label?.text
        switch label {
        case "alignment":
            alignment = extractEnumCase(from: arg.expression)
        case "spacing":
            spacing = extractEnumCase(from: arg.expression)
        case "wrap":
            if let boolLiteral = arg.expression.as(BooleanLiteralExprSyntax.self) {
                wrap = boolLiteral.literal.text == "true"
            }
        default:
            break
        }
    }
    return (alignment, spacing, wrap)
}

// MARK: - HStack Macro

public struct HStackMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let (alignmentStr, spacingStr, wrapBool) = parseArguments(from: node.arguments)

        let alignment = HStackAlignment(rawValue: alignmentStr ?? "center") ?? .center
        let spacing = Spacing(rawValue: spacingStr ?? "md") ?? .md
        let wrap = wrapBool ?? false

        var classes = "flex flex-row w-full \(alignment.css) \(spacing.css)"
        if wrap {
            classes += " flex-wrap"
        }

        guard let trailingClosure = node.trailingClosure else {
            throw MacroError("HStack requires a trailing closure")
        }

        let stmts = trailingClosure.statements

        return """
        div(.class("\(raw: classes)")) {
        \(stmts)
        }
        """
    }
}

// MARK: - VStack Macro

public struct VStackMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let (alignmentStr, spacingStr, _) = parseArguments(from: node.arguments)

        let alignment = VStackAlignment(rawValue: alignmentStr ?? "stretch") ?? .stretch
        let spacing = Spacing(rawValue: spacingStr ?? "md") ?? .md

        let classes = "flex flex-col w-full \(alignment.css) \(spacing.css)"

        guard let trailingClosure = node.trailingClosure else {
            throw MacroError("VStack requires a trailing closure")
        }

        let stmts = trailingClosure.statements

        return """
        div(.class("\(raw: classes)")) {
        \(stmts)
        }
        """
    }
}

// MARK: - Border Macro

private enum BorderColor: String {
    case gray200, gray300, gray400, gray500, gray600, gray700
    case blue300, blue500
    case red300, red500
    case green300, green500

    var css: String {
        switch self {
        case .gray200: "border-gray-200"
        case .gray300: "border-gray-300"
        case .gray400: "border-gray-400"
        case .gray500: "border-gray-500"
        case .gray600: "border-gray-600"
        case .gray700: "border-gray-700"
        case .blue300: "border-blue-300"
        case .blue500: "border-blue-500"
        case .red300:  "border-red-300"
        case .red500:  "border-red-500"
        case .green300: "border-green-300"
        case .green500: "border-green-500"
        }
    }
}

private enum BorderRadius: String {
    case none, sm, md, lg, xl, full

    var css: String {
        switch self {
        case .none: "rounded-none"
        case .sm:   "rounded-sm"
        case .md:   "rounded-md"
        case .lg:   "rounded-lg"
        case .xl:   "rounded-xl"
        case .full:  "rounded-full"
        }
    }
}

private enum Padding: String {
    case none, xs, sm, md, lg, xl

    var css: String {
        switch self {
        case .none: "p-0"
        case .xs:   "p-1"
        case .sm:   "p-2"
        case .md:   "p-4"
        case .lg:   "p-6"
        case .xl:   "p-8"
        }
    }
}

private func parseBorderArguments(from arguments: LabeledExprListSyntax) -> (color: String?, radius: String?, padding: String?) {
    var color: String? = nil
    var radius: String? = nil
    var padding: String? = nil

    for arg in arguments {
        let label = arg.label?.text
        switch label {
        case "color":
            color = extractEnumCase(from: arg.expression)
        case "radius":
            radius = extractEnumCase(from: arg.expression)
        case "padding":
            padding = extractEnumCase(from: arg.expression)
        default:
            break
        }
    }
    return (color, radius, padding)
}

public struct BorderMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let (colorStr, radiusStr, paddingStr) = parseBorderArguments(from: node.arguments)

        let color = BorderColor(rawValue: colorStr ?? "gray300") ?? .gray300
        let radius = BorderRadius(rawValue: radiusStr ?? "lg") ?? .lg
        let padding = Padding(rawValue: paddingStr ?? "md") ?? .md

        let classes = "border flex-1 \(color.css) \(radius.css) \(padding.css)"

        guard let trailingClosure = node.trailingClosure else {
            throw MacroError("Border requires a trailing closure")
        }

        let stmts = trailingClosure.statements

        return """
        div(.class("\(raw: classes)")) {
        \(stmts)
        }
        """
    }
}

// MARK: - Table Macro

private enum TableLayout: String {
    case auto, fixed

    var css: String {
        switch self {
        case .auto:  "table-auto"
        case .fixed: "table-fixed"
        }
    }
}

public struct TableMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        var layoutStr: String? = nil

        for arg in node.arguments {
            if arg.label?.text == "layout" {
                layoutStr = extractEnumCase(from: arg.expression)
            }
        }

        let layout = TableLayout(rawValue: layoutStr ?? "auto") ?? .auto
        let classes = "w-full \(layout.css) border-collapse"

        guard let trailingClosure = node.trailingClosure else {
            throw MacroError("Table requires a trailing closure")
        }

        let stmts = trailingClosure.statements

        return """
        table(.class("\(raw: classes)")) {
        \(stmts)
        }
        """
    }
}

// MARK: - TableRow Macro

public struct TableRowMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let trailingClosure = node.trailingClosure else {
            throw MacroError("TableRow requires a trailing closure")
        }

        let stmts = trailingClosure.statements

        return """
        tr(.class("border-b border-gray-100")) {
        \(stmts)
        }
        """
    }
}

// MARK: - TableCell Macro

private enum CellWidth: String {
    case auto, shrink
    case w_1_4, w_1_3, w_1_2, w_2_3, w_3_4, w_full

    var css: String {
        switch self {
        case .auto:   ""
        case .shrink: "w-px whitespace-nowrap"
        case .w_1_4:  "w-1/4"
        case .w_1_3:  "w-1/3"
        case .w_1_2:  "w-1/2"
        case .w_2_3:  "w-2/3"
        case .w_3_4:  "w-3/4"
        case .w_full:  "w-full"
        }
    }
}

public struct TableCellMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        var widthStr: String? = nil

        for arg in node.arguments {
            if arg.label?.text == "width" {
                widthStr = extractEnumCase(from: arg.expression)
            }
        }

        let width = CellWidth(rawValue: widthStr ?? "auto") ?? .auto
        let widthCss = width.css
        let classes = widthCss.isEmpty ? "px-3 py-2 text-sm align-middle" : "px-3 py-2 text-sm align-middle \(widthCss)"

        guard let trailingClosure = node.trailingClosure else {
            throw MacroError("TableCell requires a trailing closure")
        }

        let stmts = trailingClosure.statements

        return """
        td(.class("\(raw: classes)")) {
        \(stmts)
        }
        """
    }
}

// MARK: - Error

struct MacroError: Error, CustomStringConvertible {
    let description: String
    init(_ description: String) { self.description = description }
}

// MARK: - Plugin

@main
struct ViewMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        HStackMacro.self,
        VStackMacro.self,
        BorderMacro.self,
        TableMacro.self,
        TableRowMacro.self,
        TableCellMacro.self,
        
        ViewMacro.self
    ]
}
