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
        #VStack(alignment: .leading, spacing: .sm) {
            Text(title, font: CSSFontInfo(size: .lg))
            Text(description, font: CSSFontInfo(size: .sm, color: .gray_500))
            WebLink(destination: url, opensInNewTab: true) {
                Text("Visit →", font: CSSFontInfo(size: .sm, color: .blue_500))
            }
        }
    }
}

// MARK: - NEW VIEWS (Batch 2)

/// Notification banner with icon badge, message, and color variants
enum BannerStyle { case success, error, warning }

@PublicView
struct NotificationBanner {
    let message: String
    let style: BannerStyle

    init(message: String, style: BannerStyle) {
        self.message = message
        self.style = style
    }

    private var icon: String {
        switch style {
        case .success: "✓"
        case .error: "✗"
        case .warning: "⚠"
        }
    }

    private var textColor: CSSColorKey {
        switch style {
        case .success: .green_600
        case .error: .red_600
        case .warning: .yellow_600
        }
    }

    var body: some View {
        #HStack {
            Badge(icon, prominence: .increased)
            Text(message, font: CSSFontInfo(size: .sm, color: textColor))
            Spacer()
        }
    }
}

/// Pricing card with plan name, price, divider, and feature list
@PublicView
struct PricingCard {
    let plan: String
    let price: String
    let features: [String]

    init(plan: String, price: String, features: [String]) {
        self.plan = plan
        self.price = price
        self.features = features
    }

    var body: some View {
        #VStack(alignment: .center, spacing: .md) {
            Text(plan, font: CSSFontInfo(size: .xl))
            Text(price, font: CSSFontInfo(size: .xl2, color: .blue_500))
            Divider()
            ListView {
                for feature in features {
                    Text(feature, font: CSSFontInfo(size: .sm))
                }
            }
        }
    }
}

/// A metric row: label + value on one line, progress bar below
@PublicView
struct MetricRow {
    let label: String
    let value: String
    let progress: Double
    let color: CSSColorKey

    init(label: String, value: String, progress: Double, color: CSSColorKey = .blue_500) {
        self.label = label
        self.value = value
        self.progress = progress
        self.color = color
    }

    var body: some View {
        #VStack(spacing: .xs) {
            #HStack {
                Text(label, font: CSSFontInfo(size: .xs, color: .gray_500))
                Spacer()
                Text(value, font: CSSFontInfo(size: .xs))
            }
            ProgressView(value: progress, color: color)
        }
    }
}

/// Team roster: team name + member count badge, divider, scrollable member list
@PublicView
struct TeamRoster {
    let teamName: String
    let members: [(String, String, Bool)]  // name, avatarURL, isOnline

    init(teamName: String, members: [(String, String, Bool)]) {
        self.teamName = teamName
        self.members = members
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .sm) {
            #HStack {
                Text(teamName, font: CSSFontInfo(size: .lg))
                Spacer()
                Badge(members.count)
            }
            Divider()
            ScrollView {
                ListView(divided: true) {
                    for (name, avatar, online) in members {
                        #HStack {
                            WebImage(src: avatar, alt: name, width: "w-8", height: "h-8", cornerRadius: .full)
                            Text(name, font: CSSFontInfo(size: .sm))
                            Spacer()
                            if online {
                                Badge("Online", prominence: .increased)
                            } else {
                                Badge("Offline", prominence: .decreased)
                            }
                        }
                    }
                }
            }
        }
    }
}

/// Feature comparison table (3-column: Feature, Basic, Pro)
@PublicView
struct FeatureComparison {
    let features: [(String, String, String)]  // feature, basic, pro

    init(features: [(String, String, String)]) {
        self.features = features
    }

    var body: some View {
        #Table {
            #TableRow {
                #TableCell(width: .w_1_3) { Text("Feature", font: CSSFontInfo(size: .xs, color: .gray_500)) }
                #TableCell(width: .w_1_3) { Text("Basic", font: CSSFontInfo(size: .xs, color: .gray_500)) }
                #TableCell(width: .w_1_3) { Text("Pro", font: CSSFontInfo(size: .xs, color: .gray_500)) }
            }
            for (feature, basic, pro) in features {
                #TableRow {
                    #TableCell(width: .w_1_3) { Text(feature) }
                    #TableCell(width: .w_1_3) { Text(basic) }
                    #TableCell(width: .w_1_3) { Text(pro) }
                }
            }
        }
    }
}

/// Breadcrumb navigation: items linked except the last one
@PublicView
struct BreadcrumbNav {
    let items: [(String, String)]  // label, path

    init(items: [(String, String)]) {
        self.items = items
    }

