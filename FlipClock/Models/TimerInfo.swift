//
//  TimerInfo.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 11/08/23.
//

import Foundation

struct TimerInfo {
    
    var timeInterval: Int = 0
    var hour: Int {
        Int(timeInterval / 3600)
    }
    var minute: Int {
        Int((Double(timeInterval) / 60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(Double(timeInterval).truncatingRemainder(dividingBy: 60))
    }
    
    init() { }
    
    init(hour: Int, minute: Int, second: Int) {
        timeInterval = hour * 3600 + minute * 60 + second
    }
    
    var isComplete: Bool {
        timeInterval == 0
    }
    
    mutating func countDown() {
        timeInterval -= 1
    }
}
