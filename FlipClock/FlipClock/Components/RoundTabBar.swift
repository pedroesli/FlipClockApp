//
//  RoundTabBar.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 02/08/23.
//

import SwiftUI

struct RoundTabBar: View {
    
    @Binding var selectedTabOption: TabOption
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(
                    Color.asset.tabBar
                        .shadow(.inner(color: Color.asset.tabBarBShadowColor.opacity(0.5), radius: 1, x: -1, y: -1))
                        .shadow(.inner(color: Color.asset.tabBarAShadowColor.opacity(0.3), radius: 1, x: 1, y: 1))
                )
                .shadow(color: Color.asset.tabBarBShadowColor.opacity(0.9), radius: 6.5, x: 5, y: 5)
                .shadow(color: Color.asset.tabBarAShadowColor.opacity(0.9), radius: 5, x: -5, y: -5)
                .shadow(color: Color.asset.tabBarBShadowColor.opacity(0.2), radius: 5, x: 5, y: -5)
                .shadow(color: Color.asset.tabBarBShadowColor.opacity(0.2), radius: 5, x: -5, y: 5)
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
        
        @Binding var selectedTabOption: TabOption
        let tabOption: TabOption
        
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
            Color.asset.background.ignoresSafeArea()
            RoundTabBar(selectedTabOption: .constant(.clock))
                .environmentObject(settingsManager)
                .onAppear {
                    settingsManager.settings.appColorInfo = .init(assetColor: .pink)
                }
        }
    }
}
