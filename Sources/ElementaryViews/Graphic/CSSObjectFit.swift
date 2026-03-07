//
//  CSSObjectFit.swift
//  ElementaryViews
//

/// Tailwind object-fit utility classes for images/video.
public enum CSSObjectFit: String, Sendable {
    case contain = "object-contain"
    case cover = "object-cover"
    case fill = "object-fill"
    case none = "object-none"
    case scaleDown = "object-scale-down"
}
