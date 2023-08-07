//
//  FlipText.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI

struct FlipText: View {
    
    @State var animateTop: Bool = false
    @State var animateBottom: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                FlipTextHalf(character: "1", fontSize: 150, placement: .top, alignment: .bottom)
                FlipTextHalf(character: "2", fontSize: 150, placement: .top, alignment: .bottom)
                    .rotation3DEffect(
                        Angle(degrees: animateTop ? -90 : .zero),
                        axis: (1, 0, 0),
                        anchor: .bottom,
                        perspective: 0.5
                    )
            }
            ZStack {
                FlipTextHalf(character: "2", fontSize: 150, placement: .bottom, alignment: .top)
                FlipTextHalf(character: "1", fontSize: 150, placement: .bottom, alignment: .top)
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
        .onTapGesture {
            animateTop = false
            animateBottom = false
            // MARK: Remove speed for production
            withAnimation(Animation.easeIn(duration: 0.2).speed(0.5)) {
                animateTop = true
            }

            withAnimation(Animation.easeOut(duration: 0.2).delay(0.2).speed(0.5)) {
                animateBottom = true
            }
        }
    }
}

struct FlipText_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeoRoundedRectangle(
                cornerRadius: 20,
                fillColor: Color.asset.background,
                colorA: Color.asset.dialAShadowColor,
                colorB: Color.asset.dialBShadowColor
            )
            FlipText()
        }
        .frame(width: 300, height: 300)
    }
}
