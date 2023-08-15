//
//  AssetColor.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import SwiftUI

enum PaletteColor: String, Codable {
    case base = "BaseColor"
    case lime = "LimeColor"
    case pink = "PinkColor"
    case violet = "VioletColor"
    case purple = "PurpleColor"
    case bluegray = "BlueGrayColor"
    case celadon = "CeladonColor"
    
    var color: Color {
        Color(self.rawValue)
    }
}
