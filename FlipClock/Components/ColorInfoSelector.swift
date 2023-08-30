//
//  ColorInfoSelector.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 02/08/23.
//

import SwiftUI

struct ColorInfoSelector: View {
    
    let title: String
    @Binding var selectedColorInfo: ColorInfo
    @State private var selectedAssetColor: PaletteColor?
    @State private var isColorPickerSelected = false
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: "circle.fill")
                    .foregroundColor(selectedColorInfo.color)
            }
            Grid {
                GridRow {
                    ColorCircle(selectedAssetColor: $selectedAssetColor, assetColor: .base, action: colorCirclePressed)
                    Spacer()
                    ColorCircle(selectedAssetColor: $selectedAssetColor, assetColor: .celadon, action: colorCirclePressed)
                    Spacer()
                    ColorCircle(selectedAssetColor: $selectedAssetColor, assetColor: .lime, action: colorCirclePressed)
                    Spacer()
                    ColorCircle(selectedAssetColor: $selectedAssetColor, assetColor: .pink, action: colorCirclePressed)
                    
                }
                GridRow {
                    ColorCircle(selectedAssetColor: $selectedAssetColor, assetColor: .violet, action: colorCirclePressed)
                    Spacer()
                    ColorCircle(selectedAssetColor: $selectedAssetColor, assetColor: .purple, action: colorCirclePressed)
                    Spacer()
                    ColorCircle(selectedAssetColor: $selectedAssetColor, assetColor: .bluegray, action: colorCirclePressed)
                    Spacer()
                    CircleColorPicker(isSelected: $isColorPickerSelected, action: selectedRGBColor(red:green:blue:))
                }
            }
        }
        .padding(.vertical, 6)
        .onAppear {
            selectedAssetColor = selectedColorInfo.assetColor
            isColorPickerSelected = !selectedColorInfo.isAssetColor
        }
        .onChange(of: selectedColorInfo) { newValue in
            guard newValue.assetColor != selectedAssetColor else { return }
            selectedAssetColor = newValue.assetColor
        }
        .buttonStyle(.plain)
    }
    
    func colorCirclePressed() {
        guard let selectedAssetColor else { return }
        selectedColorInfo = ColorInfo(assetColor: selectedAssetColor)
        isColorPickerSelected = false
    }
    
    func selectedRGBColor(red: Double, green: Double, blue: Double) {
        selectedAssetColor = nil
        selectedColorInfo = ColorInfo(red: red, green: green, blue: blue)
    }
}

struct ColorInfoSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorInfoSelector(title: "Display color", selectedColorInfo: .constant(.baseColorInfo))
    }
}
