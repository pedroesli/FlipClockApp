//
//  Settings.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import SwiftUI

struct AppSettings: Codable {
    var hourFormat: HourFormat = .system
    var displayColor: ColorInfo = .baseColorInfo
    var displaySeconds: Bool = true
    var tintColor: ColorInfo = .baseColorInfo
}
