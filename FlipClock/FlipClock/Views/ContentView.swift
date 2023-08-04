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
    @State private var navigationBarHeight: CGFloat = .zero
    
    var showToolBar: Visibility {
        showTabBar ? .visible : .hidden
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.asset.background.ignoresSafeArea()
                VStack {
                    ClockView(showTabBar: $showTabBar)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    showSettingsView = true
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .foregroundColor(settingsManager.appColor)
                                }
                            }
                        }
                        .toolbar(showToolBar, for: .navigationBar)
                        .navigationDestination(isPresented: $showSettingsView) {
                            ConfigurationView()
                        }
                }
                VStack(spacing: 0) {
                    RoundTabBar(selectedTabOption: $selectedTabOption)
                        .offset(y: showTabBar ? 0 : 100)
                        .frame(height: showTabBar ? nil : 0)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .tint(settingsManager.appColor)
        .environmentObject(settingsManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
