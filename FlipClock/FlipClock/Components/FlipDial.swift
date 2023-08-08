//
//  FlipDial.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 07/08/23.
//

import SwiftUI

struct FlipDial: View {
    
    @Binding var value: String
    @Binding var hourFormat: HourFormat
    @State private var leftValue: Character = " "
    @State private var rightValue: Character = " "
    
    var body: some View {
        ZStack {
            NeoRoundedRectangle(configuration: .dial)
            HStack(spacing: 0) {
                if value.count == 1 {
                    FlipText(value: $leftValue, placement: .center)
                } else {
                    FlipText(value: $leftValue, placement: .right)
                    FlipText(value: $rightValue, placement: .left)
                }
            }
        }
        .onAppear {
            updateValues(from: value)
        }
        .onChange(of: value) { newValue in
            updateValues(from: newValue)
        }
    }
    
    func updateValues(from value: String) {
        guard let left = value.first else { return }
        leftValue = left
        if let right = value.last {
            rightValue = right
        }
    }
}

struct FlipDial_Previews: PreviewProvider {
    static var previews: some View {
        FlipDial(value: .constant("00"), hourFormat: .constant(.military))
            .aspectRatio(1, contentMode: .fit)
            .padding(32)
    }
}
