//
//  AlertDialog.swift
//  ElementaryViews
//
import ElementaryUI

/// A modal alert dialog overlay.
/// Similar to SwiftUI's `.alert()` modifier — renders a centered modal with backdrop.
public func AlertDialog<A: View>(
    _ title: String,
    message: String = "",
    isPresented: Bool = true,
    @HTMLBuilder actions: () -> A
) -> some View {
    div {
        if isPresented {
            div(.class("fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50")) {
                div(.class("bg-white rounded-lg shadow-xl max-w-sm w-full mx-4 p-6")) {
                    div(.class("text-lg font-semibold text-gray-900 mb-2")) { title }
                    if !message.isEmpty {
                        div(.class("text-sm text-gray-600 mb-4")) { message }
                    }
                    div(.class("flex justify-end gap-2")) {
                        actions()
                    }
                }
            }
        }
    }
}

