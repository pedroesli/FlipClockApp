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
    
    var body: some View {
        NavigationStack {
            Color.green
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showSettingsView = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                }
                .toolbar(.hidden, for: .navigationBar)
                .navigationDestination(isPresented: $showSettingsView) {
                    ConfigurationView()
                }
        }
        .environmentObject(settingsManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
