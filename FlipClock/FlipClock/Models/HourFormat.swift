//
//  HourFormat.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 27/07/23.
//

import Foundation

enum HourFormat: Codable {
    /// Use system based format
    case system
    /// Use 24 hour format
    case military
    /// Use two periods based format (am, pm)
    case twoPeriods
}
