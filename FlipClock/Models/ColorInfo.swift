//
//  ColorInfo.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import SwiftUI

struct ColorInfo: Codable, Equatable {
    
    let assetColor: PaletteColor?
    let red: Double?
    let green: Double?
    let blue: Double?
    
    init(assetColor: PaletteColor) {
        self.assetColor = assetColor
        self.red = nil
        self.green = nil
        self.blue = nil
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.assetColor = nil
    }
    
    var color: Color {
        if let assetColor {
            return assetColor.color
        }
        if let red, let green, let blue {
            return Color(red: red, green: green, blue: blue)
        }
        preconditionFailure("No information given to make a color, assetName or rgb is nil")
    }
    
    var isAssetColor: Bool {
        assetColor != nil
    }
    
    static var baseColorInfo: ColorInfo {
        ColorInfo(assetColor: .base)
    }
}
