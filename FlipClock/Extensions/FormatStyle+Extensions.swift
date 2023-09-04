//
//  FormatStyle+Extensions.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 01/09/23.
//

import Foundation

extension FormatStyle where Self == RangeIntegerStyle {
    static func ranged(_ range: ClosedRange<Int>) -> RangeIntegerStyle {
        return RangeIntegerStyle(range: range)
    }
}
