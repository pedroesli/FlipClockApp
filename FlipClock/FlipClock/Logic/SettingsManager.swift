//
//  SettingsManager.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import SwiftUI

class SettingsManager {
    var settings = Settings() {
        didSet {
            save()
        }
    }
    private let settingsKey = "SettingsKey"
    
    init() {
        load()
    }
    
    private func save() {
        guard let data = try? JSONEncoder().encode(settings) else { return }
        UserDefaults.standard.set(data, forKey: settingsKey)
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: settingsKey) else { return }
        if let settings = try? JSONDecoder().decode(Settings.self, from: data) {
            self.settings = settings
        }
    }
}
