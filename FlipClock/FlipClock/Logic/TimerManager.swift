//
//  TimerViewManager.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 11/08/23.
//

import SwiftUI
import Combine

class TimerManager: ObservableObject {
    @Published var hour = FlipTextInfo(value: "00")
    @Published var minute = FlipTextInfo(value: "00")
    @Published var second = FlipTextInfo(value: "00")
    @Published var state: TimerState = .start
    @Published var timerInfo = TimerInfo()
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private var cancellable: AnyCancellable?
    
    func updateDials() {
        if timerInfo.isComplete {
            complete()
            return
        }
        timerInfo.countDown()
        hour.value = timerInfo.hour.formattedTime()
        minute.value = timerInfo.minute.formattedTime()
        second.value = timerInfo.second.formattedTime()
    }
    
    func start() {
        state = .pause
        cancellable = timer.sink { [weak self] _ in
            self?.updateDials()
        }
    }
    
    func pause() {
        state = .resume
        timer.upstream.connect().cancel()
    }
    
    func resume() {
        state = .pause
        cancellable = timer.sink { [weak self] _ in
            self?.updateDials()
        }
    }
    
    func complete() {
        state = .start
        timer.upstream.connect().cancel()
    }
    
    func reset() {
        state = .start
        timer.upstream.connect().cancel()
        hour.value = "00"
        minute.value = "00"
        second.value = "00"
    }
    
    func onResetPressed() {
        reset()
    }
    
    func onControlPressed() {
        switch state {
        case .pause:
            pause()
        case .start:
            start()
        case .resume:
            resume()
        }
    }
}
