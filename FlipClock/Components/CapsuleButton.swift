//
//  CapsuleButton.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/23.
//

import SwiftUI

struct CapsuleButton: View {
    
    let title: String
    let action: () -> Void
    
    var shadowColorA: Color {
        Asset.Colors.dialShadowA.swiftUIColor
    }
    var shadowColorB: Color {
        Asset.Colors.dialShadowB.swiftUIColor
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: 91, maxHeight: 44)
        }
        .background {
            Capsule()
                .fill(
                    Asset.Colors.background.swiftUIColor
                        .shadow(.inner(color: shadowColorB.opacity(0.5), radius: 1, x: -1, y: -1))
                        .shadow(.inner(color: shadowColorA.opacity(0.3), radius: 1, x: 1, y: 1))
                )
                .shadow(color: shadowColorB.opacity(0.9), radius: 6.5, x: 5, y: 5)
                .shadow(color: shadowColorA.opacity(0.9), radius: 5, x: -5, y: -5)
                .shadow(color: shadowColorB.opacity(0.2), radius: 5, x: 5, y: -5)
                .shadow(color: shadowColorB.opacity(0.2), radius: 5, x: -5, y: 5)
        }
        .contentShape(Capsule())
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Asset.Colors.background.swiftUIColor.ignoresSafeArea()
            CapsuleButton(title: "Reset") { }
        }
    }
}
