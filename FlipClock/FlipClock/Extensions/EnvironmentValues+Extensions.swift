//
//  EnvironmentValues+Extension s.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import SwiftUI

private struct SettingsManagerKey: EnvironmentKey {
    static var defaultValue: SettingsManager = SettingsManager()
}

extension EnvironmentValues {
    var settingsManager: SettingsManager {
        get { self[SettingsManagerKey.self] }
    }
}
