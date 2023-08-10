//
//  ContentView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 21/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var settingsManager = SettingsManager()
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
                        ClockView(showAllViews: $showAllViews)
                        TabBar(selectedTabOption: $selectedTabOption)
                            .offset(y: showAllViews ? 0 : geometry.safeAreaInsets.bottom * 2)
                            .frame(height: showAllViews ? nil : 0)
                    }
                }
            }
            .navigationDestination(isPresented: $showSettingsView) {
                ConfigurationView()
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
