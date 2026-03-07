//
//  Gradient.swift
//  ElementaryViews
//

/// A color gradient represented as an array of color stops.
///
/// Analogous to SwiftUI's `Gradient`. Each `Stop` defines a color and
/// optional position along the gradient. Used as input for
/// `LinearGradient`, `RadialGradient`, and `AngularGradient`.
///
/// ```swift
/// // From Color array (evenly distributed)
/// let g1 = Gradient(colors: [.red, .blue])
///
/// // From CSSColorKey array
/// let g2 = Gradient(cssColors: [.blue_500, .purple_500, .pink_500])
///
/// // With explicit stop positions
/// let g3 = Gradient(stops: [
///     .init(color: .red, location: 0.0),
///     .init(color: .blue, location: 0.7),
///     .init(color: .green, location: 1.0)
/// ])
/// ```
public struct Gradient: Equatable, Sendable {

    /// A single color stop in a gradient.
    public struct Stop: Equatable, Sendable {

        /// Tailwind CSS color token (e.g. `"[#ff3b30]"`, `"blue-500"`).
        public let colorToken: String

        /// Position along the gradient (0–1), or nil for even distribution.
        public let location: Double?

        /// Creates a stop from a `Color`.
        ///
        /// The color is encoded as a Tailwind arbitrary-value token:
        /// `Color.red` → `"[#ff3b30]"`
        public init(color: Color, location: Double? = nil) {
            self.colorToken = "[\(color.hexString)]"
            self.location = location
        }

        /// Creates a stop from a `CSSColorKey`.
        ///
        /// Uses the key's raw value directly: `.blue_500` → `"blue-500"`
        public init(color: CSSColorKey, location: Double? = nil) {
            self.colorToken = color.rawValue
            self.location = location
        }

        /// Creates a stop from a raw CSS token string.
        ///
        /// Use for custom values: `Stop(token: "white", location: 0.5)`
        public init(token: String, location: Double? = nil) {
            self.colorToken = token
            self.location = location
        }
    }

    /// The color stops in this gradient.
    public var stops: [Stop]

    /// Creates a gradient from explicit stops.
    public init(stops: [Stop]) {
        self.stops = stops
    }

    /// Creates an evenly distributed gradient from `Color` values.
    public init(colors: [Color]) {
        self.stops = colors.map { Stop(color: $0) }
    }

    /// Creates an evenly distributed gradient from `CSSColorKey` values.
    public init(cssColors: [CSSColorKey]) {
        self.stops = cssColors.map { Stop(color: $0) }
    }

    // MARK: - Tailwind CSS Output

    /// Produces Tailwind CSS gradient color stop classes.
    ///
    /// Maps stops to `from-{color}`, `via-{color}`, `to-{color}` utilities:
    /// - 1 stop: `from-{color}`
    /// - 2 stops: `from-{color1} to-{color2}`
    /// - 3+ stops: `from-{color1} via-{color2} ... to-{colorN}`
    ///
    /// Stop positions are appended as percentage classes when specified
    /// (e.g. `from-10%`, `via-30%`, `to-90%`).
    ///
    /// > Note: Tailwind's `from-`/`via-`/`to-` model works best with 2–3
    /// > stops. For 4+ stops, each middle stop uses `via-` but only the
    /// > last `via-` color may take effect in some Tailwind versions.
    public var cssStopClasses: String {
        guard !stops.isEmpty else { return "" }

        var classes: [String] = []
        let count = stops.count

        for (index, stop) in stops.enumerated() {
            let prefix: String
            if index == 0 {
                prefix = "from"
            } else if index == count - 1 && count > 1 {
                prefix = "to"
            } else {
                prefix = "via"
            }

            classes.append("\(prefix)-\(stop.colorToken)")

            if let location = stop.location {
                classes.append("\(prefix)-\(Int(location * 100))%")
            }
        }

        return classes.joined(separator: " ")
    }
}
