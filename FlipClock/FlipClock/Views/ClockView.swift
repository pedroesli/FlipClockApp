//
//  ClockView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/08/23.
//

import SwiftUI

struct ClockView: View {
    
    @Binding var showAllViews: Bool
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.size.height > geometry.size.width {
                VStack(spacing: 28) {
                    FlipDial()
                    FlipDial()
                    FlipDial()
                }
                .padding(.horizontal, 32)
            } else {
                // Landscape
                HStack(spacing: 28) {
                    FlipDial()
                    FlipDial()
                    FlipDial()
                }
                .padding(.top, 32)
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
        }
    }
}
