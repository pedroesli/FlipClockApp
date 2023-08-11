//
//  StopWatchView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/23.
//

import SwiftUI

struct StopWatchView: View {
    
    @Binding var showAllViews: Bool
    @EnvironmentObject private var settingsManager: SettingsManager
    @EnvironmentObject private var stopWatchManager: StopWatchManager
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(spacing: 28) {
                    ZStack {
                        VStack(spacing: 20) {
                            Group {
                                FlipDial(info: $stopWatchManager.hour)
                                FlipDial(info: $stopWatchManager.minute)
                            }
                            .foregroundColor(settingsManager.displayColor)
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            FlipDial(info: $stopWatchManager.second)
                                .foregroundColor(settingsManager.displayColor)
                                .aspectRatio(1, contentMode: .fit)
                                .frame(maxWidth: .infinity)
                                .overlay {
                                    HStack(spacing: 0) {
                                        Color.clear
                                        Color.clear
                                            .aspectRatio(1, contentMode: .fit)
                                            .layoutPriority(4)
                                        Color.clear
                                            .overlay {
                                                NeoRoundedRectangle(configuration: .milisecondDial)
                                                    .scaledToFit()
                                                    .overlay {
                                                        GeometryReader { geometry in
                                                            let fontSize = (geometry.size.height / 2) * 1.5
                                                            Text(stopWatchManager.milisecond)
                                                                .font(.system(size: fontSize, weight: .bold))
                                                                .fontWidth(.compressed)
                                                                .monospacedDigit()
                                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        }
                                                    }
                                                    .padding(.leading, 16)
                                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                            }
                                    }
                                }
                        }
                        .onOverlayTap {
                            showAllViews.toggle()
                        }
                    }
                    HStack {
                        CapsuleButton(title: "Reset", action: stopWatchManager.onResetPressed)
                        .tint(.primary)
                        .disabled(stopWatchManager.state == .start)
                        Spacer()
                        CapsuleButton(title: stopWatchManager.state.rawValue, action: stopWatchManager.onControlPressed)
                            .tint(stopWatchManager.state == .stop ? .red : .green)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 19)
            } else {
                // Landscape
                HStack(spacing: 28) {
                    Group {
                        FlipDial(info: $stopWatchManager.hour)
                        FlipDial(info: $stopWatchManager.minute)
                        FlipDial(info: $stopWatchManager.second)
                    }
                    .foregroundColor(settingsManager.displayColor)
                    .aspectRatio(1, contentMode: .fit)
                }
                .frame(maxHeight: .infinity)
            }
        }
        .padding(.bottom, 16)
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.asset.background.ignoresSafeArea()
            StopWatchView(showAllViews: .constant(false))
                .environmentObject(SettingsManager())
                .environmentObject(StopWatchManager())
        }
    }
}
