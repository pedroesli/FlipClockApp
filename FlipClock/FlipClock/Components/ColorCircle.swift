//
//  ColorCircle.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 02/08/23.
//

import SwiftUI

struct ColorCircle: View {
    
    @Binding var selectedAssetColor: PaletteColor?
    var assetColor: PaletteColor
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Button {
                selectedAssetColor = assetColor
                action()
            } label: {
                Circle()
                    .fill(assetColor.color)
                    .padding(5)
            }

            if let selectedAssetColor, selectedAssetColor == assetColor {
                Circle()
                    .stroke(lineWidth: 3)
                    .fill(assetColor.color)
            }
        }
        .frame(width: 50, height: 50)
    }
}

struct ColorCircle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCircle(selectedAssetColor: .constant(.pink), assetColor: .pink, action: {})
    }
}