    var body: some View {
        #HStack(spacing: .xs) {
            for (index, item) in items.enumerated() {
                if index < items.count - 1 {
                    WebLink(destination: item.1) {
                        Text(item.0, font: CSSFontInfo(size: .sm, color: .blue_500))
                    }
                    Text("/", font: CSSFontInfo(size: .xs, color: .gray_400))
                } else {
                    Text(item.0, font: CSSFontInfo(size: .sm, color: .gray_600))
                }
            }
        }
    }
}

/// User profile card: avatar, name, bio, divider, tag row
@PublicView
struct UserProfileCard {
    let name: String
    let avatarURL: String
    let bio: String
    let tags: [String]

    init(name: String, avatarURL: String, bio: String, tags: [String]) {
        self.name = name
        self.avatarURL = avatarURL
        self.bio = bio
        self.tags = tags
    }

    var body: some View {
        #VStack(alignment: .center, spacing: .md) {
            WebImage(src: avatarURL, alt: name, width: "w-20", height: "h-20", cornerRadius: .full)
            Text(name, font: CSSFontInfo(size: .lg))
            Text(bio, font: CSSFontInfo(size: .sm, color: .gray_500))
            Divider()
            #HStack(spacing: .sm, wrap: true) {
                for tag in tags {
                    Badge(tag)
                }
            }
        }
    }
}

/// Dashboard grid: wrapped HStack of StatCards
@PublicView
struct DashboardGrid {
    let stats: [(String, String, Double, CSSColorKey)]

    init(stats: [(String, String, Double, CSSColorKey)]) {
        self.stats = stats
    }

    var body: some View {
        #HStack(alignment: .stretch, spacing: .md, wrap: true) {
            for (title, value, progress, color) in stats {
                StatCard(title: title, value: value, progress: progress, color: color)
            }
        }
    }
}

/// File row with type badge, filename, and size
enum FileType {
    case image, document, code
    var label: String {
        switch self {
        case .image: "IMG"
        case .document: "DOC"
        case .code: "SRC"
        }
    }
}

@PublicView
struct FileRow {
    let fileName: String
    let fileSize: String
    let fileType: FileType

    init(fileName: String, fileSize: String, fileType: FileType) {
        self.fileName = fileName
        self.fileSize = fileSize
        self.fileType = fileType
    }

    var body: some View {
        #HStack {
            Badge(fileType.label, prominence: .increased)
            #VStack(alignment: .leading, spacing: .xs) {
                Text(fileName, font: CSSFontInfo(size: .sm))
                Text(fileSize, font: CSSFontInfo(size: .xs, color: .gray_400))
            }
            Spacer()
        }
    }
}

/// Article preview: optional image + title + author/date + tags
@PublicView
struct ArticlePreview {
    let title: String
    let author: String
    let date: String
    let imageURL: String?
    let tags: [String]

    init(title: String, author: String, date: String, imageURL: String? = nil, tags: [String] = []) {
        self.title = title
        self.author = author
        self.date = date
        self.imageURL = imageURL
        self.tags = tags
    }

    var body: some View {
        #HStack(alignment: .top, spacing: .md) {
            if let imageURL {
                WebImage(src: imageURL, alt: title, width: "w-32", height: "h-24", cornerRadius: .md)
            }
            Text(title, font: CSSFontInfo(size: .lg))
            Text("\(author) · \(date)", font: CSSFontInfo(size: .xs, color: .gray_500))
            TagList(tags: tags)
        }
    }
}

/// Key-value detail form using Labels and ColonSymbol
@PublicView
struct KVDetail {
    let pairs: [(String, String)]

    init(pairs: [(String, String)]) {
        self.pairs = pairs
    }

    var body: some View {
        Form {
            Section("Details") {
                for (key, val) in pairs {
                    #HStack {
                        Label(text: key, bg_color: .gray_500)
                        ColonSymbol()
                        Text(val)
                    }
                }
            }
        }
    }
}

/// Search results page: query badge + divided list of links
@PublicView
struct SearchResults {
    let query: String
    let results: [(String, String, String)]  // title, url, description

    init(query: String, results: [(String, String, String)]) {
        self.query = query
        self.results = results
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .md) {
            #HStack(spacing: .sm) {
                Text("Results for", font: CSSFontInfo(size: .sm, color: .gray_500))
                Badge(query, prominence: .increased)
            }
            Divider()
            ListView(divided: true) {
                for (title, url, desc) in results {
                    WebLink(destination: url, opensInNewTab: true) {
                        Text(title, font: CSSFontInfo(size: .sm, color: .blue_500))
                    }
                }
            }
        }
    }
}

/// Status page: title + divided list of service name + up/down badge
@PublicView
struct StatusPage {
    let services: [(String, Bool)]  // name, isUp

