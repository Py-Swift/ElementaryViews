//
//  CustomViewTests.swift
//  ElementaryViewsTests
//
//  Custom @PublicView structs written in SwiftUI-style using ONLY
//  ElementaryViews components — no raw HTML elements. Tests verify
//  their .render() output matches expected HTML.
//
import Elementary
import ElementaryUI
import Testing
@testable import ElementaryViews

// MARK: - Custom View Structs (SwiftUI-style, ElementaryViews only)

/// A greeting card with title and subtitle
@PublicView
struct GreetingCard {
    let name: String
    let message: String

    init(name: String, message: String = "Welcome!") {
        self.name = name
        self.message = message
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .sm) {
            Text(name, font: CSSFontInfo(size: .xl))
            Text(message, font: CSSFontInfo(size: .sm, color: .gray_500))
        }
    }
}

/// A user profile row with avatar image, name, and online badge
@PublicView
struct ProfileRow {
    let username: String
    let avatarURL: String
    let isOnline: Bool

    init(username: String, avatarURL: String, isOnline: Bool = false) {
        self.username = username
        self.avatarURL = avatarURL
        self.isOnline = isOnline
    }

    var body: some View {
        #HStack(spacing: .md) {
            WebImage(src: avatarURL, alt: username, width: "w-10", height: "h-10", cornerRadius: .full)
            #VStack(alignment: .leading, spacing: .xs) {
                Text(username, font: CSSFontInfo(size: .sm))
                if isOnline {
                    Badge("Online", prominence: .increased)
                } else {
                    Badge("Offline", prominence: .decreased)
                }
            }
        }
    }
}

/// A stat card with label, big number value, and a progress bar
@PublicView
struct StatCard {
    let title: String
    let value: String
    let progress: Double
    let color: CSSColorKey

    init(title: String, value: String, progress: Double = 0, color: CSSColorKey = .blue_500) {
        self.title = title
        self.value = value
        self.progress = progress
        self.color = color
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .sm) {
            Text(title, font: CSSFontInfo(size: .xs, color: .gray_500))
            Text(value, font: CSSFontInfo(size: .xl2, color: color))
            ProgressView(value: progress, color: color)
        }
    }
}

/// A settings form with sections, labels, bordered labels, and dividers
@PublicView
struct SettingsForm {
    let username: String
    let email: String
    let role: String

    init(username: String, email: String, role: String = "User") {
        self.username = username
        self.email = email
        self.role = role
    }

    var body: some View {
        Form {
            Section("Account") {
                #HStack {
                    Label(text: "Username", bg_color: .blue_500)
                    EqualSymbol()
                    BorderedLabel(text: username, border: CSSBorderInfo(color: .gray_200), bg_color: .gray_50)
                }
                #HStack {
                    Label(text: "Email", bg_color: .blue_500)
                    EqualSymbol()
                    BorderedLabel(text: email, border: CSSBorderInfo(color: .gray_200), bg_color: .gray_50)
                }
            }
            Divider()
            Section("Role") {
                #HStack {
                    Label(text: "Role", bg_color: .green_500)
                    ColonSymbol()
                    Badge(role)
                }
            }
        }
    }
}

/// A nav sidebar with title, links, spacer pushing footer down
@PublicView
struct Sidebar {
    let title: String
    let links: [(String, String)]

    init(title: String, links: [(String, String)]) {
        self.title = title
        self.links = links
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .sm) {
            Text(title, font: CSSFontInfo(size: .lg))
            Divider()
            for (label, path) in links {
                NavigationLink(label, destination: path)
            }
            Spacer()
            Text("v1.0", font: CSSFontInfo(size: .xs, color: .gray_400))
        }
    }
}

/// An empty state with title, subtitle, and spacers
@PublicView
struct EmptyState {
    let title: String
    let subtitle: String

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        #VStack(spacing: .lg) {
            Spacer(minLength: 24)
            Text(title, font: CSSFontInfo(size: .xl, color: .gray_400))
            Text(subtitle, font: CSSFontInfo(size: .sm, color: .gray_400))
            Spacer(minLength: 24)
        }
    }
}

