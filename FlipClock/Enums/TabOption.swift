//
//  TabOption.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 03/08/23.
//

enum TabOption {
    case clock
    case stopwatch
    case timer
    
    var imageName: String {
        switch self {
        case .clock:
            return "clock"
        case .stopwatch:
            return "stopwatch.fill"
        case .timer:
            return "timer"
        }
    }
}
