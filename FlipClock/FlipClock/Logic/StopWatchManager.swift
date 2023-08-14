//
//  StopWatchManager.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 10/08/23.
//

import SwiftUI
import Combine

class StopWatchManager: ObservableObject {
    
    @Published var hour = FlipTextInfo(value: "0")
    @Published var minute = FlipTextInfo(value: "00")
    @Published var second = FlipTextInfo(value: "00")
    @Published var milisecond = "00"
    @Published var state: StopWatchState = .start
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private let milisecondsTimer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    private var startTime = Date.now
    private var store = Set<AnyCancellable>()
    
    func updateMainDials(with date: Date) {
        let timeElapsed = date.timeIntervalSince(startTime)
        hour.value = String(timeElapsed.hour)
        minute.value = timeElapsed.minute.formattedTime()
        second.value = timeElapsed.second.formattedTime()
    }
    
    func updateMiliseconds(with date: Date) {
        let timeElapsed = date.timeIntervalSince(startTime)
        milisecond = timeElapsed.millisecond.formattedTime()
    }
    
    func start() {
        state = .stop
        startTime = Date.now
        timer.sink { [weak self] date in
            self?.updateMainDials(with: date)
        }.store(in: &store)
        milisecondsTimer.sink { [weak self] date in
            self?.updateMiliseconds(with: date)
        }.store(in: &store)
    }
    
    func stop() {
        state = .resume
        timer.upstream.connect().cancel()
        milisecondsTimer.upstream.connect().cancel()
    }
    
    func resume() {
        state = .stop
        timer.sink { [weak self] date in
            self?.updateMainDials(with: date)
        }.store(in: &store)
        milisecondsTimer.sink { [weak self] date in
            self?.updateMiliseconds(with: date)
        }.store(in: &store)
    }
    
    func reset() {
        state = .start
        hour.value = "0"
        minute.value = "00"
        second.value = "00"
        milisecond = "00"
    }
    
    func onResetPressed() {
        reset()
    }
    
    func onControlPressed() {
        switch state {
        case .stop:
            stop()
        case .start:
            start()
        case .resume:
            resume()
        }
    }
}
