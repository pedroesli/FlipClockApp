//
//  FlipText.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI

struct FlipText: View {
    
    @Binding var info: FlipTextInfo
    let placement: FlipTextPlacement
    @State private var animateTop: Bool = false
    @State private var animateBottom: Bool = false
    @State private var currentValue: String = " "
    @State private var previousValue: String = " "
    @State private var currentPeriodText: String = ""
    @State private var previousPeriodText: String = ""
    
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
            ZStack {
                FlipTextHalf(value: $previousValue, placement: .bottom, alignment: placement.alignmentBottom)
                    .overlay {
                        Text(previousPeriodText)
                            .font(.system(size: 32).bold().width(.compressed))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                            .padding(.leading, 20)
                            .padding(.bottom, 16)
                    }
                FlipTextHalf(value: $currentValue, placement: .bottom, alignment: placement.alignmentBottom)
                    .overlay {
                        Text(currentPeriodText)
                            .font(.system(size: 20).bold().width(.compressed))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                            .padding(.leading, 20)
                            .padding(.bottom, 16)
                    }
                    .rotation3DEffect(
                        Angle(degrees: animateBottom ? .leastNonzeroMagnitude : 90.0),
                        axis: (1.0, 0.0, 0.0),
                        anchor: .top,
                        perspective: 0
                    )
            }
        }
        .overlay {
            Color.asset.background.frame(height: 3)
        }
        .onAppear {
            currentValue = info.value
            previousValue = info.value
            
            guard let periodText = info.periodText else { return }
            currentPeriodText = periodText
            previousPeriodText = periodText
        }
        .onChange(of: info.value) { newValue in
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
        .onChange(of: info.periodText) { newValue in
            guard let newValue else {
                previousPeriodText = ""
                currentPeriodText = ""
                return
            }
            guard currentPeriodText != newValue else { return }
            previousPeriodText = currentPeriodText
            currentPeriodText = newValue
        }
    }
}

struct FlipText_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeoRoundedRectangle(configuration: .dial)
            HStack(spacing: 0) {
                FlipText(info: .constant(FlipTextInfo(value: "1", periodText: "PM")), placement: .right)
                FlipText(info: .constant(FlipTextInfo(value: "2")), placement: .left)
            }
            .font(.system(size: 200, weight: .bold, design: .rounded).width(.compressed).monospacedDigit())
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(8)
    }
}
