//
//  StopWatchView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/23.
//

import SwiftUI

struct StopWatchView: View {
    
    @Binding var showAllViews: Bool
    @EnvironmentObject private var settingsManager: SettingsManager
    @EnvironmentObject private var stopWatch: StopWatchManager
    @State private var hour = FlipTextInfo(value: "00")
    @State private var minute = FlipTextInfo(value: "00")
    @State private var seconds = FlipTextInfo(value: "00")
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView(showAllViews: .constant(false))
            .environmentObject(SettingsManager())
            .environmentObject(StopWatchManager())
    }
}
