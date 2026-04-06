//
//  SelectField.swift
//  ElementaryViews
//
import ElementaryUI

public func SelectField<T: RawRepresentable & CaseIterable & Equatable>(
    fieldLabel: String,
    selection: Binding<T>
) -> some View where T.RawValue == String, T.AllCases: RandomAccessCollection {
    div(.class("flex items-center gap-4 py-1")) {
        label(.class("w-40 text-sm font-medium text-gray-600 text-right")) { fieldLabel }
        select(.class("flex-1 border border-gray-300 rounded px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent")) {
            ForEach(T.allCases, key: \.rawValue) { item in
                if item == selection.wrappedValue {
                    option(.value(item.rawValue), .selected) { item.rawValue }
                } else {
                    option(.value(item.rawValue)) { item.rawValue }
                }
            }
        }
        .onInput { event in
            if let value = event.targetValue, let newSelection = T(rawValue: value) {
                selection.wrappedValue = newSelection
            }
        }
    }
}

