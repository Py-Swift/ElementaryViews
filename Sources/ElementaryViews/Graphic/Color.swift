//
//  Color.swift
//  ElementaryViews
//

/// A custom color defined by raw RGBA values, conforming to `ShapeStyle`.
///
/// Analogous to SwiftUI's `Color` struct. Stores red, green, blue, and opacity
/// components as `Double` values in the 0–1 range. Produces Tailwind CSS
/// arbitrary-value classes like `text-[#ff3b30]` or `bg-[#ff3b3080]`.
///
/// ```swift
/// let custom = Color(red: 0.2, green: 0.5, blue: 0.8)
/// custom.cssClass(for: .text)       // "text-[#3380cc]"
/// Color.red.cssClass(for: .background) // "bg-[#ff3b30]"
/// ```
public struct Color: ShapeStyle, Hashable, Sendable {

    // MARK: - Stored Properties

    /// Red component (0–1).
    public let red: Double
    /// Green component (0–1).
    public let green: Double
    /// Blue component (0–1).
    public let blue: Double
    /// Alpha/opacity component (0–1). Defaults to 1 (fully opaque).
    public let opacity: Double

    // MARK: - Initializers

    /// Creates a color from RGBA components (each 0–1).
    public init(red: Double, green: Double, blue: Double, opacity: Double = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }

    /// Creates a grayscale color from a white level (0 = black, 1 = white).
    public init(white: Double, opacity: Double = 1.0) {
        self.red = white
        self.green = white
        self.blue = white
        self.opacity = opacity
    }

    /// Creates a color from a hex string (e.g., `"#FF3B30"`, `"FF3B30"`, `"#ff3b3080"`).
    ///
    /// Supports 6-character RGB and 8-character RGBA hex strings.
    /// Returns nil if the string cannot be parsed.
    public init?(hex: String) {
        var hexString = hex
        // Strip leading/trailing whitespace manually (no Foundation)
        while hexString.first?.isWhitespace == true { hexString.removeFirst() }
        while hexString.last?.isWhitespace == true { hexString.removeLast() }
        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst())
        }
        guard hexString.count == 6 || hexString.count == 8 else { return nil }
        guard let hexNumber = UInt64(hexString, radix: 16) else { return nil }

        if hexString.count == 6 {
            self.red   = Double((hexNumber >> 16) & 0xFF) / 255.0
            self.green = Double((hexNumber >> 8) & 0xFF) / 255.0
            self.blue  = Double(hexNumber & 0xFF) / 255.0
            self.opacity = 1.0
        } else {
            self.red     = Double((hexNumber >> 24) & 0xFF) / 255.0
            self.green   = Double((hexNumber >> 16) & 0xFF) / 255.0
            self.blue    = Double((hexNumber >> 8) & 0xFF) / 255.0
            self.opacity = Double(hexNumber & 0xFF) / 255.0
        }
    }

    // MARK: - CSS Output

    /// Hex representation of this color.
    ///
    /// Returns `"#rrggbb"` when fully opaque, or `"#rrggbbaa"` when translucent.
    public var hexString: String {
        let r = Int(clamped(red) * 255)
        let g = Int(clamped(green) * 255)
        let b = Int(clamped(blue) * 255)

        if opacity >= 1.0 {
            return String([
                "#",
                Self.hexTable[(r >> 4) & 0xF], Self.hexTable[r & 0xF],
                Self.hexTable[(g >> 4) & 0xF], Self.hexTable[g & 0xF],
                Self.hexTable[(b >> 4) & 0xF], Self.hexTable[b & 0xF]
            ])
        } else {
            let a = Int(clamped(opacity) * 255)
            return String([
                "#",
                Self.hexTable[(r >> 4) & 0xF], Self.hexTable[r & 0xF],
                Self.hexTable[(g >> 4) & 0xF], Self.hexTable[g & 0xF],
                Self.hexTable[(b >> 4) & 0xF], Self.hexTable[b & 0xF],
                Self.hexTable[(a >> 4) & 0xF], Self.hexTable[a & 0xF]
            ])
        }
    }

    // MARK: - ShapeStyle

    /// Returns a Tailwind CSS arbitrary-value class for this color in the given role.
    ///
    /// For example: `"text-[#ff3b30]"`, `"bg-[#0000ff80]"`.
    public func cssClass(for role: CSSStyleRole) -> String {
        "\(role.rawValue)-[\(hexString)]"
    }

    // MARK: - Modifiers

    /// Returns a copy of this color with the given opacity.
    public func opacity(_ value: Double) -> Color {
        Color(red: red, green: green, blue: blue, opacity: value)
    }

    // MARK: - Hex Lookup Table

    /// Lowercase hex digit lookup table. Available for external hex conversions.
    public static let hexTable: [Character] = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]

    // MARK: - Private Helpers

    private func clamped(_ value: Double) -> Double {
        min(max(value, 0), 1)
    }
}

// MARK: - Standard Color Constants

extension Color {
    /// System red (#FF3B30).
    public static let red = Color(hex: "#FF3B30")!
    /// System orange (#FF9500).
    public static let orange = Color(hex: "#FF9500")!
    /// System yellow (#FFCC00).
    public static let yellow = Color(hex: "#FFCC00")!
    /// System green (#34C759).
    public static let green = Color(hex: "#34C759")!
    /// System blue (#007AFF).
    public static let blue = Color(hex: "#007AFF")!
    /// System purple (#AF52DE).
    public static let purple = Color(hex: "#AF52DE")!
    /// System pink (#FF2D55).
    public static let pink = Color(hex: "#FF2D55")!
    /// System mint (#00C7BE).
    public static let mint = Color(hex: "#00C7BE")!
    /// System teal (#30B0C7).
    public static let teal = Color(hex: "#30B0C7")!
    /// System cyan (#32ADE6).
    public static let cyan = Color(hex: "#32ADE6")!
    /// System indigo (#5856D6).
    public static let indigo = Color(hex: "#5856D6")!
    /// System brown (#A2845E).
    public static let brown = Color(hex: "#A2845E")!
    /// White (#FFFFFF).
    public static let white = Color(white: 1.0)
    /// Black (#000000).
    public static let black = Color(white: 0.0)
    /// Gray (#8E8E93).
    public static let gray = Color(hex: "#8E8E93")!
    /// Fully transparent.
    public static let clear = Color(white: 0.0, opacity: 0.0)
}
