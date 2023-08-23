//
//  FlipTextHalf.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI
import CornerRoundedRectangle

struct FlipTextHalf: View {
    
    @Binding var value: String
    let placement: FlipTextHalfPlacement
    let alignment: Alignment
    @State private var size: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let fontSize = (geometry.size.height + geometry.size.height / 2) * 1.1
                CornerRoundedRectangle(cornerRadius: 20, edges: placement.corners)
                    .fill(Asset.Colors.background.swiftUIColor)
                    .padding(padding(alignment: alignment), 10)
                Text(value)
                    .font(.system(size: fontSize, weight: .bold, design: .default).width(.compressed).monospacedDigit())
                .overlay {
                    GeometryReader { geometry in
                        Color.clear
                            .foregroundColor(.clear)
                            .onAppear {
                                size = geometry.size
                            }
                            .onChange(of: geometry.size) { newValue in
                                size = newValue
                            }
                    }
                }
                .frame(height: size.height / 2, alignment: placement.alignment)
                .clipped()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
            }
        }
    }
    
    func padding(alignment: Alignment) -> Edge.Set {
        switch alignment {
        case .topTrailing: return [.bottom, .leading]
        case .topLeading: return [.bottom, .trailing]
        case .bottomTrailing: return [.top, .leading]
        case .bottomLeading: return [.top, .trailing]
        default: return [.top, .bottom]
        }
    }
}

struct FlipTextHalf_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            NeoRoundedRectangle(configuration: .dial)
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    FlipTextHalf(value: .constant("9"), placement: .top, alignment: .bottomTrailing)
                    FlipTextHalf(value: .constant("9"), placement: .bottom, alignment: .topTrailing)
                }
                VStack(spacing: 0) {
                    FlipTextHalf(value: .constant("5"), placement: .top, alignment: .bottomLeading)
                    FlipTextHalf(value: .constant("5"), placement: .bottom, alignment: .topLeading)
                }
            }
            .overlay {
                Asset.Colors.background.swiftUIColor.frame(height: 4)
            }
        }
        .padding()
        .aspectRatio(1, contentMode: .fit)
    }
}