/// A tag list showing badges in a horizontal wrapped row
@PublicView
struct TagList {
    let tags: [String]

    init(tags: [String]) {
        self.tags = tags
    }

    var body: some View {
        #HStack(spacing: .sm, wrap: true) {
            for tag in tags {
                Badge(tag)
            }
        }
    }
}

/// An image card with image, title, description
@PublicView
struct ImageCard {
    let imageURL: String
    let title: String
    let description: String

    init(imageURL: String, title: String, description: String) {
        self.imageURL = imageURL
        self.title = title
        self.description = description
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .sm) {
            WebImage(src: imageURL, alt: title, cornerRadius: .lg)
            Text(title, font: CSSFontInfo(size: .lg))
            Text(description, font: CSSFontInfo(size: .sm, color: .gray_600))
        }
    }
}

/// A contact list inside a scrollable divided list
@PublicView
struct ContactList {
    let contacts: [(String, String)]

    init(contacts: [(String, String)]) {
        self.contacts = contacts
    }

    var body: some View {
        ScrollView {
            ListView(divided: true) {
                for (name, email) in contacts {
                    #HStack(spacing: .md) {
                        Text(name, font: CSSFontInfo(size: .sm))
                        Spacer()
                        Text(email, font: CSSFontInfo(size: .xs, color: .gray_500))
                    }
                }
            }
        }
    }
}

/// A task row with name, badge count, and progress
@PublicView
struct TaskRow {
    let name: String
    let count: Int
    let progress: Double

    init(name: String, count: Int, progress: Double) {
        self.name = name
        self.count = count
        self.progress = progress
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .xs) {
            #HStack {
                Text(name, font: CSSFontInfo(size: .sm))
                Spacer()
                Badge(count)
            }
            ProgressView(value: progress, color: .green_500)
        }
    }
}

/// A confirmation dialog built from AlertDialog
@PublicView
struct DeleteConfirmation {
    let itemName: String

    init(itemName: String) {
        self.itemName = itemName
    }

    var body: some View {
        AlertDialog("Delete \(itemName)?", message: "This action cannot be undone.") {
            Text("Cancel")
            Text("Delete")
        }
    }
}

/// A data table using Table macros
@PublicView
struct UserTable {
    let users: [(String, String, String)]

    init(users: [(String, String, String)]) {
        self.users = users
    }

    var body: some View {
        #Table {
            #TableRow {
                #TableCell(width: .w_1_3) { Text("Name", font: CSSFontInfo(size: .xs, color: .gray_500)) }
                #TableCell(width: .w_1_3) { Text("Email", font: CSSFontInfo(size: .xs, color: .gray_500)) }
                #TableCell(width: .w_1_3) { Text("Role", font: CSSFontInfo(size: .xs, color: .gray_500)) }
            }
            for (name, email, role) in users {
                #TableRow {
                    #TableCell(width: .w_1_3) { Text(name) }
                    #TableCell(width: .w_1_3) { Text(email) }
                    #TableCell(width: .w_1_3) { Badge(role) }
                }
            }
        }
    }
}

/// A profile page with NavigationStack — shows list or detail
@PublicView
struct ProfilePage {
    let names: [String]
    @Binding var selectedPath: [String]

    init(names: [String], selectedPath: Binding<[String]>) {
        self.names = names
        self._selectedPath = selectedPath
    }

    var body: some View {
        NavigationStack(path: $selectedPath) {
            #VStack(alignment: .leading, spacing: .sm) {
                Text("Profiles", font: CSSFontInfo(size: .lg))
                Divider()
                ListView {
                    for name in names {
                        NavigationLink(name, destination: "/profile/\(name)")
                    }
                }
            }
        } destination: { (item: String) in
            #VStack(alignment: .leading, spacing: .md) {
                Text(item, font: CSSFontInfo(size: .xl))
                Divider()
                #HStack {
                    Label(text: "Status", bg_color: .green_500)
                    Badge("Active", prominence: .increased)
                }
            }
        }
    }
}

