//
//  ListView.swift
//  ElementaryViews
//
import ElementaryUI

/// Expands to a vertical `ul` list with optional dividers between items.
@freestanding(expression)
public macro ListView<T: HTML>(
    divided: Bool = false,
    @HTMLBuilder _ content: () -> T
) -> HTMLElement<HTMLTag.ul, T> = #externalMacro(module: "ViewMacros", type: "ListViewMacro")


