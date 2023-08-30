//
//  FlipDial.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 07/08/23.
//

import SwiftUI

struct FlipDial: View {
    
    @Binding var info: FlipTextInfo
    @State private var leftValue = FlipTextInfo(value: "")
    @State private var rightValue = FlipTextInfo(value: "")
    
    var body: some View {
        ZStack {
            NeoRoundedRectangle(configuration: .dial)
            HStack(spacing: 0) {
                if info.value.count == 1 {
                    FlipText(info: $leftValue, placement: .center)
                } else {
                    FlipText(info: $leftValue, placement: .right)
                    FlipText(info: $rightValue, placement: .left)
                }
            }
        }
        .overlay {
            Asset.Colors.background.swiftUIColor.frame(height: 3)
        }
        .onAppear {
            updateValues(from: info)
        }
        .onChange(of: info) { newValue in
            updateValues(from: newValue)
        }
    }
    
    func updateValues(from info: FlipTextInfo) {
        guard let left = info.value.first else { return }
        leftValue.value = String(left)
        leftValue.periodText = info.periodText
        if let right = info.value.last {
            rightValue.value = String(right)
        }
    }
}

struct FlipDial_Previews: PreviewProvider {
    static var previews: some View {
        FlipDial(info: .constant(FlipTextInfo(value: "12", periodText: "PM")))
            .aspectRatio(1, contentMode: .fit)
            .padding(32)
    }
}
