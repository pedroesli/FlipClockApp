//
//  Color+Extensions.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 03/08/23.
//

import SwiftUI

struct AssetColors {
    let background = Color("BackgroundColor")
    let tabBar = Color("TabBarColor")
    let tabBarAShadowColor = Color("TabBarAShadowColor")
    let tabBarBShadowColor = Color("TabBarBShadowColor")
}

extension Color {
    static let asset = AssetColors()
}
