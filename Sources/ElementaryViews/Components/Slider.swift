//
//  Slider.swift
//  ElementaryViews
//
import ElementaryUI

@PublicView
public struct Slider {

    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double

    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...100,
        step: Double = 1
    ) {
        self._value = value
        self.range = range
        self.step = step
    }

    public var body: some View {
        input(
            .type(.range),
            .class("w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-500"),
            .value(String(value)),
            .custom(name: "min", value: String(range.lowerBound)),
            .custom(name: "max", value: String(range.upperBound)),
            .custom(name: "step", value: String(step))
        )
        .onInput { event in
            if let str = event.targetValue, let num = Double(str) {
                value = num
            }
        }
    }
}
