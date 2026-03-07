//
//  SegmentedPicker.swift
//  ElementaryViews
//
import ElementaryUI

/// A segmented control for picking between labeled options.
/// Similar to SwiftUI's `Picker` with `.segmented` style.
@PublicView
public struct SegmentedPicker {

    let segments: [Segment]

    /// Creates a segmented picker.
    /// Mark the active segment by setting `isSelected: true` on it.
    public init(segments: [Segment]) {
        self.segments = segments
    }

    public var body: some View {
        div(.class("inline-flex rounded-lg border border-gray-300 overflow-hidden")) {
            ForEach(segments, key: \.title) { segment in
                SegmentButton(segment: segment)
            }
        }
    }
}

/// A single segment button inside a `SegmentedPicker`.
@PublicView
struct SegmentButton {

    let segment: Segment

    init(segment: Segment) {
        self.segment = segment
    }

    private var buttonClass: String {
        let selectedClass = segment.isSelected
            ? "bg-blue-500 text-white"
            : "bg-white text-gray-700 hover:bg-gray-50"
        return "px-4 py-2 text-sm font-medium \(selectedClass) focus:outline-none"
    }

    var body: some View {
        button(.class(buttonClass)) {
            segment.title
        }.onClick { segment.onSelect() }
    }
}

/// A single segment in a `SegmentedPicker`.
public struct Segment: Sendable {
    public let title: String
    public let isSelected: Bool
    public let onSelect: @Sendable () -> Void

    public init(title: String, isSelected: Bool = false, onSelect: @escaping @Sendable () -> Void) {
        self.title = title
        self.isSelected = isSelected
        self.onSelect = onSelect
    }
}
