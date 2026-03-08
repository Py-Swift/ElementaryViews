import ElementaryUI
import ElementaryViews

@PublicView
struct StateView {
    @State var count = 0

    var body: some View {
        #VStack {
            
            Text("Counter: <\(count)>", font: .init(size: .xl2))
            #HStack(spacing: .md) {
                //Button(label: Label(text: "- Decrease", bg_color: .red_800) , onClick: { count -= 1 })
                button {
                    "- Decrease"
                }
                .onClick {
                    count -= 1
                }
                //Button(label: Label(text: "+ Increase", bg_color: .red_800) , onClick: { count += 1 })
                button {
                    "+ Increase"
                }
                .onClick {
                    count += 1
                }
                Button {
                    Text("++")
                } onClick: {
                    count += 2
                }

            }
        }
    }
}

@PublicView
struct ScalableColor {
    let color: Color
    let animation: Animation?
    @State var clicked = false
    
    var body: some View {
        color.scaleEffect(clicked ? 1.5 : 1)
            .onClick {
                withAnimation(animation) {
                    clicked.toggle()
                }
            }
    }
    
}

@PublicView
struct RotatedColor {
    
    let color: Color
    let animation: Animation?
    @State var clicked = false
    
    var body: some View {
        color.rotationEffect(.degrees(clicked ? 90 : 0))
            .onClick {
                withAnimation(animation) {
                    clicked.toggle()
                }
                
            }
    }
}

@PublicView
struct RotatedScaleColor {
    
    let color: Color
    let animation: Animation?
    @State var clicked = false
    
    var body: some View {
        color
            .scaleEffect(clicked ? 0.75 : 1)
            .rotationEffect(.degrees(clicked ? 180 : 0))
            .onClick {
                withAnimation(animation) {
                    clicked.toggle()
                }
                
            }
    }
}

@PublicView
struct ColorViewTest {
    let color: Color
    @State var clicked = false
    @State var spaced = false
    var body: some View {
        #VStack {
        //ListView {
            
//            Color.purple
//                .scaleEffect(clicked ? 2 : 1)
//                .onClick {
//                    withAnimation(.snappy(duration: 0.5, extraBounce: 0.3)) {
//                        clicked.toggle()
//                    }
//                }
            Label(text: "Hello", bg_color: .green_200)
            BorderedLabel(text: "Hello", border: .init(color: .orange_900), bg_color: .yellow_50)
//            button(span(.class("click me"))).onClick {
//                withAnimation {
//                    clicked.toggle()
//                }
//               
//            }
            button {
                span(.class(CSSTextSize.sm.rawValue)) {"click me"}
                
            }.onClick {
                withAnimation {
                    clicked.toggle()
                }
            }
            button {
                span(.class(CSSTextSize.sm.rawValue)) {"click me 2"}
                
            }.onClick {
                withAnimation(.snappy(duration: 0.5, extraBounce: 0.3)) {
                    clicked.toggle()
                }
            }
            
            color
            RotatedColor(color: .yellow, animation: .smooth(duration: 0.5, extraBounce: 0.3))
            ScalableColor(color: .orange, animation: .snappy(duration: 0.5, extraBounce: 0.3))
            RotatedScaleColor(color: color, animation: .snappy(duration: 0.5, extraBounce: 0.5))
//            __Button(text: "click me 3") {
//                withAnimation {
//                    clicked.toggle()
//                }
//            }
            Divider()
        }
    }
}


@View
struct ContentView {
    @State var count = 0
    @State var name = ""

    var body: some View {
        #VStack(alignment: .leading, spacing: .lg) {
            // Header
            Text("ElementaryViews Hot Reload Test", font: .init(size: .xl3))
            Text("Edit Swift files and watch the browser reload", font: .init(size: .lg, color: .gray_400))

            Divider()
            Color.red
            Divider()
            // Counter
            StateView()

            Divider()

            // Text Input
            Text("Text Input", font: .init(size: .xl))
            TextField("Your name", text: $name)
            if !name.isEmpty {
                Text("Hello, \(name)!", font: .init(size: .lg, color: .green_400))
            }

            Divider()

            // Labels & Badges
            Text("Labels & Badges", font: .init(size: .xl))
            #HStack(spacing: .md, wrap: true) {
                BorderedLabel(text: "Swift!!!",border: .init(color: .yellow_700), bg_color: .green_500)
                Label(text: "WebAssembly", bg_color: .green_500)
                    
                Badge("Hot Reload", prominence: .decreased)
                Badge("ElementaryUI", prominence: .standard)
                Badge("Tailwind CSS", prominence: .increased)
            }
        }
    }
}
