//
//  SelectField.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView
public struct SelectField<T: RawRepresentable & CaseIterable & Equatable> where T.RawValue == String, T.AllCases: RandomAccessCollection {
    var fieldLabel: String
    @Binding var selection: T

    public init(fieldLabel: String, selection: Binding<T>) {
        self.fieldLabel = fieldLabel
        self._selection = selection
    }

    public var body: some View {
        div(.class("flex items-center gap-4 py-1")) {
            label(.class("w-40 text-sm font-medium text-gray-600 text-right")) { fieldLabel }
            select(.class("flex-1 border border-gray-300 rounded px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent")) {
                for item in T.allCases {
                    if item == selection {
                        option(.value(item.rawValue), .selected) { item.rawValue }
                    } else {
                        option(.value(item.rawValue)) { item.rawValue }
                    }
                }
            }
            .onInput { event in
                if let value = event.targetValue, let newSelection = T(rawValue: value) {
                    selection = newSelection
                }
            }
        }
    }
}
