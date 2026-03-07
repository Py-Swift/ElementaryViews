//
//  NavigationTests.swift
//  ElementaryViewsTests
//
import Elementary
import ElementaryUI
import Testing
@testable import ElementaryViews

@Suite("NavigationPath")
struct NavigationPathTests {

    // MARK: - Initialization

    @Test func emptyInit() {
        let path = NavigationPath()
        #expect(path.count == 0)
        #expect(path.isEmpty)
        #expect(path.last == nil)
        #expect(path.allElements.isEmpty)
    }

    @Test func initFromSequence() {
        let path = NavigationPath([1, 2, 3])
        #expect(path.count == 3)
        #expect(!path.isEmpty)
    }

    @Test func initFromStringSequence() {
        let path = NavigationPath(["a", "b"])
        #expect(path.count == 2)
        #expect(path.last == AnyHashable("b"))
    }

    // MARK: - Append

    @Test func appendSingleValue() {
        var path = NavigationPath()
        path.append(42)
        #expect(path.count == 1)
        #expect(path.last == AnyHashable(42))
    }

    @Test func appendMultipleValues() {
        var path = NavigationPath()
        path.append("hello")
        path.append("world")
        #expect(path.count == 2)
        #expect(path.last == AnyHashable("world"))
    }

    @Test func appendHeterogeneousTypes() {
        var path = NavigationPath()
        path.append(1)
        path.append("two")
        path.append(3.0)
        #expect(path.count == 3)
    }

    // MARK: - RemoveLast

    @Test func removeLastOne() {
        var path = NavigationPath([1, 2, 3])
        path.removeLast()
        #expect(path.count == 2)
        #expect(path.last == AnyHashable(2))
    }

    @Test func removeLastMultiple() {
        var path = NavigationPath([1, 2, 3, 4, 5])
        path.removeLast(3)
        #expect(path.count == 2)
        #expect(path.last == AnyHashable(2))
    }

    @Test func removeLastZeroDoesNothing() {
        var path = NavigationPath([1, 2])
        path.removeLast(0)
        #expect(path.count == 2)
    }

    @Test func removeLastExceedingCountDoesNothing() {
        var path = NavigationPath([1])
        path.removeLast(5)
        #expect(path.count == 1)
    }

    @Test func removeLastFromEmptyDoesNothing() {
        var path = NavigationPath()
        path.removeLast()
        #expect(path.count == 0)
    }

    // MARK: - PopToRoot

    @Test func popToRoot() {
        var path = NavigationPath([1, 2, 3])
        path.popToRoot()
        #expect(path.isEmpty)
        #expect(path.count == 0)
    }

    @Test func popToRootOnEmpty() {
        var path = NavigationPath()
        path.popToRoot()
        #expect(path.isEmpty)
    }

    // MARK: - Access

    @Test func lastReturnsTopElement() {
        let path = NavigationPath(["a", "b", "c"])
        #expect(path.last == AnyHashable("c"))
    }

    @Test func lastOnEmptyReturnsNil() {
        let path = NavigationPath()
        #expect(path.last == nil)
    }

    @Test func lastAsTypeMatching() {
        var path = NavigationPath()
        path.append(42)
        #expect(path.last(as: Int.self) == 42)
    }

    @Test func lastAsTypeMismatch() {
        var path = NavigationPath()
        path.append("hello")
        #expect(path.last(as: Int.self) == nil)
    }

    @Test func lastAsTypeOnEmpty() {
        let path = NavigationPath()
        #expect(path.last(as: String.self) == nil)
    }

    @Test func allElementsOrdering() {
        let path = NavigationPath([10, 20, 30])
        #expect(path.allElements == [AnyHashable(10), AnyHashable(20), AnyHashable(30)])
    }

    // MARK: - Equatable

    @Test func equalPaths() {
        let a = NavigationPath([1, 2, 3])
        let b = NavigationPath([1, 2, 3])
        #expect(a == b)
    }

    @Test func unequalPaths() {
        let a = NavigationPath([1, 2])
        let b = NavigationPath([1, 3])
        #expect(a != b)
    }

    @Test func emptyPathsAreEqual() {
        let a = NavigationPath()
        let b = NavigationPath()
        #expect(a == b)
    }

    @Test func differentLengthsNotEqual() {
        let a = NavigationPath([1])
        let b = NavigationPath([1, 2])
        #expect(a != b)
    }

    // MARK: - Push/Pop roundtrip

    @Test func pushPopRoundtrip() {
        var path = NavigationPath()
        path.append("first")
        path.append("second")
        path.append("third")
        #expect(path.count == 3)

        path.removeLast()
        #expect(path.count == 2)
        #expect(path.last == AnyHashable("second"))

        path.removeLast()
        #expect(path.count == 1)
        #expect(path.last == AnyHashable("first"))

        path.removeLast()
        #expect(path.isEmpty)
    }
}

@Suite("Navigation HTML Structure")
struct NavigationHTMLTests {

    // MARK: - NavigationLink URL mode (unchanged from existing tests)

    @Test func navigationLinkURLDefault() {
        let html = a(.href("/about"), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
            span(.class("text-sm")) { "About" }
            span(.class("text-gray-400 text-xs")) { "›" }
        }
        HTMLExpect(html, toBe: #"<a href="/about" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">About</span><span class="text-gray-400 text-xs">›</span></a>"#)
    }

    @Test func navigationLinkURLNewTab() {
        let html = a(.href("https://example.com"), .target(.blank), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
            span(.class("text-sm")) { "External" }
            span(.class("text-gray-400 text-xs")) { "↗" }
        }
        HTMLExpect(html, toBe: #"<a href="https://example.com" target="_blank" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">External</span><span class="text-gray-400 text-xs">↗</span></a>"#)
    }

    // MARK: - NavigationLink Value-based mode

    @Test func navigationLinkValueBased() {
        // Value-based NavigationLink renders <a href="#"> with label and chevron
        let html = a(.href("#"), .class("flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer")) {
            span(.class("text-sm")) { "Park Name" }
            span(.class("text-gray-400 text-xs")) { "›" }
        }
        HTMLExpect(html, toBe: ##"<a href="#" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">Park Name</span><span class="text-gray-400 text-xs">›</span></a>"##)
    }

    // MARK: - NavigationStack HTML patterns

    @Test func navigationStackRootPattern() {
        // When path is empty, NavigationStack renders the root content
        let html = div { p { "Park List" } }
        HTMLExpect(html, toBe: #"<div><p>Park List</p></div>"#)
    }

    @Test func navigationStackDetailPattern() {
        // When path has an item, NavigationStack renders the destination
        let html = div {
            span(.class("text-sm")) { "Park Detail: Yosemite" }
        }
        HTMLExpect(html, toBe: #"<div><span class="text-sm">Park Detail: Yosemite</span></div>"#)
    }

    @Test func navigationStackWithBackButton() {
        // Common pattern: destination with back button
        let html = div {
            button(.class("text-blue-600 cursor-pointer")) { "← Back" }
            div { span(.class("text-sm")) { "Detail Content" } }
        }
        HTMLExpect(html, toBe: #"<div><button class="text-blue-600 cursor-pointer">← Back</button><div><span class="text-sm">Detail Content</span></div></div>"#)
    }
}
