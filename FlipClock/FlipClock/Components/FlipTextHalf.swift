//
//  FlipTextHalf.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI
import CornerRoundedRectangle

struct FlipTextHalf: View {
    
    @Binding var value: Character
    let placement: FlipTextHalfPlacement
    let alignment: Alignment
    @State private var size: CGSize = .zero
    
    var body: some View {
        Text(String(value))
        .overlay {
            GeometryReader { geometry in
                Text(String(value))
                    .foregroundColor(.clear)
                    .onAppear {
                        size = geometry.size
                    }
            }
        }
        .frame(height: size.height / 2, alignment: placement.alignment)
        .clipped()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
        .background(Color.asset.background, in: CornerRoundedRectangle(cornerRadius: 20, edges: placement.corners))
    }
}

struct FlipTextHalf_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack(spacing: 0) {
                FlipTextHalf(value: .constant("9"), placement: .top, alignment: .bottomTrailing)
                FlipTextHalf(value: .constant("9"), placement: .bottom, alignment: .topTrailing)
            }
            VStack(spacing: 0) {
                FlipTextHalf(value: .constant("5"), placement: .top, alignment: .bottomLeading)
                FlipTextHalf(value: .constant("5"), placement: .bottom, alignment: .topLeading)
            }
        }
        .font(.system(size: 100, weight: .bold, design: .rounded).width(.compressed).monospacedDigit())
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            Color.asset.background.frame(height: 4)
//                .offset(y: -5)
        }
    }
}
