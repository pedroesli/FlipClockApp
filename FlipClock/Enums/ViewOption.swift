//
//  TabOption.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 03/08/23.
//

enum ViewOption {
    case clock
    case stopwatch
    case timer
    case settings
    
    var imageName: String {
        switch self {
        case .clock: return "clock"
        case .stopwatch: return "stopwatch.fill"
        case .timer: return "timer"
        case .settings: return "gearshape.fill"
        }
    }
}
