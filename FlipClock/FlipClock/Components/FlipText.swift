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
                FlipTextHalf(value: $currentValue, placement: .top, alignment: placement.alignmentTop)
                FlipTextHalf(value: $previousValue, placement: .top, alignment: placement.alignmentTop)
                    .rotation3DEffect(
                        Angle(degrees: animateTop ? -90.0 : .leastNonzeroMagnitude),
                        axis: (1.0, 0.0, 0.0),
                        anchor: .bottom,
                        perspective: 0
                    )
            }
//            .clipped()
            ZStack {
                FlipTextHalf(value: $previousValue, placement: .bottom, alignment: placement.alignmentBottom)
                FlipTextHalf(value: $currentValue, placement: .bottom, alignment: placement.alignmentBottom)
                    .rotation3DEffect(
                        Angle(degrees: animateBottom ? .leastNonzeroMagnitude : 90.0),
                        axis: (1.0, 0.0, 0.0),
                        anchor: .top,
                        perspective: 0
                    )
            }
//            .clipped()
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
            previousValue = currentValue
            animateTop = false
            animateBottom = false
            
            withAnimation(Animation.easeIn(duration: 0.2)) {
                currentValue = newValue
                animateTop = true
            }

            withAnimation(Animation.easeOut(duration: 0.2).delay(0.2)) {
                animateBottom = true
            }
        }
    }
}

struct FlipText_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeoRoundedRectangle(configuration: .dial)
            HStack(spacing: 0) {
                FlipText(value: .constant("1"), placement: .right)
                FlipText(value: .constant("2"), placement: .left)
            }
            .font(.system(size: 200, weight: .bold, design: .rounded).width(.compressed).monospacedDigit())
            .padding(8)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
