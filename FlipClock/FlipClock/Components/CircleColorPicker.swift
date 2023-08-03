//
//  CircleColorPicker.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 02/08/23.
//

import SwiftUI

struct CircleColorPicker: View {
    
    @Binding var isSelected: Bool
    let action: (_ red: Double, _ green: Double, _ blue: Double) -> Void
    let fillGradient = AngularGradient(
        gradient: Gradient(colors: [.red,.yellow,.green,.blue,.purple,.pink]),
        center: .center
    )
    
    @State private var pickedColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    
    var body: some View {
        ZStack {
            ColorPicker("", selection: $pickedColor, supportsOpacity: false).labelsHidden()
            Circle()
                .fill(fillGradient)
                .overlay {
                    Image(systemName: "eyedropper")
                        .foregroundColor(.white)
                }
                .padding(5)
                .allowsHitTesting(false)
            if isSelected {
                Circle()
                    .stroke(lineWidth: 3)
                    .fill(fillGradient)
            }
        }
        .frame(width: 50, height: 50)
        .onChange(of: pickedColor) { newValue in
            guard let components = newValue.components, !components.isEmpty else { return }
            let red = components[0]
            let green = components[1]
            let blue = components[2]
            isSelected = true
            action(red, green, blue)
        }
    }
}

struct CircleColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        CircleColorPicker(isSelected: .constant(true)) { _, _, _ in
            
        }
    }
}
