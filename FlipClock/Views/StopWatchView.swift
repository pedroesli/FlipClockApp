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
                                        milisecondSmallDisplay()
                                    }
                            }
                        }
                }
                .onOverlayTap {
                    showAllViews.toggle()
                }
            }
            HStack {
                CapsuleButton(title: Localization.StopWatch.reset, action: stopWatchManager.onResetPressed)
                    .tint(.primary)
                    .disabled(stopWatchManager.state == .start)
                Spacer()
                CapsuleButton(title: stopWatchManager.state.title, action: stopWatchManager.onControlPressed)
                    .tint(stopWatchManager.state == .stop ? .red : .green)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 19)
        .padding(.bottom, 16)
    }
    
    func milisecondSmallDisplay() -> some View {
        NeoRoundedRectangle(configuration: .milisecondDial)
            .scaledToFit()
            .overlay {
                GeometryReader { geometry in
                    let fontSize = (geometry.size.height / 2) * 1.5
                    Text(stopWatchManager.milisecond)
                        .foregroundColor(settingsManager.displayColor)
                        .font(.system(size: fontSize, weight: .bold))
                        .fontWidth(.compressed)
                        .monospacedDigit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Asset.Colors.background.swiftUIColor.ignoresSafeArea()
            StopWatchView(showAllViews: .constant(false))
                .environmentObject(SettingsManager())
                .environmentObject(StopWatchManager())
        }
    }
}