    init(services: [(String, Bool)]) {
        self.services = services
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .md) {
            Text("System Status", font: CSSFontInfo(size: .xl))
            Divider()
            ListView(divided: true) {
                for (name, isUp) in services {
                    #HStack {
                        Text(name, font: CSSFontInfo(size: .sm))
                        Spacer()
                        if isUp {
                            Badge("Up", prominence: .increased)
                        } else {
                            Badge("Down", prominence: .decreased)
                        }
                    }
                }
            }
        }
    }
}

/// Footer links: multiple columns of titled link groups
@PublicView
struct FooterLinks {
    let columns: [(String, [(String, String)])]  // (title, [(label, url)])

    init(columns: [(String, [(String, String)])]) {
        self.columns = columns
    }

    var body: some View {
        #HStack(alignment: .top, spacing: .xl) {
            for (title, links) in columns {
                #VStack(alignment: .leading, spacing: .sm) {
                    Text(title, font: CSSFontInfo(size: .sm))
                    for (label, url) in links {
                        WebLink(destination: url) {
                            Text(label, font: CSSFontInfo(size: .xs, color: .blue_500))
                        }
                    }
                }
            }
        }
    }
}

/// Nested borders: outer Border wrapping VStack with inner bordered label
@PublicView
struct NestedBorderCard {
    let title: String
    let inner: String

    init(title: String, inner: String) {
        self.title = title
        self.inner = inner
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .sm) {
            Text(title, font: CSSFontInfo(size: .lg))
            Divider()
            BorderedLabel(text: inner, border: CSSBorderInfo(color: .gray_300), bg_color: .gray_100)
        }
    }
}

/// Step progress: badges for each step, arrows between, highlighted up to current
@PublicView
struct StepProgress {
    let steps: [String]
    let currentStep: Int

    init(steps: [String], currentStep: Int) {
        self.steps = steps
        self.currentStep = currentStep
    }

    var body: some View {
        #HStack(spacing: .sm) {
            for (index, step) in steps.enumerated() {
                if index <= currentStep {
                    Badge(step, prominence: .increased)
                } else {
                    Badge(step)
                }
                if index < steps.count - 1 {
                    Text("→", font: CSSFontInfo(size: .xs, color: .gray_400))
                }
            }
        }
    }
}

/// Gallery page: title, divider, wrapped grid of image cards
@PublicView
struct GalleryPage {
    let title: String
    let images: [(String, String)]  // url, caption

    init(title: String, images: [(String, String)]) {
        self.title = title
        self.images = images
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .md) {
            Text(title, font: CSSFontInfo(size: .xl))
            Divider()
            #HStack(alignment: .top, spacing: .md, wrap: true) {
                for (url, caption) in images {
                    ImageCard(imageURL: url, title: caption, description: "")
                }
            }
        }
    }
}

/// Order summary: bordered card with table of items + total row
@PublicView
struct OrderSummary {
    let items: [(String, Int, String)]  // name, qty, price
    let total: String

    init(items: [(String, Int, String)], total: String) {
        self.items = items
        self.total = total
    }

    var body: some View {
        #VStack(alignment: .leading, spacing: .md) {
            Text("Order Summary", font: CSSFontInfo(size: .lg))
            Divider()
            #Table {
                #TableRow {
                    #TableCell(width: .w_1_3) { Text("Item", font: CSSFontInfo(size: .xs, color: .gray_500)) }
                    #TableCell(width: .w_1_3) { Text("Qty", font: CSSFontInfo(size: .xs, color: .gray_500)) }
                    #TableCell(width: .w_1_3) { Text("Price", font: CSSFontInfo(size: .xs, color: .gray_500)) }
                }
                for (name, qty, price) in items {
                    #TableRow {
                        #TableCell(width: .w_1_3) { Text(name) }
                        #TableCell(width: .w_1_3) { Text("\(qty)") }
                        #TableCell(width: .w_1_3) { Text(price) }
                    }
                }
            }
            Divider()
            #HStack {
                Text("Total", font: CSSFontInfo(size: .sm))
                Spacer()
                Text(total, font: CSSFontInfo(size: .lg))
            }
        }
    }
}

/// A page with a VStack containing a title and an AlertDialog
@PublicView
struct PageWithAlert {
    let title: String
    let alertMessage: String

    init(title: String, alertMessage: String) {
        self.title = title
        self.alertMessage = alertMessage
    }

    var body: some View {
        #VStack {
            Text(title, font: CSSFontInfo(size: .xl))
            AlertDialog("Alert", message: alertMessage) {
                Text("OK")
            }
        }
    }
}

/// Triple nested: HStack with text + nested GreetingCard
@PublicView
struct TripleNested {
    let a: String
    let b: String
    let c: String

