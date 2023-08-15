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
        fillColor: Color.asset.background,
        colorA: Color.asset.dialAShadowColor,
        colorB: Color.asset.dialBShadowColor
    )
    
    static let tabBar = NeoRoundedRectangleConfiguration(
        cornerRadius: 26,
        fillColor: Color.asset.tabBar,
        colorA: Color.asset.tabBarAShadowColor,
        colorB: Color.asset.tabBarBShadowColor
    )
    
    static let milisecondDial = NeoRoundedRectangleConfiguration(
        cornerRadius: 8,
        fillColor: Color.asset.background,
        colorA: Color.asset.dialAShadowColor,
        colorB: Color.asset.dialBShadowColor
    )
}
