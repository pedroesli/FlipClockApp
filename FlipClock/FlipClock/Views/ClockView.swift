//
//  ClockView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/23.
//

import SwiftUI

struct ClockView: View {
    
    @Binding var showAllViews: Bool
    
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Landscape
                HStack(spacing: 28) {
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .padding(.bottom, 16)
        .overlay {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.15)) {
                        showAllViews.toggle()
                    }
                }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.asset.background.ignoresSafeArea()
            ClockView(showAllViews: .constant(false))
        }
    }
}
