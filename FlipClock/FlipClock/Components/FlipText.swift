//
//  FlipText.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI

struct FlipText: View {
    
    @Binding var value: Character
    let placement: FlipTextPlacement
    @State private var animateTop: Bool = false
    @State private var animateBottom: Bool = false
    @State private var currentValue: Character = " "
    @State private var previousValue: Character = " "
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Current Value
                FlipTextHalf(value: $currentValue, placement: .top, alignment: placement.alignmentTop)
                // Old value
                FlipTextHalf(value: $previousValue, placement: .top, alignment: placement.alignmentTop)
                    .rotation3DEffect(
                        Angle(degrees: animateTop ? -90 : .zero),
                        axis: (1, 0, 0),
                        anchor: .bottom,
                        perspective: 0.5
                    )
            }
            ZStack {
                // Old value
                FlipTextHalf(value: $previousValue, placement: .bottom, alignment: placement.alignmentBottom)
                // Current Value
                FlipTextHalf(value: $currentValue, placement: .bottom, alignment: placement.alignmentBottom)
                    .rotation3DEffect(
                        Angle(degrees: animateBottom ? .zero : 90),
                        axis: (1, 0, 0),
                        anchor: .top,
                        perspective: 0.5
                    )
            }
        }
        .overlay {
            Color.asset.background.frame(height: 3)
        }
        .onAppear {
            currentValue = value
            previousValue = value
        }
        .onChange(of: value) { newValue in
            guard currentValue != newValue else { return }
            print("IN")
            previousValue = currentValue
            animateTop = false
            animateBottom = false
            
            // MARK: Remove speed for production
            withAnimation(Animation.easeIn(duration: 0.2).speed(0.5)) {
                currentValue = newValue
                animateTop = true
            }

            withAnimation(Animation.easeOut(duration: 0.2).delay(0.2).speed(0.5)) {
                animateBottom = true
            }
        }
// MARK: For testing
//        .onTapGesture {
//            let nextValue = value.wholeNumberValue! + 1
//            value = Character(String(nextValue))
//        }
    }
}

struct FlipText_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeoRoundedRectangle(configuration: .dial)
            HStack(spacing: 8) {
                FlipText(value: .constant("1"), placement: .right)
                FlipText(value: .constant("3"), placement: .left)
            }
            .font(.system(size: 200, weight: .bold, design: .rounded).width(.compressed).monospacedDigit())
            .padding(8)
        }
        .frame(width: 300, height: 300)
    }
}
