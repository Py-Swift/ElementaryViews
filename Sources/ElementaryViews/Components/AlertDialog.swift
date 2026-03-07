//
//  AlertDialog.swift
//  ElementaryViews
//
import ElementaryUI

/// A modal alert dialog overlay.
/// Similar to SwiftUI's `.alert()` modifier — renders a centered modal with backdrop.
@PublicView(.div)
public struct AlertDialog<Actions: View> {

    let title: String
    let message: String
    let alertActions: Actions
    let isPresented: Bool

    /// Creates an alert dialog.
    ///
    /// - Parameters:
    ///   - title: The alert title.
    ///   - message: The alert message body.
    ///   - isPresented: Whether the dialog is visible.
    ///   - actions: The action buttons (typically `Button` views).
    public init(
        _ title: String,
        message: String = "",
        isPresented: Bool = true,
        @HTMLBuilder actions: () -> Actions
    ) {
        self.title = title
        self.message = message
        self.isPresented = isPresented
        self.alertActions = actions()
    }

    public var body: some View {
        if isPresented {
            // Backdrop overlay
            div(.class("fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50")) {
                // Dialog box
                div(.class("bg-white rounded-lg shadow-xl max-w-sm w-full mx-4 p-6")) {
                    // Title
                    div(.class("text-lg font-semibold text-gray-900 mb-2")) { title }

                    // Message
                    if !message.isEmpty {
                        div(.class("text-sm text-gray-600 mb-4")) { message }
                    }

                    // Actions row
                    div(.class("flex justify-end gap-2")) {
                        alertActions
                    }
                }
            }
        }
    }
}
