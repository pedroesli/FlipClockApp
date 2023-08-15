//
//  ConfigurationView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 02/08/23.
//

import SwiftUI
import StoreKit

struct ConfigurationView: View {
    
    @EnvironmentObject var settingsManager: SettingsManager
    @Environment(\.requestReview) private var requestReview
    @State private var showSettingsResetAlert = false
    
    var toggleTint: Color {
        guard let paletteColor = settingsManager.settings.appColorInfo.assetColor,
              paletteColor != .base else {
            return Color.green
        }
        return paletteColor.color
    }
    
    var body: some View {
        Form {
            Section("Time Display") {
                Picker("Hour format", selection: $settingsManager.settings.hourFormat) {
                    Text("System").tag(HourFormat.system)
                    Text("24 hours").tag(HourFormat.military)
                    Text("12 hours").tag(HourFormat.twoPeriods)
                }
                Toggle("Display Seconds", isOn: $settingsManager.settings.displaySeconds)
                    .tint(toggleTint)
                ColorInfoSelector(title: "Display color", selectedColorInfo: $settingsManager.settings.displayColorInfo)
            }
            Section("App") {
                ColorInfoSelector(title: "Tint color", selectedColorInfo: $settingsManager.settings.appColorInfo)
            }
            Section("Support") {
                Button {
                    requestReview()
                } label: {
                    Label {
                        Text("Review FlipNeo Clock")
                            .foregroundColor(.primary)
                    } icon: {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .foregroundColor(.indigo)
                    }
                }
            }
            Section("General") {
                Button("Default settings") {
                    showSettingsResetAlert = true
                }
            }
            Section {
                Text("Made with ❤️☕️ by Pedro Ésli")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .listRowBackground(EmptyView())
            }
        }
        .foregroundColor(.primary)
        .navigationTitle("Configuration")
        .confirmationDialog("Are you sure you want to reset to the default settings?", isPresented: $showSettingsResetAlert) {
            Button("Reset", role: .destructive) {
                settingsManager.resetSettings()
            }
        } message: {
            Text("Reset to default settings")
        }
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    
    @StateObject private static var settingsManager = SettingsManager()
    
    static var previews: some View {
        NavigationStack {
            ConfigurationView()
                .navigationBarTitleDisplayMode(.inline)
                .environmentObject(settingsManager)
        }
    }
}
