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
    @State private var showTabBar = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.asset.background.ignoresSafeArea()
                GeometryReader { geometry in
                    VStack {
                        navBar(safeAreaInsets: geometry.safeAreaInsets)
                        ClockView(showTabBar: $showTabBar)
                        RoundTabBar(selectedTabOption: $selectedTabOption)
                            .offset(y: showTabBar ? 0 : geometry.safeAreaInsets.bottom * 2)
                            .frame(height: showTabBar ? nil : 0)
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
    
    func navBar(safeAreaInsets: EdgeInsets) -> some View {
        Color.clear
            .frame(height: showTabBar ? safeAreaInsets.top : 0)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    showSettingsView = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(settingsManager.appColor)
                        .font(.title2)
                        .padding(.vertical, 9)
                        .padding(.horizontal, 16)
                }
            }
            .offset(y: showTabBar ? 0 : -safeAreaInsets.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
