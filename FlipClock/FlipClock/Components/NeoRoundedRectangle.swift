//
//  NeoRoundedRectangle.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 03/08/23.
//

import SwiftUI

struct NeoRoundedRectangle: View {
    
    let cornerRadius: CGFloat
    let fillColor: Color
    let colorA: Color
    let colorB: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 26)
            .fill(
                fillColor
                    .shadow(.inner(color: colorB.opacity(0.5), radius: 1, x: -1, y: -1))
                    .shadow(.inner(color: colorA.opacity(0.3), radius: 1, x: 1, y: 1))
            )
            .shadow(color: colorB.opacity(0.9), radius: 6.5, x: 5, y: 5)
            .shadow(color: colorA.opacity(0.9), radius: 5, x: -5, y: -5)
            .shadow(color: colorB.opacity(0.2), radius: 5, x: 5, y: -5)
            .shadow(color: colorB.opacity(0.2), radius: 5, x: -5, y: 5)
    }
}

struct NeoRoundedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.asset.background.ignoresSafeArea()
            NeoRoundedRectangle(
                cornerRadius: 26,
                fillColor: Color.asset.tabBar,
                colorA: Color.asset.tabBarAShadowColor,
                colorB: Color.asset.tabBarBShadowColor
            )
            .frame(width: 100, height: 50)
        }
        
    }
}
