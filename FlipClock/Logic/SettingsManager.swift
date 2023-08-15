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
    var appColor: Color {
        settings.appColorInfo.color
    }
    var displayColor: Color {
        settings.displayColorInfo.color
    }
    private static let settingsKey = "SettingsKey"
    
    func formatHour(from date: Date) -> String {
        return settings.hourFormat.formatHour(from: date)
    }
    
    func resetSettings() {
        settings = Settings()
    }
    
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
