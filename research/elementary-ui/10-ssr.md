# Server-Side Rendering

> **Source**: [elementary.codes/guide/topics/server-side-rendering](https://elementary.codes/guide/topics/server-side-rendering.html)

## Elementary vs ElementaryUI

| Package | Purpose | Runtime |
|---------|---------|---------|
| **Elementary** | HTML rendering library. Renders `HTML` values to text (String or streamed chunks). Framework-agnostic, no macros. | Server (any Swift platform) |
| **ElementaryUI** | Reactive UI framework. Produces/updates real DOM nodes. Depends on Elementary + JavaScriptKit + macros. | Browser (WebAssembly) |

Long-term goal: fully integrated into a combined `ElementaryUI` framework (likely via package traits or conditional compilation).

## SSR + ElementaryUI (Islands Pattern)

ElementaryUI does **not** yet have a "render on server, hydrate on client" pipeline. However, you can use an **islands approach**:

1. Use **Elementary** to render the full HTML page on the server
2. Add placeholders: `<div id="comments"></div>` where you want interactivity
3. In the browser, mount **ElementaryUI** applications into those placeholders:

```swift
Application(CommentsSection())
    .mount(in: "#comments")
```

This gives you:
- Fast, indexable HTML from SSR
- Isolated interactive widgets without full hydration

See: [Multiple Applications](https://elementary.codes/guide/essentials/application.html#multiple-applications)

## Web Components (Planned)

Out-of-the-box support for defining Web Components (custom elements) in ElementaryUI is planned. The elementary.codes website already uses custom elements for interactive snippets (`elementary-snippet`).

## Hydration (Future Direction)

Long-term plan:
- Same view code renders to HTML on the server
- Then **hydrates** on the client (attaching behavior to already-rendered markup)

Until that integration lands:
- Prefer **SSR + islands** for progressively-enhanced pages
- Use **full CSR** for highly interactive apps
