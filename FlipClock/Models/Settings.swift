//
//  Settings.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import SwiftUI

struct Settings: Codable {
    var hourFormat: HourFormat = .system
    var displayColorInfo: ColorInfo = .baseColorInfo
    var displaySeconds: Bool = true
    var appColorInfo: ColorInfo = .baseColorInfo
}
