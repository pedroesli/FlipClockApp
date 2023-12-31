//
//  RoundTabBar.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 02/08/23.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTabOption: ViewOption
    
    var body: some View {
        ZStack {
            NeoRoundedRectangle(configuration: .tabBar)
            HStack(spacing: 8) {
                BarItem(selectedTabOption: $selectedTabOption, tabOption: .clock)
                BarItem(selectedTabOption: $selectedTabOption, tabOption: .stopwatch)
                BarItem(selectedTabOption: $selectedTabOption, tabOption: .timer)
            }
        }
        .padding(.horizontal, 19)
        .frame(height: 62)
    }
    
    struct BarItem: View {
        
        @Binding var selectedTabOption: ViewOption
        let tabOption: ViewOption
        
        @EnvironmentObject private var settingsManager: SettingsManager
        var isSelected: Bool {
            selectedTabOption == tabOption
        }
        
        var body: some View {
            Button {
                selectedTabOption = tabOption
            } label: {
                Image(systemName: tabOption.imageName)
                    .foregroundColor(isSelected ? settingsManager.appColor : .gray)
                    .frame(width: 75)
                    .frame(maxHeight: .infinity)
            }
        }
    }
}

struct RoundTabBar_Previews: PreviewProvider {
    
    @StateObject static var settingsManager = SettingsManager()
    
    static var previews: some View {
        ZStack {
            Asset.Colors.background.swiftUIColor.ignoresSafeArea()
            TabBar(selectedTabOption: .constant(.clock))
                .environmentObject(settingsManager)
                .onAppear {
                    settingsManager.settings.appColorInfo = .init(assetColor: .pink)
                }
        }
    }
}
