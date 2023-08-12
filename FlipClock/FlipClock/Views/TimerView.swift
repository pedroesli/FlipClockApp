//
//  TimerView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 11/08/23.
//

import SwiftUI

struct TimerView: View {
    
    @Binding var showAllViews: Bool
    @EnvironmentObject private var settingsManager: SettingsManager
    @EnvironmentObject private var timerManager: TimerManager
    
    var body: some View {
        VStack(spacing: 28) {
            ZStack {
                VStack(spacing: 20) {
                    Group {
                        FlipDial(info: $timerManager.hour)
                        FlipDial(info: $timerManager.minute)
                        FlipDial(info: $timerManager.second)
                    }
                    .foregroundColor(settingsManager.displayColor)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: .infinity)
                }
                .onOverlayTap {
                    showAllViews.toggle()
                }
            }
            HStack {
                CapsuleButton(title: "Reset", action: timerManager.onResetPressed)
                    .tint(.primary)
                    .disabled(timerManager.state == .start)
                Spacer()
                CapsuleButton(title: timerManager.state.rawValue, action: timerManager.onControlPressed)
                    .tint(timerManager.state == .pause ? .yellow : .green)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 19)
        .padding(.bottom, 16)
        .onAppear {
            timerManager.timerInfo = TimerInfo(hour: 0, minute: 2, second: 1)
            timerManager.minute.value = "02"
            timerManager.second.value = "01"
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.asset.background.ignoresSafeArea()
            TimerView(showAllViews: .constant(false))
                .environmentObject(SettingsManager())
                .environmentObject(TimerManager())
        }
    }
}
