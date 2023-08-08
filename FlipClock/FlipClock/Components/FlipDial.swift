//
//  FlipDial.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 07/08/23.
//

import SwiftUI

struct FlipDial: View {
    
    @State var value: String = "00"
    @State private var leftValue: Character = " "
    @State private var rightValue: Character = " "
    
    var body: some View {
        ZStack {
            NeoRoundedRectangle(configuration: .dial)
            HStack(spacing: 0) {
                FlipText(value: $leftValue, placement: .right)
                FlipText(value: $rightValue, placement: .left)
            }
            .padding(10)
        }
        .onAppear {
            updateValues(from: value)
        }
        .onChange(of: value) { newValue in
            updateValues(from: newValue)
        }
        .onTapGesture {
            // For testing
            let nextValue = (Int(value) ?? 0) + 1
            var stringValue = String(nextValue)
            if stringValue.count == 1 {
                stringValue.insert("0", at: stringValue.startIndex)
            }
            value = stringValue
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
        FlipDial()
            .padding(32)
    }
}