/// A bordered card with a web link
@PublicView
struct LinkCard {
    let title: String
    let url: String
    let description: String

    init(title: String, url: String, description: String) {
        self.title = title
        self.url = url
        self.description = description
    }

    var body: some View {
        #Border(color: .gray300, radius: .lg, padding: .md) {
            #VStack(alignment: .leading, spacing: .sm) {
                Text(title, font: CSSFontInfo(size: .lg))
                Text(description, font: CSSFontInfo(size: .sm, color: .gray_500))
                WebLink(destination: url, opensInNewTab: true) {
                    Text("Visit →", font: CSSFontInfo(size: .sm, color: .blue_500))
                }
            }
        }
    }
}

// MARK: - Tests

@Suite("Custom View Structs")
struct CustomViewTests {

    // MARK: - GreetingCard

    @Test func greetingCardDefault() {
        let view = GreetingCard(name: "Alice")
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-xl">Alice</span>"#
            + #"<span class="text-sm text-gray-500">Welcome!</span>"#
            + #"</div>"#
        )
    }

    @Test func greetingCardCustomMessage() {
        let view = GreetingCard(name: "Bob", message: "Hello!")
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-xl">Bob</span>"#
            + #"<span class="text-sm text-gray-500">Hello!</span>"#
            + #"</div>"#
        )
    }

    // MARK: - ProfileRow

    @Test func profileRowOffline() {
        let view = ProfileRow(username: "john", avatarURL: "/img/john.png")
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<img src="/img/john.png" alt="john" class="object-cover w-10 h-10 rounded-full">"#
            + #"<div class="flex flex-col w-full items-start gap-1">"#
            + #"<span class="text-sm">john</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-200 text-gray-600">Offline</span>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    @Test func profileRowOnline() {
        let view = ProfileRow(username: "jane", avatarURL: "/img/jane.png", isOnline: true)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<img src="/img/jane.png" alt="jane" class="object-cover w-10 h-10 rounded-full">"#
            + #"<div class="flex flex-col w-full items-start gap-1">"#
            + #"<span class="text-sm">jane</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">Online</span>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - StatCard

    @Test func statCardDefault() {
        let view = StatCard(title: "Users", value: "1,234", progress: 0.75)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-xs text-gray-500">Users</span>"#
            + #"<span class="text-2xl text-blue-500">1,234</span>"#
            + #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 75.0%"></div></div>"#
            + #"</div>"#
        )
    }

    @Test func statCardCustomColor() {
        let view = StatCard(title: "Revenue", value: "$5K", progress: 0.5, color: .green_500)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-xs text-gray-500">Revenue</span>"#
            + #"<span class="text-2xl text-green-500">$5K</span>"#
            + #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-green-500 h-2.5 rounded-full transition-all duration-300" style="width: 50.0%"></div></div>"#
            + #"</div>"#
        )
    }

    // MARK: - SettingsForm (deeply composed)

    @Test func settingsForm() {
        let view = SettingsForm(username: "alice", email: "alice@test.com")
        HTMLExpect(view, toBe:
            #"<form class="flex flex-col gap-4">"#
            + #"<section class="space-y-2">"#
            + #"<div class="font-semibold text-sm text-gray-700"><span class="text-sm">Account</span></div>"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="w-1/3 inline-block rounded px-3 py-1.5 text-sm bg-blue-500">Username</span>"#
            + #"<span class="text-gray-400">=</span>"#
            + #"<span class="w-full inline-block border border-gray-200 rounded px-3 py-1.5 text-sm bg-gray-50">alice</span>"#
            + #"</div>"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="w-1/3 inline-block rounded px-3 py-1.5 text-sm bg-blue-500">Email</span>"#
            + #"<span class="text-gray-400">=</span>"#
            + #"<span class="w-full inline-block border border-gray-200 rounded px-3 py-1.5 text-sm bg-gray-50">alice@test.com</span>"#
            + #"</div>"#
            + #"</section>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<section class="space-y-2">"#
            + #"<div class="font-semibold text-sm text-gray-700"><span class="text-sm">Role</span></div>"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="w-1/3 inline-block rounded px-3 py-1.5 text-sm bg-green-500">Role</span>"#
            + #"<span class="text-gray-400">:</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">User</span>"#
            + #"</div>"#
            + #"</section>"#
            + #"</form>"#
        )
    }

    // MARK: - Sidebar

    @Test func sidebarWithLinks() {
        let view = Sidebar(title: "Menu", links: [("Home", "/"), ("About", "/about")])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-lg">Menu</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<a href="/" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">Home</span><span class="text-gray-400 text-xs">›</span></a>"#
            + #"<a href="/about" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">About</span><span class="text-gray-400 text-xs">›</span></a>"#
            + #"<div class="flex-grow"></div>"#
            + #"<span class="text-xs text-gray-400">v1.0</span>"#
            + #"</div>"#
        )
    }

    @Test func sidebarEmpty() {
        let view = Sidebar(title: "Nav", links: [])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-lg">Nav</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<div class="flex-grow"></div>"#
            + #"<span class="text-xs text-gray-400">v1.0</span>"#
            + #"</div>"#
        )
    }

    // MARK: - EmptyState

    @Test func emptyState() {
        let view = EmptyState(title: "No results", subtitle: "Try a different query")
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-stretch gap-6">"#
            + #"<div class="flex-grow min-w-[24px] min-h-[24px]"></div>"#
            + #"<span class="text-xl text-gray-400">No results</span>"#
            + #"<span class="text-sm text-gray-400">Try a different query</span>"#
            + #"<div class="flex-grow min-w-[24px] min-h-[24px]"></div>"#
            + #"</div>"#
        )
    }

    // MARK: - TagList

    @Test func tagListMultiple() {
        let view = TagList(tags: ["Swift", "Web", "Wasm"])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-2 flex-wrap">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">Swift</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">Web</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">Wasm</span>"#
            + #"</div>"#
        )
    }

    @Test func tagListEmpty() {
        let view = TagList(tags: [])
        HTMLExpect(view, toBe: #"<div class="flex flex-row w-full items-center gap-2 flex-wrap"></div>"#)
    }

    // MARK: - ImageCard

    @Test func imageCard() {
        let view = ImageCard(imageURL: "/sunset.jpg", title: "Sunset", description: "A beautiful view")
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<img src="/sunset.jpg" alt="Sunset" class="object-cover rounded-lg">"#
            + #"<span class="text-lg">Sunset</span>"#
            + #"<span class="text-sm text-gray-600">A beautiful view</span>"#
            + #"</div>"#
        )
    }

    // MARK: - ContactList

    @Test func contactListTwo() {
        let view = ContactList(contacts: [("Alice", "a@t.com"), ("Bob", "b@t.com")])
        HTMLExpect(view, toBe:
            #"<div class="overflow-y-auto">"#
            + #"<ul class="flex flex-col divide-y divide-gray-200">"#
            + #"<div class="flex flex-row w-full items-center gap-4"><span class="text-sm">Alice</span><div class="flex-grow"></div><span class="text-xs text-gray-500">a@t.com</span></div>"#
            + #"<div class="flex flex-row w-full items-center gap-4"><span class="text-sm">Bob</span><div class="flex-grow"></div><span class="text-xs text-gray-500">b@t.com</span></div>"#
            + #"</ul>"#
            + #"</div>"#
        )
    }

    @Test func contactListEmpty() {
        let view = ContactList(contacts: [])
        HTMLExpect(view, toBe:
            #"<div class="overflow-y-auto">"#
            + #"<ul class="flex flex-col divide-y divide-gray-200"></ul>"#
            + #"</div>"#
        )
    }

    // MARK: - TaskRow

    @Test func taskRow() {
        let view = TaskRow(name: "Deploy", count: 3, progress: 0.6)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-1">"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="text-sm">Deploy</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">3</span>"#
            + #"</div>"#
            + #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-green-500 h-2.5 rounded-full transition-all duration-300" style="width: 60.0%"></div></div>"#
            + #"</div>"#
        )
    }

    @Test func taskRowZeroCount() {
        let view = TaskRow(name: "Build", count: 0, progress: 1.0)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-1">"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="text-sm">Build</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"</div>"#
            + #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-green-500 h-2.5 rounded-full transition-all duration-300" style="width: 100.0%"></div></div>"#
            + #"</div>"#
        )
    }

    // MARK: - DeleteConfirmation

    @Test func deleteConfirmation() {
        let view = DeleteConfirmation(itemName: "Report")
        HTMLExpect(view, toBe:
            #"<div class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">"#
            + #"<div class="bg-white rounded-lg shadow-xl max-w-sm w-full mx-4 p-6">"#
            + #"<div class="text-lg font-semibold text-gray-900 mb-2">Delete Report?</div>"#
            + #"<div class="text-sm text-gray-600 mb-4">This action cannot be undone.</div>"#
            + #"<div class="flex justify-end gap-2">"#
            + #"<span class="text-sm">Cancel</span>"#
            + #"<span class="text-sm">Delete</span>"#
            + #"</div>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - UserTable

    @Test func userTableOneUser() {
        let view = UserTable(users: [("Alice", "a@t.com", "Admin")])
        HTMLExpect(view, toBe:
            #"<table class="w-full table-auto border-collapse">"#
            + #"<tr class="border-b border-gray-100">"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Name</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Email</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Role</span></td>"#
            + #"</tr>"#
            + #"<tr class="border-b border-gray-100">"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">Alice</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">a@t.com</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">Admin</span></td>"#
            + #"</tr>"#
            + #"</table>"#
        )
    }

    @Test func userTableEmpty() {
        let view = UserTable(users: [])
        HTMLExpect(view, toBe:
            #"<table class="w-full table-auto border-collapse">"#
            + #"<tr class="border-b border-gray-100">"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Name</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Email</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Role</span></td>"#
            + #"</tr>"#
            + #"</table>"#
        )
    }

    // MARK: - ProfilePage with NavigationStack

    @Test func profilePageShowsRoot() {
        var path: [String] = []
        let binding = Binding(get: { path }, set: { path = $0 })
        let view = ProfilePage(names: ["Alice", "Bob"], selectedPath: binding)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-lg">Profiles</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<ul class="flex flex-col">"#
            + #"<a href="/profile/Alice" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">Alice</span><span class="text-gray-400 text-xs">›</span></a>"#
            + #"<a href="/profile/Bob" class="flex items-center gap-2 text-blue-600 hover:text-blue-800 hover:underline cursor-pointer"><span class="text-sm">Bob</span><span class="text-gray-400 text-xs">›</span></a>"#
            + #"</ul>"#
            + #"</div>"#
        )
    }

    @Test func profilePageShowsDetail() {
        var path = ["alice"]
        let binding = Binding(get: { path }, set: { path = $0 })
        let view = ProfilePage(names: ["Alice"], selectedPath: binding)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-4">"#
            + #"<span class="text-xl">alice</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="w-1/3 inline-block rounded px-3 py-1.5 text-sm bg-green-500">Status</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">Active</span>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - LinkCard with Border macro

    @Test func linkCard() {
        let view = LinkCard(title: "GitHub", url: "https://github.com", description: "Code hosting")
        HTMLExpect(view, toBe:
            #"<div class="border flex-1 border-gray-300 rounded-lg p-4">"#
            + #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-lg">GitHub</span>"#
            + #"<span class="text-sm text-gray-500">Code hosting</span>"#
            + #"<a href="https://github.com" target="_blank" class="cursor-pointer"><span class="text-sm text-blue-500">Visit →</span></a>"#
            + #"</div>"#
            + #"</div>"#
        )
    }
}
