# 



# Add more UI elements concepts from SwiftUI in ElementaryViews

the generic struct issue fix

```
@PublicView
struct Button<Label: View>  {
    
    let label: Label
    let onClick: () -> Void
    
    typealias Tag = HTMLTag.button // important and allows us to specific example Label: View
    // @View/@PublicView expects first generic arg to be Tag, and doesnt play nicely with this
    // Generic struct, but by setting Tag inside the struct we now allowed to add own Generics 
    // to the struct, and should allow more SwiftUI alike structs
    
    // init it with view cloussure
    init(@HTMLBuilder label: ()->Label, onClick: @escaping () -> Void) {
        self.label = label()
        self.onClick = onClick
    }
    
    // init it with fixed View type
    init(label: Label, onClick: @escaping () -> Void) {
        self.label = label
        self.onClick = onClick
    }
    
    // init with StringProtocol since View is kinda just "String"
    init(text: Label, onClick: @escaping () -> Void) where Label: StringProtocol {
        self.label = text
        self.onClick = onClick
    }
    
    var body: some View {
        button { label }
            .onClick(onClick)
    }
}
```

we can make View functions like this 

```
extension View {
    
    consuming func frame(_ css: CSSTextSize) -> some View<Tag> {
        self // self modified with sizing
    }
    
    consuming func _button(_ onClick: @escaping ()->Void) -> some View {
        Button(label: self, onClick: onClick)
    }
}
```

dont know if Elementary has Html/ViewModifier concept or if needed to make at all for the view functions ..

there is a research folder with the whole SwiftUI api, also OpenSwiftUI have been added in case you need some example of how to implement NavigationStack ect..

* research/OpenSwiftUI
* research/SwiftUI-api

general usage of ElementaryUI and Tailwind CSS
* research/elementary-ui
* research/tailwind_css



# Make Tests for all Views

figure out a way how we can test the views
since ElementaryUI is based on html strings and rest relies on tailwind strings also, 
we can test that view produces the expected string / tailwind css / html structure or whatever makes most sense..


# Claude Agent File / Rules

also make a Claude Agent file for generale promoting in the future with rule set that always cross check with 
* elementary-ui
* SwiftUI-api
* tailwind_css

apis in the research folder.

# some makn rules to follows
* ALWAYS MAKE TESTS FOR NEW VIEW COMPONENTS..
* Verify tests passes before committing changes
* Commit one Successfull view/component at the time

