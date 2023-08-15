//
//  StopWatchState.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/23.
//

enum StopWatchState {
    case stop
    case start
    case resume
    
    var title: String {
        switch self {
        case .stop: return Localization.StopWatch.stop
        case .start: return Localization.StopWatch.start
        case .resume: return Localization.StopWatch.resume
        }
    }
}
