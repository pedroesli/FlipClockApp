//
//  ClockView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/23.
//

import SwiftUI

struct ClockView: View {
    
    @Binding var showAllViews: Bool
    @EnvironmentObject private var settingsManager: SettingsManager
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(spacing: 28) {
                    Group {
                        FlipDial()
                        FlipDial()
                        if settingsManager.settings.displaySeconds {
                            FlipDial()
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 32)
            } else {
                // Landscape
                HStack(spacing: 28) {
                    Group {
                        FlipDial()
                        FlipDial()
                        if settingsManager.settings.displaySeconds {
                            FlipDial()
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                }
                .frame(maxHeight: .infinity)
            }
        }
        .padding(.bottom, 16)
        .overlay {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeIn(duration: 0.15)) {
                        showAllViews.toggle()
                    }
                }
        }
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.asset.background.ignoresSafeArea()
            ClockView(showAllViews: .constant(false))
                .environmentObject(SettingsManager())
        }
    }
}
