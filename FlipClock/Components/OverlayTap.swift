//
//  OverlayTap.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/23.
//

import SwiftUI

struct OverlayTap: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .overlay {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.15)) {
                            action()
                        }
                    }
            }
    }
}
