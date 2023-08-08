//
//  Date+Extensions.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 08/08/23.
//

import Foundation

extension Date {
    func formatted(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
