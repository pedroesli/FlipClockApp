//
//  ContentView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 21/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var settingsManager = SettingsManager()
    @StateObject private var clockManager = ClockManager()
    @StateObject private var stopWatchManager = StopWatchManager()
    @StateObject private var timerManager = TimerManager()
    @State private var selectedViewOption: ViewOption = .clock
    @State private var showAllViews = false
    
    var body: some View {
        Group {
            #if os(iOS)
                if UIDevice.current.userInterfaceIdiom == .phone {
                    StackView(showAllViews: $showAllViews, selectedViewOption: $selectedViewOption) {
                        if selectedViewOption == .clock {
                            ClockView(showAllViews: $showAllViews)
                                .environmentObject(clockManager)
                        } else if selectedViewOption == .stopwatch {
                            StopWatchView(showAllViews: $showAllViews)
                                .environmentObject(stopWatchManager)
                        } else {
                            TimerView(showAllViews: $showAllViews)
                                .environmentObject(timerManager)
                        }
                    }
                } else {
                    splitView()
                }
            #else
                splitView()
            #endif
        }
        .onAppear {
            clockManager.onAppear(settingsManager: settingsManager)
        }
        .tint(settingsManager.appColor)
        .environmentObject(settingsManager)
    }
    
    @ViewBuilder
    func splitView() -> some View {
        SplitView(showSplitView: $showAllViews, selectedViewOption: $selectedViewOption) {
            if selectedViewOption == .clock {
                ClockView(showAllViews: $showAllViews)
                    .environmentObject(clockManager)
            } else if selectedViewOption == .stopwatch {
                StopWatchView(showAllViews: $showAllViews)
                    .environmentObject(stopWatchManager)
            } else if selectedViewOption == .timer {
                TimerView(showAllViews: $showAllViews)
                    .environmentObject(timerManager)
            } else {
                ConfigurationView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
