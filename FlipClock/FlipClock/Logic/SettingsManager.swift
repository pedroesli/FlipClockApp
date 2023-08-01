//
//  SettingsManager.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import SwiftUI

class SettingsManager: ObservableObject {
    @Published var settings = load() {
        didSet {
            save()
        }
    }
    private static let settingsKey = "SettingsKey"
    
    private func save() {
        guard let data = try? JSONEncoder().encode(settings) else { return }
        UserDefaults.standard.set(data, forKey: Self.settingsKey)
    }
    
    private static func load() -> Settings {
        guard let data = UserDefaults.standard.data(forKey: Self.settingsKey) else { return Settings() }
        guard let settings = try? JSONDecoder().decode(Settings.self, from: data) else { return Settings() }
        return settings
    }
}
