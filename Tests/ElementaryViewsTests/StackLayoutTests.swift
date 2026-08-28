//
//  StackLayoutTests.swift
//  ElementaryViewsTests
//
//  `VStack`/`HStack`/`Grid` replaced the `#VStack`/`#HStack`/`#Grid`
//  freestanding macros, which could not nest inside themselves (Swift rejects
//  a macro appearing anywhere in its own expansion stack). These tests pin two
//  things: the rendered HTML still matches what the macros emitted, and the
//  types actually nest.
//
import Elementary
import ElementaryUI
import Testing

@testable import ElementaryViews

@Suite("Stack Layout HTML")
struct StackLayoutTests {

    // MARK: - Parity with the former macro expansions

    @Test func vstackDefaultMatchesMacroOutput() {
        // #VStack { p { "Hello" } } expanded to:
        //   div(.class("flex flex-col w-full items-stretch gap-4")) { ... }
        HTMLExpect(
            VStack { p { "Hello" } },
            toBe: #"<div class="flex flex-col w-full items-stretch gap-4"><p>Hello</p></div>"#
        )
    }

    @Test func vstackLeadingAligned() {
        HTMLExpect(
            VStack(alignment: .leading) { p { "Hello" } },
            toBe: #"<div class="flex flex-col w-full items-start gap-4"><p>Hello</p></div>"#
        )
    }

    @Test func vstackSmallSpacing() {
        HTMLExpect(
            VStack(spacing: .sm) { p { "Hello" } },
            toBe: #"<div class="flex flex-col w-full items-stretch gap-2"><p>Hello</p></div>"#
        )
    }

    @Test func hstackDefaultMatchesMacroOutput() {
        HTMLExpect(
            HStack { span { "Hello" } },
            toBe: #"<div class="flex flex-row w-full items-center gap-4"><span>Hello</span></div>"#
        )
    }

    @Test func hstackTopAligned() {
        HTMLExpect(
            HStack(alignment: .top) { span { "Hello" } },
            toBe: #"<div class="flex flex-row w-full items-start gap-4"><span>Hello</span></div>"#
        )
    }

    @Test func hstackWithWrap() {
        HTMLExpect(
            HStack(wrap: true) { span { "A" } },
            toBe: #"<div class="flex flex-row w-full items-center gap-4 flex-wrap"><span>A</span></div>"#
        )
    }

    @Test func gridDefaultMatchesMacroOutput() {
        HTMLExpect(
            Grid { span { "A" } },
            toBe: #"<div class="grid grid-cols-1 md:grid-cols-2 gap-4"><span>A</span></div>"#
        )
    }

    @Test func gridThreeColumns() {
        HTMLExpect(
            Grid(columns: .three, spacing: .lg) { span { "A" } },
            toBe: #"<div class="grid grid-cols-1 md:grid-cols-3 gap-6"><span>A</span></div>"#
        )
    }

    @Test func allSpacingValues() {
        let expected: [(LayoutSpacing, String)] = [
            (.none, "gap-0"), (.xs, "gap-1"), (.sm, "gap-2"),
            (.md, "gap-4"), (.lg, "gap-6"), (.xl, "gap-8"),
        ]
        for (spacing, css) in expected {
            HTMLExpect(
                VStack(spacing: spacing) { span { "x" } },
                toBe: #"<div class="flex flex-col w-full items-stretch \#(css)"><span>x</span></div>"#
            )
        }
    }

    // MARK: - Nesting (the thing the macros could not do)

    @Test func vstackNestsInsideVStack() {
        HTMLExpect(
            VStack(spacing: .sm) {
                span { "outer" }
                VStack(spacing: .lg) { span { "inner" } }
            },
            toBe: #"<div class="flex flex-col w-full items-stretch gap-2">"#
                + #"<span>outer</span>"#
                + #"<div class="flex flex-col w-full items-stretch gap-6"><span>inner</span></div>"#
                + #"</div>"#
        )
    }

    @Test func hstackNestsInsideHStack() {
        HTMLExpect(
            HStack(spacing: .xs) {
                HStack(spacing: .xl) { span { "inner" } }
            },
            toBe: #"<div class="flex flex-row w-full items-center gap-1">"#
                + #"<div class="flex flex-row w-full items-center gap-8"><span>inner</span></div>"#
                + #"</div>"#
        )
    }

    @Test func deeplyMixedNesting() {
        HTMLExpect(
            VStack(spacing: .sm) {
                HStack(spacing: .xs) {
                    Grid(columns: .three) {
                        VStack { span { "deep" } }
                    }
                }
            },
            toBe: #"<div class="flex flex-col w-full items-stretch gap-2">"#
                + #"<div class="flex flex-row w-full items-center gap-1">"#
                + #"<div class="grid grid-cols-1 md:grid-cols-3 gap-4">"#
                + #"<div class="flex flex-col w-full items-stretch gap-4"><span>deep</span></div>"#
                + #"</div></div></div>"#
        )
    }
}
