//
//  NavBar.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI

struct NavBar: View {
    
    let safeAreaInsets: EdgeInsets
    @Binding var showNavBar: Bool
    let settingButtonAction: () -> Void
    @EnvironmentObject private var settingsManager: SettingsManager
    
    var verticalPadding: CGFloat {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 0
        }
        return 9
        #else
        return 0
        #endif
    }
    
    var topPadding: CGFloat {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 16
        }
        #endif
        return 0
    }
    
    var body: some View {
        Color.clear
            .frame(height: showNavBar ? safeAreaInsets.top : 0)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    settingButtonAction()
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(settingsManager.appColor)
                        .font(.title2)
                        .padding(.vertical, verticalPadding)
                        .padding(.horizontal, 16)
                }
                .buttonStyle(.borderless)
            }
            .padding(.top, topPadding)
            .offset(y: showNavBar ? 0 : -safeAreaInsets.top - 100)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            NavBar(safeAreaInsets: geometry.safeAreaInsets, showNavBar: .constant(true)) {
                
            }
        }
        .environmentObject(SettingsManager())
    }
}
