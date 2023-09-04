//
//  RangeIntengerStyle.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 01/09/23.
//

import Foundation

struct RangeIntegerStyle: ParseableFormatStyle {

    var parseStrategy = RangeIntegerStrategy()
    var returnFormat = "%02d"
    let range: ClosedRange<Int>

    func format(_ value: Int) -> String {
        let constrainedValue = min(max(value, range.lowerBound), range.upperBound)
        print(constrainedValue)
        return String(format: returnFormat, constrainedValue)
    }
    
    struct RangeIntegerStrategy: ParseStrategy {
        func parse(_ value: String) throws -> Int {
            return Int(value) ?? 0
        }
    }
}
