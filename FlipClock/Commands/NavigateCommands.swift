//
//  NavigateCommands.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/08/23.
//

import SwiftUI

struct NavigateCommands: Commands {
    
    @FocusedBinding(\.viewOption) var viewOption
    
    var body: some Commands {
        CommandGroup(replacing: .sidebar) {
            Button("Clock") {
                viewOption = .clock
            }
            .keyboardShortcut("1")
            Button("Stopwatch") {
                viewOption = .stopwatch
            }
            .keyboardShortcut("2")
            Button("Timer") {
                viewOption = .timer
            }
            .keyboardShortcut("3")
            Button("Settings") {
                viewOption = .settings
            }
            .keyboardShortcut("4")
        }
    }
}
