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
    @StateObject private var clockManager = ClockManager()
    @State private var hour = FlipTextInfo(value: "00")
    @State private var minute = FlipTextInfo(value: "00")
    @State private var seconds = FlipTextInfo(value: "00")
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(spacing: 28) {
                    Group {
                        FlipDial(info: $hour)
                        FlipDial(info: $minute)
                        if settingsManager.settings.displaySeconds {
                            FlipDial(info: $seconds)
                        }
                    }
                    .foregroundColor(settingsManager.displayColor)
                    .aspectRatio(1, contentMode: .fit)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 32)
            } else {
                // Landscape
                HStack(spacing: 28) {
                    Group {
                        FlipDial(info: $hour)
                        FlipDial(info: $minute)
                        if settingsManager.settings.displaySeconds {
                            FlipDial(info: $seconds)
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                }
                .frame(maxHeight: .infinity)
            }
        }
        .padding(.bottom, 16)
        .overlay {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.15)) {
                        showAllViews.toggle()
                    }
                }
        }
        .onAppear {
            let periodText = clockManager.time.periodText(is24HourFormat: settingsManager.settings.hourFormat.is24HourFormat)
            hour = FlipTextInfo(value: settingsManager.formatHour(from: clockManager.time), periodText: periodText)
            minute = FlipTextInfo(value: clockManager.time.formatted("mm"))
            seconds = FlipTextInfo(value: clockManager.time.formatted("ss"))
        }
        .onChange(of: clockManager.time) { newValue in
            let periodText = newValue.periodText(is24HourFormat: settingsManager.settings.hourFormat.is24HourFormat)
            hour = FlipTextInfo(value: settingsManager.formatHour(from: newValue), periodText: periodText)
            minute = FlipTextInfo(value: clockManager.time.formatted("mm"))
            seconds = FlipTextInfo(value: clockManager.time.formatted("ss"))
        }
        .onChange(of: settingsManager.settings.hourFormat) { newValue in
            let periodText = clockManager.time.periodText(is24HourFormat: newValue.is24HourFormat)
            hour.value = settingsManager.formatHour(from: clockManager.time)
            hour.periodText = periodText
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
