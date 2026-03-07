//
//  MacroExpansionTests.swift
//  ViewMacrosTests
//
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing

// Import the macro implementations
@testable import ViewMacros

let testMacros: [String: Macro.Type] = [
    "HStack": HStackMacro.self,
    "VStack": VStackMacro.self,
    "Border": BorderMacro.self,
    "Table": TableMacro.self,
    "TableRow": TableRowMacro.self,
    "TableCell": TableCellMacro.self,
    "PublicView": ViewMacro.self,
]

@Suite("Layout Macro Expansions")
struct MacroExpansionTests {

    @Test func hstackDefault() {
        assertMacroExpansion(
            """
            #HStack {
                span { "Hello" }
            }
            """,
            expandedSource: """
            div(.class("flex flex-row w-full items-center gap-4")) {
                span { "Hello" }
            }
            """,
            macros: testMacros
        )
    }

    @Test func hstackTopAligned() {
        assertMacroExpansion(
            """
            #HStack(alignment: .top) {
                span { "Hello" }
            }
            """,
            expandedSource: """
            div(.class("flex flex-row w-full items-start gap-4")) {
                span { "Hello" }
            }
            """,
            macros: testMacros
        )
    }

    @Test func hstackWithWrap() {
        assertMacroExpansion(
            """
            #HStack(wrap: true) {
                span { "A" }
            }
            """,
            expandedSource: """
            div(.class("flex flex-row w-full items-center gap-4 flex-wrap")) {
                span { "A" }
            }
            """,
            macros: testMacros
        )
    }

    @Test func hstackSmallSpacing() {
        assertMacroExpansion(
            """
            #HStack(spacing: .sm) {
                span { "A" }
            }
            """,
            expandedSource: """
            div(.class("flex flex-row w-full items-center gap-2")) {
                span { "A" }
            }
            """,
            macros: testMacros
        )
    }

    @Test func vstackDefault() {
        assertMacroExpansion(
            """
            #VStack {
                p { "Hello" }
            }
            """,
            expandedSource: """
            div(.class("flex flex-col w-full items-stretch gap-4")) {
                p { "Hello" }
            }
            """,
            macros: testMacros
        )
    }

    @Test func vstackLeadingAligned() {
        assertMacroExpansion(
            """
            #VStack(alignment: .leading) {
                p { "Hello" }
            }
            """,
            expandedSource: """
            div(.class("flex flex-col w-full items-start gap-4")) {
                p { "Hello" }
            }
            """,
            macros: testMacros
        )
    }

    @Test func borderDefault() {
        assertMacroExpansion(
            """
            #Border {
                p { "Content" }
            }
            """,
            expandedSource: """
            div(.class("border flex-1 border-gray-300 rounded-lg p-4")) {
                p { "Content" }
            }
            """,
            macros: testMacros
        )
    }

    @Test func borderCustom() {
        assertMacroExpansion(
            """
            #Border(color: .blue500, radius: .full, padding: .sm) {
                p { "Blue" }
            }
            """,
            expandedSource: """
            div(.class("border flex-1 border-blue-500 rounded-full p-2")) {
                p { "Blue" }
            }
            """,
            macros: testMacros
        )
    }

    @Test func tableDefault() {
        assertMacroExpansion(
            """
            #Table {
                tr { td { "Cell" } }
            }
            """,
            expandedSource: """
            table(.class("w-full table-auto border-collapse")) {
                tr { td { "Cell" } }
            }
            """,
            macros: testMacros
        )
    }

    @Test func tableFixed() {
        assertMacroExpansion(
            """
            #Table(layout: .fixed) {
                tr { td { "Cell" } }
            }
            """,
            expandedSource: """
            table(.class("w-full table-fixed border-collapse")) {
                tr { td { "Cell" } }
            }
            """,
            macros: testMacros
        )
    }

    @Test func tableRow() {
        assertMacroExpansion(
            """
            #TableRow {
                td { "A" }
            }
            """,
            expandedSource: """
            tr(.class("border-b border-gray-100")) {
                td { "A" }
            }
            """,
            macros: testMacros
        )
    }

    @Test func tableCellDefault() {
        assertMacroExpansion(
            """
            #TableCell {
                "Data"
            }
            """,
            expandedSource: """
            td(.class("px-3 py-2 text-sm align-middle")) {
                "Data"
            }
            """,
            macros: testMacros
        )
    }

    @Test func tableCellShrink() {
        assertMacroExpansion(
            """
            #TableCell(width: .shrink) {
                "Compact"
            }
            """,
            expandedSource: """
            td(.class("px-3 py-2 text-sm align-middle w-px whitespace-nowrap")) {
                "Compact"
            }
            """,
            macros: testMacros
        )
    }

    // MARK: - @PublicView Tag generation

    @Test func publicViewWithTagGeneratesTypealias() {
        assertMacroExpansion(
            """
            @PublicView(.div)
            public struct MyView<Label: View> {
                let label: Label
                public var body: some View {
                    div { label }
                }
            }
            """,
            expandedSource: """
            public struct MyView<Label: View> {
                let label: Label
                @HTMLBuilder
                public var body: some View {
                    div { label }
                }
            }

            extension MyView: __FunctionView {
                //typealias _MountedNode = _FunctionNode<Self, Self.Content._MountedNode>
                
                public typealias Tag = HTMLTag.div
                public static func __applyContext(_ context: borrowing _ViewContext, to view: inout Self) {
                    
                }
                public typealias __ViewState = Void
            }

            extension MyView: __ViewEquatable {
                public static func __arePropertiesEqual(a: Self, b: Self) -> Bool {
                    return true 
                    && __ViewProperty.areKnownEqual(a.label, b.label)
                }
            }
            """,
            macros: testMacros
        )
    }

    @Test func publicViewWithoutTagOmitsTypealias() {
        assertMacroExpansion(
            """
            @PublicView
            public struct SimpleView {
                let text: String
                public var body: some View {
                    span { text }
                }
            }
            """,
            expandedSource: """
            public struct SimpleView {
                let text: String
                @HTMLBuilder
                public var body: some View {
                    span { text }
                }
            }

            extension SimpleView: __FunctionView {
                //typealias _MountedNode = _FunctionNode<Self, Self.Content._MountedNode>
                
                public static func __applyContext(_ context: borrowing _ViewContext, to view: inout Self) {
                    
                }
                public typealias __ViewState = Void
            }

            extension SimpleView: __ViewEquatable {
                public static func __arePropertiesEqual(a: Self, b: Self) -> Bool {
                    return true 
                    && __ViewProperty.areKnownEqual(a.text, b.text)
                }
            }
            """,
            macros: testMacros
        )
    }
}
