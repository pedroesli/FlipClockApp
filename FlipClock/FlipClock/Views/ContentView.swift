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
    @State private var showSettingsView = false
    @State private var selectedTabOption: TabOption = .clock
    @State private var showAllViews = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.asset.background.ignoresSafeArea()
                GeometryReader { geometry in
                    VStack {
                        NavBar(safeAreaInsets: geometry.safeAreaInsets, showNavBar: $showAllViews) {
                            onSettingsButtonPressed()
                        }
                        if selectedTabOption == .clock {
                            ClockView(showAllViews: $showAllViews)
                                .environmentObject(clockManager)
                        } else if selectedTabOption == .stopwatch {
                            StopWatchView(showAllViews: $showAllViews)
                                .environmentObject(stopWatchManager)
                        } else {
                            Color.yellow
                        }
                        TabBar(selectedTabOption: $selectedTabOption)
                            .offset(y: showAllViews ? 0 : geometry.safeAreaInsets.bottom * 2)
                            .frame(height: showAllViews ? nil : 0)
                    }
                }
            }
            .navigationDestination(isPresented: $showSettingsView) {
                ConfigurationView()
            }
            .onAppear {
                clockManager.onAppear(settingsManager: settingsManager)
            }
        }
        .tint(settingsManager.appColor)
        .environmentObject(settingsManager)
    }
    
    func onSettingsButtonPressed() {
        showSettingsView = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