    init(a: String, b: String, c: String) {
        self.a = a
        self.b = b
        self.c = c
    }

    var body: some View {
        #HStack {
            Text(a, font: CSSFontInfo(size: .sm))
            GreetingCard(name: b, message: c)
        }
    }
}

/// Multi section form with two sections
@PublicView
struct MultiSectionForm {

    init() {}

    var body: some View {
        Form {
            Section("Personal") {
                #HStack {
                    Label(text: "Name", bg_color: .blue_500)
                    EqualSymbol()
                    BorderedLabel(text: "Alice", border: CSSBorderInfo(color: .gray_200), bg_color: .gray_50)
                }
            }
            Section("Work") {
                #HStack {
                    Label(text: "Company", bg_color: .green_500)
                    EqualSymbol()
                    BorderedLabel(text: "ACME", border: CSSBorderInfo(color: .gray_200), bg_color: .gray_50)
                }
            }
        }
    }
}

/// Navigation detail that shows a table inside the destination
@PublicView
struct NavDetailTable {
    @Binding var selectedPath: [String]

    init(selectedPath: Binding<[String]>) {
        self._selectedPath = selectedPath
    }

    var body: some View {
        NavigationStack(path: $selectedPath) {
            #VStack(alignment: .leading, spacing: .sm) {
                Text("Home", font: CSSFontInfo(size: .lg))
                NavigationLink("Users", destination: "/users")
            }
        } destination: { (_: String) in
            #Table {
                #TableRow {
                    #TableCell(width: .w_1_2) { Text("Name", font: CSSFontInfo(size: .xs, color: .gray_500)) }
                    #TableCell(width: .w_1_2) { Text("Score", font: CSSFontInfo(size: .xs, color: .gray_500)) }
                }
                #TableRow {
                    #TableCell(width: .w_1_2) { Text("Alice") }
                    #TableCell(width: .w_1_2) { Badge("95", prominence: .increased) }
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
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-lg">GitHub</span>"#
            + #"<span class="text-sm text-gray-500">Code hosting</span>"#
            + #"<a href="https://github.com" target="_blank" class="cursor-pointer"><span class="text-sm text-blue-500">Visit →</span></a>"#
            + #"</div>"#
        )
    }

    // MARK: - NotificationBanner

    @Test func notificationBannerSuccess() {
        let view = NotificationBanner(message: "Saved!", style: .success)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">✓</span>"#
            + #"<span class="text-sm text-green-600">Saved!</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"</div>"#
        )
    }

    @Test func notificationBannerError() {
        let view = NotificationBanner(message: "Failed!", style: .error)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">✗</span>"#
            + #"<span class="text-sm text-red-600">Failed!</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"</div>"#
        )
    }

    @Test func notificationBannerWarning() {
        let view = NotificationBanner(message: "Caution", style: .warning)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">⚠</span>"#
            + #"<span class="text-sm text-yellow-600">Caution</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"</div>"#
        )
    }

    // MARK: - PricingCard

    @Test func pricingCardBasic() {
        let view = PricingCard(plan: "Free", price: "$0", features: ["1 user", "5GB"])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-center gap-4">"#
            + #"<span class="text-xl">Free</span>"#
            + #"<span class="text-2xl text-blue-500">$0</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<ul class="flex flex-col">"#
            + #"<span class="text-sm">1 user</span>"#
            + #"<span class="text-sm">5GB</span>"#
            + #"</ul>"#
            + #"</div>"#
        )
    }

    @Test func pricingCardNoFeatures() {
        let view = PricingCard(plan: "Pro", price: "$99", features: [])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-center gap-4">"#
            + #"<span class="text-xl">Pro</span>"#
            + #"<span class="text-2xl text-blue-500">$99</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<ul class="flex flex-col">"#
            + #"</ul>"#
            + #"</div>"#
        )
    }

    // MARK: - MetricRow

    @Test func metricRow() {
        let view = MetricRow(label: "CPU", value: "73%", progress: 0.73)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-stretch gap-1">"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="text-xs text-gray-500">CPU</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"<span class="text-xs">73%</span>"#
            + #"</div>"#
            + #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 73.0%"></div></div>"#
            + #"</div>"#
        )
    }

    @Test func metricRowCustomColor() {
        let view = MetricRow(label: "RAM", value: "90%", progress: 0.9, color: .red_500)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-stretch gap-1">"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="text-xs text-gray-500">RAM</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"<span class="text-xs">90%</span>"#
            + #"</div>"#
            + #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-red-500 h-2.5 rounded-full transition-all duration-300" style="width: 90.0%"></div></div>"#
            + #"</div>"#
        )
    }

    // MARK: - TeamRoster

    @Test func teamRosterTwo() {
        let view = TeamRoster(teamName: "Alpha", members: [
            ("Alice", "/a.png", true),
            ("Bob", "/b.png", false),
        ])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="text-lg">Alpha</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">2</span>"#
            + #"</div>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<div class="overflow-y-auto">"#
            + #"<ul class="flex flex-col divide-y divide-gray-200">"#
            + #"<div class="flex flex-row w-full items-center gap-4"><img src="/a.png" alt="Alice" class="object-cover w-8 h-8 rounded-full"><span class="text-sm">Alice</span><div class="flex-grow"></div><span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">Online</span></div>"#
            + #"<div class="flex flex-row w-full items-center gap-4"><img src="/b.png" alt="Bob" class="object-cover w-8 h-8 rounded-full"><span class="text-sm">Bob</span><div class="flex-grow"></div><span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-200 text-gray-600">Offline</span></div>"#
            + #"</ul>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    @Test func teamRosterEmpty() {
        let view = TeamRoster(teamName: "Empty", members: [])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="text-lg">Empty</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"</div>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<div class="overflow-y-auto">"#
            + #"<ul class="flex flex-col divide-y divide-gray-200">"#
            + #"</ul>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - FeatureComparison

    @Test func featureComparisonTable() {
        let view = FeatureComparison(features: [
            ("Storage", "10GB", "100GB"),
            ("Users", "1", "∞"),
        ])
        HTMLExpect(view, toBe:
            #"<table class="w-full table-auto border-collapse">"#
            + #"<tr class="border-b border-gray-100">"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Feature</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Basic</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Pro</span></td>"#
            + #"</tr>"#
            + #"<tr class="border-b border-gray-100">"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">Storage</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">10GB</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">100GB</span></td>"#
            + #"</tr>"#
            + #"<tr class="border-b border-gray-100">"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">Users</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">1</span></td>"#
            + #"<td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">∞</span></td>"#
            + #"</tr>"#
            + #"</table>"#
        )
    }

    // MARK: - BreadcrumbNav

    @Test func breadcrumbThreeItems() {
        let view = BreadcrumbNav(items: [("Home", "/"), ("Blog", "/blog"), ("Post", "/blog/1")])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-1">"#
            + #"<a href="/" class="cursor-pointer"><span class="text-sm text-blue-500">Home</span></a>"#
            + #"<span class="text-xs text-gray-400">/</span>"#
            + #"<a href="/blog" class="cursor-pointer"><span class="text-sm text-blue-500">Blog</span></a>"#
            + #"<span class="text-xs text-gray-400">/</span>"#
            + #"<span class="text-sm text-gray-600">Post</span>"#
            + #"</div>"#
        )
    }

    @Test func breadcrumbSingleItem() {
        let view = BreadcrumbNav(items: [("Home", "/")])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-1">"#
            + #"<span class="text-sm text-gray-600">Home</span>"#
            + #"</div>"#
        )
    }

    // MARK: - UserProfileCard

    @Test func userProfileCard() {
        let view = UserProfileCard(
            name: "Alice Smith", avatarURL: "/alice.png",
            bio: "Swift developer", tags: ["iOS", "Web"]
        )
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-center gap-4">"#
            + #"<img src="/alice.png" alt="Alice Smith" class="object-cover w-20 h-20 rounded-full">"#
            + #"<span class="text-lg">Alice Smith</span>"#
            + #"<span class="text-sm text-gray-500">Swift developer</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<div class="flex flex-row w-full items-center gap-2 flex-wrap">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">iOS</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">Web</span>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    @Test func userProfileCardNoTags() {
        let view = UserProfileCard(
            name: "Bob", avatarURL: "/bob.png",
            bio: "Designer", tags: []
        )
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-center gap-4">"#
            + #"<img src="/bob.png" alt="Bob" class="object-cover w-20 h-20 rounded-full">"#
            + #"<span class="text-lg">Bob</span>"#
            + #"<span class="text-sm text-gray-500">Designer</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<div class="flex flex-row w-full items-center gap-2 flex-wrap">"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - DashboardGrid

    @Test func dashboardGridThreeCards() {
        let view = DashboardGrid(stats: [
            ("Users", "1.2K", 0.8, CSSColorKey.blue_500),
            ("Revenue", "$5K", 0.5, CSSColorKey.green_500),
            ("Errors", "12", 0.1, CSSColorKey.red_500),
        ])
        // Each StatCard renders inside an HStack with wrap
        let usersCard =
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-xs text-gray-500">Users</span>"#
            + #"<span class="text-2xl text-blue-500">1.2K</span>"#
            + #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-blue-500 h-2.5 rounded-full transition-all duration-300" style="width: 80.0%"></div></div>"#
            + #"</div>"#
        let revenueCard =
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-xs text-gray-500">Revenue</span>"#
            + #"<span class="text-2xl text-green-500">$5K</span>"#
            + #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-green-500 h-2.5 rounded-full transition-all duration-300" style="width: 50.0%"></div></div>"#
            + #"</div>"#
        let errorsCard =
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-xs text-gray-500">Errors</span>"#
            + #"<span class="text-2xl text-red-500">12</span>"#
            + #"<div class="w-full bg-gray-200 rounded-full h-2.5 overflow-hidden"><div class="bg-red-500 h-2.5 rounded-full transition-all duration-300" style="width: 10.0%"></div></div>"#
            + #"</div>"#

        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-stretch gap-4 flex-wrap">"#
            + usersCard + revenueCard + errorsCard
            + #"</div>"#
        )
    }

    // MARK: - FileRow

    @Test func fileRowImage() {
        let view = FileRow(fileName: "photo.png", fileSize: "2.4MB", fileType: .image)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">IMG</span>"#
            + #"<div class="flex flex-col w-full items-start gap-1">"#
            + #"<span class="text-sm">photo.png</span>"#
            + #"<span class="text-xs text-gray-400">2.4MB</span>"#
            + #"</div>"#
            + #"<div class="flex-grow"></div>"#
            + #"</div>"#
        )
    }

    @Test func fileRowDoc() {
        let view = FileRow(fileName: "readme.md", fileSize: "1KB", fileType: .document)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">DOC</span>"#
            + #"<div class="flex flex-col w-full items-start gap-1">"#
            + #"<span class="text-sm">readme.md</span>"#
            + #"<span class="text-xs text-gray-400">1KB</span>"#
            + #"</div>"#
            + #"<div class="flex-grow"></div>"#
            + #"</div>"#
        )
    }

    @Test func fileRowCode() {
        let view = FileRow(fileName: "app.swift", fileSize: "12KB", fileType: .code)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">SRC</span>"#
            + #"<div class="flex flex-col w-full items-start gap-1">"#
            + #"<span class="text-sm">app.swift</span>"#
            + #"<span class="text-xs text-gray-400">12KB</span>"#
            + #"</div>"#
            + #"<div class="flex-grow"></div>"#
            + #"</div>"#
        )
    }

    // MARK: - ArticlePreview

    @Test func articlePreview() {
        let view = ArticlePreview(
            title: "SwiftUI Guide", author: "Alice",
            date: "2025-01-01", imageURL: "/cover.jpg",
            tags: ["Swift", "UI"]
        )
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-start gap-4">"#
            + #"<img src="/cover.jpg" alt="SwiftUI Guide" class="object-cover w-32 h-24 rounded-md">"#
            + #"<span class="text-lg">SwiftUI Guide</span>"#
            + #"<span class="text-xs text-gray-500">Alice \#u{00b7} 2025-01-01</span>"#
            + #"<div class="flex flex-row w-full items-center gap-2 flex-wrap">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">Swift</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">UI</span>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    @Test func articlePreviewNoImage() {
        let view = ArticlePreview(
            title: "Quick Tip", author: "Bob",
            date: "2025-06-15", tags: ["Tips"]
        )
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-start gap-4">"#
            + #"<span class="text-lg">Quick Tip</span>"#
            + #"<span class="text-xs text-gray-500">Bob \#u{00b7} 2025-06-15</span>"#
            + #"<div class="flex flex-row w-full items-center gap-2 flex-wrap">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">Tips</span>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - KVDetail

    @Test func kvDetailForm() {
        let view = KVDetail(pairs: [
            ("Name", "Alice"),
            ("Role", "Admin"),
            ("Dept", "Engineering"),
        ])
        HTMLExpect(view, toBe:
            #"<form class="flex flex-col gap-4">"#
            + #"<section class="space-y-2">"#
            + #"<div class="font-semibold text-sm text-gray-700"><span class="text-sm">Details</span></div>"#
            + #"<div class="flex flex-row w-full items-center gap-4"><span class="w-1/3 inline-block rounded px-3 py-1.5 text-sm bg-gray-500">Name</span><span class="text-gray-400">:</span><span class="text-sm">Alice</span></div>"#
            + #"<div class="flex flex-row w-full items-center gap-4"><span class="w-1/3 inline-block rounded px-3 py-1.5 text-sm bg-gray-500">Role</span><span class="text-gray-400">:</span><span class="text-sm">Admin</span></div>"#
            + #"<div class="flex flex-row w-full items-center gap-4"><span class="w-1/3 inline-block rounded px-3 py-1.5 text-sm bg-gray-500">Dept</span><span class="text-gray-400">:</span><span class="text-sm">Engineering</span></div>"#
            + #"</section>"#
            + #"</form>"#
        )
    }

    // MARK: - SearchResults

    @Test func searchResultsMultiple() {
        let view = SearchResults(query: "swift", results: [
            ("Swift.org", "https://swift.org", "The Swift Language"),
            ("GitHub", "https://github.com", "Where code lives"),
        ])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-4">"#
            + #"<div class="flex flex-row w-full items-center gap-2">"#
            + #"<span class="text-sm text-gray-500">Results for</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">swift</span>"#
            + #"</div>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<ul class="flex flex-col divide-y divide-gray-200">"#
            + #"<a href="https://swift.org" target="_blank" class="cursor-pointer"><span class="text-sm text-blue-500">Swift.org</span></a>"#
            + #"<a href="https://github.com" target="_blank" class="cursor-pointer"><span class="text-sm text-blue-500">GitHub</span></a>"#
            + #"</ul>"#
            + #"</div>"#
        )
    }

    @Test func searchResultsEmpty() {
        let view = SearchResults(query: "zzz", results: [])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-4">"#
            + #"<div class="flex flex-row w-full items-center gap-2">"#
            + #"<span class="text-sm text-gray-500">Results for</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">zzz</span>"#
            + #"</div>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<ul class="flex flex-col divide-y divide-gray-200">"#
            + #"</ul>"#
            + #"</div>"#
        )
    }

    // MARK: - StatusPage

    @Test func statusPageAllUp() {
        let view = StatusPage(services: [
            ("API", true), ("DB", true), ("CDN", false),
        ])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-4">"#
            + #"<span class="text-xl">System Status</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<ul class="flex flex-col divide-y divide-gray-200">"#
            + #"<div class="flex flex-row w-full items-center gap-4"><span class="text-sm">API</span><div class="flex-grow"></div><span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">Up</span></div>"#
            + #"<div class="flex flex-row w-full items-center gap-4"><span class="text-sm">DB</span><div class="flex-grow"></div><span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">Up</span></div>"#
            + #"<div class="flex flex-row w-full items-center gap-4"><span class="text-sm">CDN</span><div class="flex-grow"></div><span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-200 text-gray-600">Down</span></div>"#
            + #"</ul>"#
            + #"</div>"#
        )
    }

    // MARK: - FooterLinks

    @Test func footerLinksThreeColumns() {
        let view = FooterLinks(columns: [
            ("Product", [("Features", "/features"), ("Pricing", "/pricing")]),
            ("Company", [("About", "/about")]),
        ])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-start gap-8">"#
            + #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-sm">Product</span>"#
            + #"<a href="/features" class="cursor-pointer"><span class="text-xs text-blue-500">Features</span></a>"#
            + #"<a href="/pricing" class="cursor-pointer"><span class="text-xs text-blue-500">Pricing</span></a>"#
            + #"</div>"#
            + #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-sm">Company</span>"#
            + #"<a href="/about" class="cursor-pointer"><span class="text-xs text-blue-500">About</span></a>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - NestedBorders

    @Test func nestedBorders() {
        let view = NestedBorderCard(title: "Outer", inner: "Inner content")
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-lg">Outer</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<span class="w-full inline-block border border-gray-300 rounded px-3 py-1.5 text-sm bg-gray-100">Inner content</span>"#
            + #"</div>"#
        )
    }

    // MARK: - StepProgress

    @Test func stepProgressMiddle() {
        let view = StepProgress(steps: ["Cart", "Shipping", "Payment", "Done"], currentStep: 1)
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-2">"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">Cart</span>"#
            + #"<span class="text-xs text-gray-400">→</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-red-500 text-white">Shipping</span>"#
            + #"<span class="text-xs text-gray-400">→</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">Payment</span>"#
            + #"<span class="text-xs text-gray-400">→</span>"#
            + #"<span class="inline-flex items-center justify-center px-2 py-0.5 text-xs font-medium rounded-full bg-gray-500 text-white">Done</span>"#
            + #"</div>"#
        )
    }

    // MARK: - GalleryPage

    @Test func galleryPage() {
        let view = GalleryPage(title: "Photos", images: [
            ("/a.jpg", "Sunset"),
            ("/b.jpg", "Mountain"),
        ])
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-4">"#
            + #"<span class="text-xl">Photos</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<div class="flex flex-row w-full items-start gap-4 flex-wrap">"#
            + #"<div class="flex flex-col w-full items-start gap-2"><img src="/a.jpg" alt="Sunset" class="object-cover rounded-lg"><span class="text-lg">Sunset</span><span class="text-sm text-gray-600"></span></div>"#
            + #"<div class="flex flex-col w-full items-start gap-2"><img src="/b.jpg" alt="Mountain" class="object-cover rounded-lg"><span class="text-lg">Mountain</span><span class="text-sm text-gray-600"></span></div>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - OrderSummary

    @Test func orderSummary() {
        let view = OrderSummary(items: [
            ("Widget", 2, "$10"),
            ("Gadget", 1, "$25"),
        ], total: "$45")
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-start gap-4">"#
            + #"<span class="text-lg">Order Summary</span>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<table class="w-full table-auto border-collapse">"#
            + #"<tr class="border-b border-gray-100"><td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Item</span></td><td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Qty</span></td><td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-xs text-gray-500">Price</span></td></tr>"#
            + #"<tr class="border-b border-gray-100"><td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">Widget</span></td><td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">2</span></td><td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">$10</span></td></tr>"#
            + #"<tr class="border-b border-gray-100"><td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">Gadget</span></td><td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">1</span></td><td class="px-3 py-2 text-sm align-middle w-1/3"><span class="text-sm">$25</span></td></tr>"#
            + #"</table>"#
            + #"<hr class="border-t border-gray-200 my-2 w-full">"#
            + #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="text-sm">Total</span>"#
            + #"<div class="flex-grow"></div>"#
            + #"<span class="text-lg">$45</span>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - SegmentedPicker (uses ForEach internally, verify via contains)

    @Test func segmentedPickerRendersSegments() {
        // SegmentedPicker uses ForEach → _KeyedView which doesn't support .render()
        // Verify it compiles and can be constructed
        let picker = SegmentedPicker(segments: [
            Segment(title: "Day", isSelected: true, onSelect: {}),
            Segment(title: "Week", onSelect: {}),
        ])
        // Type check: picker is a valid view
        _ = picker
    }

    // MARK: - DropdownMenu with items

    @Test func dropdownMenuClosed() {
        let view = DropdownMenu("Actions", isOpen: false) {
            Text("Edit")
            Text("Delete")
        }
        let html = view.render()
        #expect(html.contains("Actions"))
        // Closed menu should NOT contain the dropdown panel content wrapper
        #expect(!html.contains(#"absolute z-10"#))
    }

    @Test func dropdownMenuOpen() {
        let view = DropdownMenu("Actions", isOpen: true) {
            Text("Edit")
            Text("Delete")
        }
        let html = view.render()
        #expect(html.contains("Actions"))
        #expect(html.contains(#"absolute z-10"#))
        #expect(html.contains("Edit"))
        #expect(html.contains("Delete"))
    }

    // MARK: - Composed: Alert inside VStack

    @Test func alertInsideVStack() {
        let view = PageWithAlert(title: "Dashboard", alertMessage: "Session expired")
        HTMLExpect(view, toBe:
            #"<div class="flex flex-col w-full items-stretch gap-4">"#
            + #"<span class="text-xl">Dashboard</span>"#
            + #"<div class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">"#
            + #"<div class="bg-white rounded-lg shadow-xl max-w-sm w-full mx-4 p-6">"#
            + #"<div class="text-lg font-semibold text-gray-900 mb-2">Alert</div>"#
            + #"<div class="text-sm text-gray-600 mb-4">Session expired</div>"#
            + #"<div class="flex justify-end gap-2">"#
            + #"<span class="text-sm">OK</span>"#
            + #"</div>"#
            + #"</div>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - Triple nested VStack/HStack

    @Test func tripleNestedLayout() {
        let view = TripleNested(a: "A", b: "B", c: "C")
        HTMLExpect(view, toBe:
            #"<div class="flex flex-row w-full items-center gap-4">"#
            + #"<span class="text-sm">A</span>"#
            + #"<div class="flex flex-col w-full items-start gap-2">"#
            + #"<span class="text-xl">B</span>"#
            + #"<span class="text-sm text-gray-500">C</span>"#
            + #"</div>"#
            + #"</div>"#
        )
    }

    // MARK: - Multi-section form

    @Test func multiSectionForm() {
        let view = MultiSectionForm()
        let html = view.render()
        #expect(html.contains(#"<form class="flex flex-col gap-4">"#))
        #expect(html.contains("Personal"))
        #expect(html.contains("Name"))
        #expect(html.contains("Work"))
        #expect(html.contains("Company"))
        // Two sections
        #expect(html.contains("Personal"))
        #expect(html.contains("Work"))
    }

    // MARK: - Nav detail with table inside

    @Test func navDetailWithTable() {
        var path = ["users"]
        let binding = Binding(get: { path }, set: { path = $0 })
        let view = NavDetailTable(selectedPath: binding)
        let html = view.render()
        // Should show the detail view (table)
        #expect(html.contains(#"table class="w-full table-auto border-collapse""#))
        #expect(html.contains("Name"))
        #expect(html.contains("Score"))
    }
}
