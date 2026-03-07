# Getting Started

> **Source**: [elementary.codes/guide/get-started](https://elementary.codes/guide/get-started.html)

## Vite Starter Template (Quickest Way)

Scaffold from the [starter template](https://github.com/elementary-swift/starter-vite):

```sh
npx degit elementary-swift/starter-vite my-elementary-project
cd my-elementary-project
npm install
npm run dev
```

Changes to Swift source are hot-reloaded automatically.

## Templates and Examples

| Project | Description |
|---------|-------------|
| [Minimal Vite Starter](https://github.com/elementary-swift/starter-vite) | Basic template for ElementaryUI |
| [Tailwind Starter](https://github.com/elementary-swift/starter-tailwind) | Starter template with Tailwind CSS preconfigured |
| [Swiftle](https://github.com/nicklask/swiftle) | A tiny word game using ElementaryFlow |

## Manual Setup

### 1. Swift Package

```sh
# Initialize a package
swift package init --type executable --name MyApp

# Add dependency
swift package add-dependency https://github.com/elementary-swift/elementary-ui --from 0.1.0
swift package add-target-dependency ElementaryUI MyApp --package elementary-ui
```

Create your `@main` entrypoint:

```swift
import ElementaryUI

@main
struct MyApp {
    static func main() {
        Application(h1 { "Hello, world!" })
            .mount(in: .body)
    }
}
```

Verify Swift build:

```sh
# Use the Swift SDK matching your toolchain version
swift build --swift-sdk swift-6.2.3-RELEASE_wasm
```

### 2. Web Setup (Vite)

Install Vite and the Swift WASM plugin:

```sh
npm install -D vite @elementary-swift/vite-plugin-swift-wasm
```

Create `vite.config.ts`:

```ts
import { defineConfig } from "vite";
import swiftWasm from "@elementary-swift/vite-plugin-swift-wasm";

export default defineConfig({
  plugins: [swiftWasm()],
});
```

Install the BrowserRuntime (JavaScriptKit Runtime + WASI Shim):

```sh
swift package resolve
npm install @bjorn3/browser_wasi_shim@~0.4 ./.build/checkouts/elementary-ui/BrowserRuntime
```

Create `index.html`:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MyApp</title>
  </head>
  <body>
    <script type="module" src="./index.ts"></script>
  </body>
</html>
```

Run the dev server:

```sh
npx vite --open
```

Use `vite build` for production bundles. See [Vite Plugin README](https://github.com/elementary-swift/vite-plugin-swift-wasm) for more options.
