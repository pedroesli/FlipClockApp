//
//  Int+Extensions.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/23.
//

import Foundation

extension Int {
    func formattedTime() -> String {
        String(format: "%02d", self)
    }
}
