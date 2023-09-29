//
//  capsuleButtonShapeModifier.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/09/23.
//

import SwiftUI

struct CapsuleButtonShapeModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(macOS 14, iOS 15, *) {
            content
                .buttonBorderShape(.capsule)
        } else {
            content
                .buttonBorderShape(.roundedRectangle)
        }
    }
}
