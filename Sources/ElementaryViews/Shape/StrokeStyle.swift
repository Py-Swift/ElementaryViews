//
//  StrokeStyle.swift
//  ElementaryViews
//
//  Matches SwiftUI's StrokeStyle API.
//  Uses custom LineCap/LineJoin enums instead of CGLineCap/CGLineJoin
//  since CoreGraphics is not available in WebAssembly.
//

// MARK: - LineCap

/// The endpoint style of a stroked line, matching SwiftUI's `CGLineCap`.
public enum LineCap: String, Sendable, Hashable {
    /// A line with a squared-off end, stopping exactly at the endpoint.
    case butt = "butt"
    /// A line with a rounded end extending past the endpoint by half the line width.
    case round = "round"
    /// A line with a squared-off end extending past the endpoint by half the line width.
    case square = "square"
}

// MARK: - LineJoin

/// The join type of two connected line segments, matching SwiftUI's `CGLineJoin`.
public enum LineJoin: String, Sendable, Hashable {
    /// A sharp corner at the join, subject to the miter limit.
    case miter = "miter"
    /// A rounded corner at the join.
    case round = "round"
    /// A beveled corner at the join.
    case bevel = "bevel"
}

// MARK: - StrokeStyle

/// A style for stroking vector paths, matching SwiftUI's `StrokeStyle`.
///
/// ```swift
/// let style = StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
/// context.stroke(path, with: .color(.blue), style: style)
/// ```
public struct StrokeStyle: Equatable, Sendable {

    /// The width of the stroked path.
    public var lineWidth: Double

    /// The endpoint style of a line.
    public var lineCap: LineCap

    /// The join type of a line.
    public var lineJoin: LineJoin

    /// A threshold used to determine whether to use a bevel instead of a miter at a join.
    public var miterLimit: Double

    /// The lengths of painted and unpainted segments used to make a dashed line.
    public var dash: [Double]

    /// How far into the dash pattern the line starts.
    public var dashPhase: Double

    /// Creates a new stroke style from the given components.
    ///
    /// - Parameters:
    ///   - lineWidth: The width of the segment. Defaults to `1`.
    ///   - lineCap: The endpoint style. Defaults to `.butt`.
    ///   - lineJoin: The join style. Defaults to `.miter`.
    ///   - miterLimit: The miter limit threshold. Defaults to `10`.
    ///   - dash: Dash pattern lengths. Defaults to empty (solid line).
    ///   - dashPhase: Dash pattern offset. Defaults to `0`.
    public init(
        lineWidth: Double = 1,
        lineCap: LineCap = .butt,
        lineJoin: LineJoin = .miter,
        miterLimit: Double = 10,
        dash: [Double] = [],
        dashPhase: Double = 0
    ) {
        self.lineWidth = lineWidth
        self.lineCap = lineCap
        self.lineJoin = lineJoin
        self.miterLimit = miterLimit
        self.dash = dash
        self.dashPhase = dashPhase
    }
}
