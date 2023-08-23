//
//  HourFormat.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import Foundation

enum HourFormat: Codable, Identifiable {
    /// Use system based format
    case system
    /// Use 24 hour format
    case military
    /// Use two periods based format (am, pm)
    case twoPeriods
    
    var id: Self { self }
    
    var is24HourFormat: Bool {
        if self == .military {
            return true
        }
        if self == .system {
            let formater = DateFormatter()
            formater.timeStyle = .short
            if formater.dateFormat.contains("a") {
                return false
            }
        }
        return false
    }
    
    func formatHour(from date: Date) -> String {
        switch self {
        case .system:
            if self.is24HourFormat {
                return date.formatted("H")
            }
            return date.formatted("h")
        case .military: return date.formatted("H")
        case .twoPeriods: return date.formatted("h")
        }
    }
    
    func periodText(from date: Date) -> String? {
        return is24HourFormat ? nil : date.formatted("a")
    }
}
