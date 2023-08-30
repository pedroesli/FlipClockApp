//
//  FlipClockApp.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 21/07/23.
//

import SwiftUI

@main
struct FlipClockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            NavigateCommands()
        }
    }
}
