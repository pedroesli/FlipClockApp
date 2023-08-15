//
//  TimerState.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 11/08/23.
//

enum TimerState {
    case start
    case pause
    case resume
    
    var title: String {
        switch self {
        case .start: return Localization.Timer.start
        case .pause: return Localization.Timer.pause
        case .resume: return Localization.Timer.resume
        }
    }
}
