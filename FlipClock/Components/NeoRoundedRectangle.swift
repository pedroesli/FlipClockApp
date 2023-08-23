//
//  NeoRoundedRectangle.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 03/08/23.
//

import SwiftUI

struct NeoRoundedRectangle: View {
    
    let configuration: NeoRoundedRectangleConfiguration
    
    var body: some View {
        RoundedRectangle(cornerRadius: configuration.cornerRadius)
            .fill(
                configuration.fillColor
                    .shadow(.inner(color: configuration.colorB.opacity(0.5), radius: 1, x: -1, y: -1))
                    .shadow(.inner(color: configuration.colorA.opacity(0.3), radius: 1, x: 1, y: 1))
            )
            .shadow(color: configuration.colorB.opacity(0.9), radius: 6.5, x: 5, y: 5)
            .shadow(color: configuration.colorA.opacity(0.9), radius: 5, x: -5, y: -5)
            .shadow(color: configuration.colorB.opacity(0.2), radius: 5, x: 5, y: -5)
            .shadow(color: configuration.colorB.opacity(0.2), radius: 5, x: -5, y: 5)
    }
}

struct NeoRoundedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Asset.Colors.background.swiftUIColor.ignoresSafeArea()
            NeoRoundedRectangle(configuration: .tabBar)
            .frame(width: 100, height: 50)
        }
        
    }
}
