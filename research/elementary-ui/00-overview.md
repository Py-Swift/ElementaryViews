# ElementaryUI Overview

> **Source**: [elementary.codes](https://elementary.codes) — Swift frontend framework for the browser via WebAssembly.
> **Package**: `https://github.com/elementary-swift/elementary-ui`
> **API Reference**: [Swift Package Index](https://swiftpackageindex.com/elementary-swift/elementary-ui/documentation)

## What is ElementaryUI?

ElementaryUI is a **Swift frontend framework** that runs in the browser via WebAssembly.
It takes inspiration from **SwiftUI's declarative model** but is designed to be **web-native** —
you work directly with HTML elements and CSS instead of platform-abstracted components.

### Key Characteristics

- **SwiftUI-inspired APIs**: `@View`, `@State`, `@Binding`, `@Environment`, `@Reactive` macros
- **Web-native**: Build with HTML elements (`div`, `p`, `button`, `h1`, etc.) — no `HStack`/`VStack` abstractions
- **Embedded Swift compatible**: Tiny kB-sized WASM binaries using Embedded Swift
- **CSS-based animations**: Built-in animation system including FLIP transitions
- **Vite-powered development**: Hot reload via `@elementary-swift/vite-plugin-swift-wasm`
- **No high-level UI components**: No built-in `Button`, `List`, etc. — you compose from HTML primitives
- **Any CSS framework works**: Tailwind CSS, Bootstrap, or custom CSS

### Architecture

- **Elementary** (lower-level): HTML rendering library. Renders `HTML`-conforming values to text/streams.
  Framework-agnostic, suitable for server-side rendering. No macros or extra dependencies.
- **ElementaryUI** (higher-level): Reactive UI framework for the browser. Builds on Elementary's HTML types
  to produce and update real DOM nodes. Depends on Elementary, JavaScriptKit, and Swift macros.

### Minimal Example

```swift
import ElementaryUI

@View
struct TinyCounter {
    @State var count = 1

    var body: some View {
        button { "Count: \(count)" }
            .onClick { count += 1 }
    }
}
```

### Road to 1.0 (Planned Features)

- Web Components (custom elements)
- Client-side routing
- JSON fetching / async data loading
- Full SSR + hydration pipeline
- matchedGeometryEffect
- Additional animatable modifiers

### Dependencies

- [Elementary](https://github.com/elementary-swift/elementary) — HTML rendering primitives
- [JavaScriptKit](https://github.com/swiftwasm/JavaScriptKit) — Swift-to-JavaScript bridge
- [Browser WASI Shim](https://github.com/bjorn3/browser_wasi_shim) — WASI compatibility for browser

### Prerequisites

- Swift 6.2+ with SwiftSDK for WebAssembly
- Node.js 22+ (for Vite tooling)
- [Optional] Binaryen `wasm-opt` for binary optimization
