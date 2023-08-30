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
        gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .pink]),
        center: .center
    )
    @StateObject private var manager = CircleColorPickerManager()
    
    var body: some View {
        ZStack {
            #if os(iOS)
            ColorPicker("", selection: $manager.pickedColor, supportsOpacity: false).labelsHidden()
            #endif
            Circle()
                .fill(fillGradient)
                .overlay {
                    Image(systemName: "eyedropper")
                        .foregroundColor(.white)
                }
                .padding(5)
                .allowsHitTesting(manager.allowHitTesting)
            if isSelected {
                Circle()
                    .stroke(lineWidth: 3)
                    .fill(fillGradient)
                    .allowsHitTesting(manager.allowHitTesting)
            }
        }
        .frame(width: 50, height: 50)
        #if os(macOS)
        .onTapGesture {
            manager.showColorPanel()
        }
        .onAppear {
            manager.createNotification()
        }
        .onDisappear {
            manager.removeNotification()
        }
        #endif
        .onChange(of: manager.pickedColor) { newValue in
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
        .frame(width: 500, height: 500)
    }
}
