//
//  AssetColor.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import SwiftUI

enum PaletteColor: Codable {
    case base
    case lime
    case pink
    case violet
    case purple
    case bluegray
    case celadon
    
    var color: Color {
        switch self {
        case .base: return Asset.Colors.base.swiftUIColor
        case .lime: return Asset.Colors.Palette.lime.swiftUIColor
        case .pink: return Asset.Colors.Palette.pink.swiftUIColor
        case .violet: return Asset.Colors.Palette.violet.swiftUIColor
        case .purple: return Asset.Colors.Palette.purple.swiftUIColor
        case .bluegray: return Asset.Colors.Palette.blueGray.swiftUIColor
        case .celadon: return Asset.Colors.Palette.celadon.swiftUIColor
        }
    }
}
