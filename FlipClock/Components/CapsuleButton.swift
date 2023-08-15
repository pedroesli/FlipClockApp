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
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: 91, maxHeight: 44)
        }
        .background {
            Capsule()
                .fill(
                    Color.asset.background
                        .shadow(.inner(color: Color.asset.dialBShadowColor.opacity(0.5), radius: 1, x: -1, y: -1))
                        .shadow(.inner(color: Color.asset.dialAShadowColor.opacity(0.3), radius: 1, x: 1, y: 1))
                )
                .shadow(color: Color.asset.dialBShadowColor.opacity(0.9), radius: 6.5, x: 5, y: 5)
                .shadow(color: Color.asset.dialAShadowColor.opacity(0.9), radius: 5, x: -5, y: -5)
                .shadow(color: Color.asset.dialBShadowColor.opacity(0.2), radius: 5, x: 5, y: -5)
                .shadow(color: Color.asset.dialBShadowColor.opacity(0.2), radius: 5, x: -5, y: 5)
        }
        .contentShape(Capsule())
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.asset.background.ignoresSafeArea()
            CapsuleButton(title: "Reset") { }
        }
    }
}
