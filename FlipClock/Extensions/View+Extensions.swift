//
//  View+Extensions.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/23.
//

import SwiftUI

extension View {
    func onOverlayTap(action: @escaping () -> Void) -> some View {
        modifier(OverlayTap(action: action))
    }
    
    func capsuleButtonShape() -> some View {
        modifier(CapsuleButtonShapeModifier())
    }
}
