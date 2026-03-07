//
//  ViewModifiers.swift
//  ElementaryViews
//
import ElementaryUI

extension View {

    public consuming func frame(_ css: CSSTextSize) -> some View<Tag> {
        self
    }

    public consuming func _button(_ onClick: @escaping () -> Void) -> Button<Self> {
        Button(label: self, onClick: onClick)
    }
}
