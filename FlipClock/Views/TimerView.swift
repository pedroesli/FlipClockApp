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
                .opacity(timerManager.state == .start ? 0 : 1)
                Group {
                    Asset.Colors.background.swiftUIColor
                        .onOverlayTap {
                            showAllViews.toggle()
                        }
                    TimePicker(
                        hour: $timerManager.hourPicker,
                        minute: $timerManager.minutePicker,
                        second: $timerManager.secondPicker
                    )
                    .onChange(of: timerManager.hourPicker, perform: timerManager.updateHourInfo(_:))
                    .onChange(of: timerManager.minutePicker, perform: timerManager.updateMinuteInfo(_:))
                    .onChange(of: timerManager.secondPicker, perform: timerManager.updateSecondInfo(_:))
                }
                .opacity(timerManager.state != .start ? 0 : 1)
            }
            HStack {
                CapsuleButton(title: Localization.Timer.cancel, action: timerManager.onResetPressed)
                    .tint(.primary)
                    .disabled(timerManager.state == .start)
                Spacer()
                CapsuleButton(title: timerManager.state.title, action: timerManager.onControlPressed)
                    .tint(timerManager.state == .pause ? .yellow : .green)
                    .disabled(timerManager.timerInfo.isComplete)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 19)
        .padding(.bottom, 16)
        .onAppear(perform: timerManager.requestAuthorization)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Asset.Colors.background.swiftUIColor.ignoresSafeArea()
            TimerView(showAllViews: .constant(false))
                .environmentObject(SettingsManager())
                .environmentObject(TimerManager())
        }
    }
}
