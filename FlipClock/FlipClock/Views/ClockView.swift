//
//  ClockView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/23.
//

import SwiftUI

struct ClockView: View {
    
    @Binding var showTabBar: Bool
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                // Portrait
                VStack(spacing: 28) {
                    Group {
                        NeoRoundedRectangle(
                            cornerRadius: 20,
                            fillColor: Color.asset.background,
                            colorA: Color.asset.dialAShadowColor,
                            colorB: Color.asset.dialBShadowColor
                        )
                        NeoRoundedRectangle(
                            cornerRadius: 20,
                            fillColor: Color.asset.background,
                            colorA: Color.asset.dialAShadowColor,
                            colorB: Color.asset.dialBShadowColor
                        )
                        NeoRoundedRectangle(
                            cornerRadius: 20,
                            fillColor: Color.asset.background,
                            colorA: Color.asset.dialAShadowColor,
                            colorB: Color.asset.dialBShadowColor
                        )
                    }
                    .aspectRatio(1, contentMode: .fit)
                }
                .frame(maxWidth: .infinity)
            } else {
                // Landscape
                HStack {
                    NeoRoundedRectangle(
                        cornerRadius: 20,
                        fillColor: Color.asset.background,
                        colorA: Color.asset.dialAShadowColor,
                        colorB: Color.asset.dialBShadowColor
                    )
                    NeoRoundedRectangle(
                        cornerRadius: 20,
                        fillColor: Color.asset.background,
                        colorA: Color.asset.dialAShadowColor,
                        colorB: Color.asset.dialBShadowColor
                    )
                    NeoRoundedRectangle(
                        cornerRadius: 20,
                        fillColor: Color.asset.background,
                        colorA: Color.asset.dialAShadowColor,
                        colorB: Color.asset.dialBShadowColor
                    )
                }
            }
        }
        .padding(.vertical, 16)
        .onTapGesture {
            withAnimation {
                showTabBar.toggle()
            }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.asset.background.ignoresSafeArea()
            ClockView(showTabBar: .constant(false))
        }
    }
}
