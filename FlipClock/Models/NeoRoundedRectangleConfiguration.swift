//
//  NeoRoundedRectangleConfiguration.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI

struct NeoRoundedRectangleConfiguration {
    let cornerRadius: CGFloat
    let fillColor: Color
    let colorA: Color
    let colorB: Color
}

extension NeoRoundedRectangleConfiguration {
    static let dial = NeoRoundedRectangleConfiguration(
        cornerRadius: 20,
        fillColor: Asset.Colors.background.swiftUIColor,
        colorA: Asset.Colors.dialShadowA.swiftUIColor,
        colorB: Asset.Colors.dialShadowB.swiftUIColor
    )
    
    static let tabBar = NeoRoundedRectangleConfiguration(
        cornerRadius: 26,
        fillColor: Asset.Colors.tabBar.swiftUIColor,
        colorA: Asset.Colors.tabBarShadowA.swiftUIColor,
        colorB: Asset.Colors.tabBarShadowB.swiftUIColor
    )
    
    static let milisecondDial = NeoRoundedRectangleConfiguration(
        cornerRadius: 8,
        fillColor: Asset.Colors.background.swiftUIColor,
        colorA: Asset.Colors.dialShadowA.swiftUIColor,
        colorB: Asset.Colors.dialShadowB.swiftUIColor
    )
}
