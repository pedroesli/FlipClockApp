//
//  ClockView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/23.
//

import SwiftUI

struct ClockView: View {
    
    @Binding var showAllViews: Bool
    @EnvironmentObject private var settingsManager: SettingsManager
    @EnvironmentObject private var clockManager: ClockManager
    
    var body: some View {
        VStack(spacing: 28) {
            Group {
                FlipDial(info: $clockManager.hour)
                FlipDial(info: $clockManager.minute)
                if settingsManager.settings.displaySeconds {
                    FlipDial(info: $clockManager.second)
                }
            }
            .foregroundColor(settingsManager.displayColor)
            .aspectRatio(1, contentMode: .fit)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 19)
        .padding(.bottom, 16)
        .onOverlayTap {
            showAllViews.toggle()
        }
        .onChange(of: settingsManager.settings.hourFormat) { newValue in
            clockManager.onHourFormatChange(newValue)
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.asset.background.ignoresSafeArea()
            ClockView(showAllViews: .constant(false))
                .environmentObject(SettingsManager())
                .environmentObject(ClockManager())
        }
    }
}
