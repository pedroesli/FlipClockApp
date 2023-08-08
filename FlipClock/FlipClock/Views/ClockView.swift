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
    @State private var hour = "00"
    @State private var minute = "00"
    @State private var seconds = "00"
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(spacing: 28) {
                    Group {
                        FlipDial(value: $hour, hourFormat: $settingsManager.settings.hourFormat)
                        FlipDial(value: $minute, hourFormat: $settingsManager.settings.hourFormat)
                        if settingsManager.settings.displaySeconds {
                            FlipDial(value: $seconds, hourFormat: $settingsManager.settings.hourFormat)
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
                        FlipDial(value: .constant("00"), hourFormat: $settingsManager.settings.hourFormat)
                        FlipDial(value: .constant("00"), hourFormat: $settingsManager.settings.hourFormat)
                        if settingsManager.settings.displaySeconds {
                            FlipDial(value: .constant("00"), hourFormat: $settingsManager.settings.hourFormat)
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
            hour = settingsManager.formatHour(from: clockManager.time)
            minute = clockManager.time.formatted("mm")
            seconds = clockManager.time.formatted("ss")
        }
        .onChange(of: clockManager.time) { newValue in
            hour = settingsManager.formatHour(from: newValue)
            minute = newValue.formatted("mm")
            seconds = newValue.formatted("ss")
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
