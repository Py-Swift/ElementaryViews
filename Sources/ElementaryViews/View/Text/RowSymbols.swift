//
//  RowSymbols.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView
public struct EqualSymbol {

    public init() {}

    public var body: some View {
        span(.class("text-gray-400")) { "=" }
    }
}

@PublicView
public struct ColonSymbol {

    public init() {}

    public var body: some View {
        span(.class("text-gray-400")) { ":" }
    }
}
