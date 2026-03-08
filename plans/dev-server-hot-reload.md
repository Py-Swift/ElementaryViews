# Running ElementaryUI with Hot Reloading

ElementaryUI uses a **Vite dev server** with a custom Swift→WASM plugin. When you save a `.swift` file, Vite rebuilds the WASM binary and does a full page reload in the browser — all automatically.

## Prerequisites

| Tool | Version | Install |
|---|---|---|
| **Swift** | 6.2+ | [swift.org](https://swift.org/install) |
| **Swift WASM SDK** | matching Swift version | `swift sdk install` (see below) |
| **Node.js** | 18+ | [nodejs.org](https://nodejs.org) |
| **pnpm** | 9+ | `npm install -g pnpm` |

### Install the Swift WASM SDK

```bash
# List available SDKs
swift sdk list

# Install the WASM SDK (get the latest URL from https://www.swift.org/install/wasm/)
swift sdk install <wasm-sdk-url>
```

## Project Structure

A minimal ElementaryUI app with hot reload needs these files:

```
MyApp/
├── Package.swift          # Swift package (depends on elementary-ui)
├── Sources/App/
│   └── main.swift         # Swift entry point
├── package.json           # Node dependencies (vite + plugin)
├── vite.config.ts         # Vite config with swift-wasm plugin
├── index.html             # HTML shell
├── index.ts               # JS entry point
└── tsconfig.json          # TypeScript config
```

## File Contents

### Package.swift

```swift
// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "MyApp",
    platforms: [.macOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/nicklerick/elementary-ui", from: "0.1.3")
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "ElementaryUI", package: "elementary-ui")
            ]
        )
    ],
    swiftLanguageModes: [.v5]
)
```

### Sources/App/main.swift

```swift
import ElementaryUI

Application(ContentView()).mount(in: .body)
```

The `mount(in:)` accepts:
- `.body` — mount directly into `<body>`
- `"#app"` — mount into element with `id="app"`

### package.json

```json
{
  "scripts": {
    "preinstall": "swift package resolve",
    "dev": "vite --open",
    "build": "vite build",
    "preview": "vite preview"
  },
  "devDependencies": {
    "@elementary-swift/vite-plugin-swift-wasm": "^0.1.2",
    "elementary-ui-browser-runtime": "file:../../BrowserRuntime",
    "@bjorn3/browser_wasi_shim": "~0.4.2",
    "vite": "^7.3.1"
  }
}
```

> **Note:** The `elementary-ui-browser-runtime` path must resolve to the `BrowserRuntime/` directory inside the elementary-ui checkout. Adjust the `file:` path based on your project structure. If elementary-ui is resolved via SPM at `.build/checkouts/elementary-ui/`, use:
> ```json
> "elementary-ui-browser-runtime": "file:.build/checkouts/elementary-ui/BrowserRuntime"
> ```

### vite.config.ts

```typescript
import { defineConfig } from "vite";
import swiftWasm from "@elementary-swift/vite-plugin-swift-wasm";

export default defineConfig({
  plugins: [
    swiftWasm({
      // packagePath: ".",        // default: current directory
      useEmbeddedSDK: true,       // production only (ignored in dev)
      // useWasmOpt: true,        // production only
      // extraBuildArgs: [],      // additional swift build flags
    })
  ]
});
```

### index.html

```html
<!DOCTYPE html>
<html>
<head>
  <title>My App</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
</head>
<body>
  <script type="module" src="./index.ts"></script>
</body>
</html>
```

### index.ts

```typescript
import { runApplication } from "elementary-ui-browser-runtime";
import appInit from "virtual:swift-wasm?init";

await runApplication(appInit);
```

### tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "lib": ["ES2022", "DOM"],
    "types": [
      "vite/client",
      "@elementary-swift/vite-plugin-swift-wasm/client"
    ],
    "isolatedModules": true,
    "strict": true,
    "noEmit": true
  }
}
```

## Running

### Development (with hot reload)

```bash
# First time only
pnpm install

# Start dev server — opens browser, watches .swift files
pnpm dev
```

This starts a Vite dev server (default `http://localhost:5173`). When you edit any `.swift` file under `Sources/`:

1. Vite detects the change (file watcher)
2. The plugin runs `swift build --swift-sdk <wasm-sdk>` (debug config)
3. On success → browser does a full page reload with the new WASM
4. On failure → error logged to terminal, browser stays on last working version

### Production build

```bash
pnpm build     # optimized WASM with wasm-opt + embedded Swift
pnpm preview   # serve the built output locally
```

Production enables `useEmbeddedSDK` and `useWasmOpt` for smaller binaries.

## How Hot Reload Works Internally

```
Save .swift file
     ↓
Vite file watcher detects change (*.swift in Sources/)
     ↓
Plugin debounces (20ms) to batch rapid saves
     ↓
`swift build --swift-sdk <auto-detected-wasm-sdk> --configuration debug` runs
     ↓
Throttled: if a build is already running, queues ONE more
     ↓
On build success → server.ws.send({ type: "full-reload" })
     ↓
Browser receives WebSocket message → full page reload
     ↓
index.ts runs → runApplication() → WebAssembly.instantiate(new .wasm)
     ↓
Swift Application.mount() renders fresh view tree into DOM
```

**Key characteristics:**
- **Full page reload** — not incremental HMR (WASM can't be partially swapped)
- **All `@State` resets** on each reload (entire WASM instance is recreated)
- **Debug builds** in dev mode (no wasm-opt, no embedded Swift) for faster iteration
- **Swift incremental compilation** still applies — only changed modules recompile
- The plugin auto-ignores `.build/` in the file watcher

## Adding Tailwind CSS

For ElementaryViews components that use Tailwind classes, add Tailwind to the Vite setup:

```bash
pnpm add -D tailwindcss @tailwindcss/vite
```

```typescript
// vite.config.ts
import { defineConfig } from "vite";
import swiftWasm from "@elementary-swift/vite-plugin-swift-wasm";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  plugins: [
    swiftWasm({ useEmbeddedSDK: true }),
    tailwindcss(),
  ]
});
```

```css
/* index.css — import in index.html or index.ts */
@import "tailwindcss";
```

Tailwind v4 scans your built HTML output for class names, so classes generated by ElementaryViews components are picked up automatically.
