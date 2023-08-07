//
//  FlipTextHalf.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI

struct FlipTextHalf: View {
    
    let character: Character
    let fontSize: CGFloat
    let placement: FlipPlacement
    let alignment: Alignment
    @State private var size: CGSize = .zero
    
    var body: some View {
        Text(String(character))
            .font(.system(size: fontSize, weight: .bold).width(.compressed).monospacedDigit())
        .overlay {
            GeometryReader { geometry in
                Text(String(character))
                    .foregroundColor(.clear)
                    .onAppear {
                        size = geometry.size
                    }
            }
        }
        .frame(height: size.height / 2, alignment: placement.alignment)
        .clipped()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
        .background(Color.asset.background, in: RoundedRectangle(cornerRadius: 20))
    }
}

struct FlipTextHalf_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack(spacing: 0) {
                FlipTextHalf(character: "9", fontSize: 150, placement: .top, alignment: .bottomTrailing)
                FlipTextHalf(character: "9", fontSize: 150, placement: .bottom, alignment: .topTrailing)
            }
            VStack(spacing: 0) {
                FlipTextHalf(character: "5", fontSize: 150, placement: .top, alignment: .bottomLeading)
                FlipTextHalf(character: "5", fontSize: 150, placement: .bottom, alignment: .topLeading)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay {
            Color.asset.background.frame(height: 4)
//                .offset(y: -5)
        }
    }
}
