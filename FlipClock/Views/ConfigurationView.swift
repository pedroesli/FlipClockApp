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
            Section(Localization.Configuration.Section.TimeDisplay.title) {
                Picker(Localization.Configuration.Picker.HourFormat.title, selection: $settingsManager.settings.hourFormat) {
                    Text(Localization.Configuration.Picker.System.text).tag(HourFormat.system)
                    Text(Localization.Configuration.Picker.Military.text).tag(HourFormat.military)
                    Text(Localization.Configuration.Picker.TwoPeriods.text).tag(HourFormat.twoPeriods)
                }
                Toggle(Localization.Configuration.Toggle.DisplaySeconds.title, isOn: $settingsManager.settings.displaySeconds)
                    .tint(toggleTint)
                ColorInfoSelector(
                    title: Localization.Configuration.ColorInfoSelector.DialTextColor.title,
                    selectedColorInfo: $settingsManager.settings.displayColorInfo
                )
            }
            Section(Localization.Configuration.Section.App.title) {
                ColorInfoSelector(
                    title: Localization.Configuration.ColorInfoSelector.TintColor.title,
                    selectedColorInfo: $settingsManager.settings.appColorInfo
                )
            }
            Section(Localization.Configuration.Section.Support.title) {
                Button {
                    settingsManager.requestReviewManually()
                } label: {
                    Label {
                        Text(Localization.Configuration.Button.Review.text)
                    } icon: {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .foregroundColor(settingsManager.appColor)
                    }
                }
            }
            Section(Localization.Configuration.Section.General.title) {
                Button(Localization.Configuration.Button.DefaultSettings.text) {
                    showSettingsResetAlert = true
                }
            }
            Section {
                Text(Localization.Configuration.Text.madeBy)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .listRowBackground(EmptyView())
            }
        }
        .formStyle(.grouped)
        .foregroundColor(.primary)
        .navigationTitle(Localization.Configuration.title)
        .confirmationDialog(Localization.Configuration.ConfirmationDialog.text, isPresented: $showSettingsResetAlert) {
            Button(Localization.Configuration.Button.Reset.text, role: .destructive) {
                settingsManager.resetSettings()
            }
        } message: {
            Text(Localization.Configuration.Text.reset)
        }
        #if os(macOS)
        .scrollContentBackground(.hidden)
        #endif
    }
}

struct ConfigurationView_Previews: PreviewProvider {
    
    @StateObject private static var settingsManager = SettingsManager()
    
    static var previews: some View {
        NavigationStack {
            #if os(iOS)
            ConfigurationView()
                .navigationBarTitleDisplayMode(.inline)
            #else
            ConfigurationView()
            #endif
        }
        .environmentObject(settingsManager)
    }
}
