//
//  TestUtilities.swift
//  ElementaryViewsTests
//
import Elementary
import ElementaryUI
import Testing

/// Asserts that an HTML element renders to the expected string.
func HTMLExpect(_ html: some HTML, toBe expected: String, sourceLocation: SourceLocation = #_sourceLocation) {
    #expect(html.render() == expected, sourceLocation: sourceLocation)
}
