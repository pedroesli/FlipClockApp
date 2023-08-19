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
    private var startTime: TimeInterval = 0
    private var pauseTime: TimeInterval = 0
    private var accumulatedTime: TimeInterval = 0
    private var store = Set<AnyCancellable>()
    
    func updateMainDials() {
        hour.value = String(accumulatedTime.hour)
        minute.value = accumulatedTime.minute.formattedTime()
        second.value = accumulatedTime.second.formattedTime()
    }
    
    func updateMiliseconds(with date: Date) {
        let currentTime = Date.timeIntervalSinceReferenceDate
        accumulatedTime = currentTime - startTime
        milisecond = accumulatedTime.millisecond.formattedTime()
    }
    
    func initiateTimePublishers() {
        timer.sink { [weak self] _ in
            self?.updateMainDials()
        }.store(in: &store)
        milisecondsTimer.sink { [weak self] date in
            self?.updateMiliseconds(with: date)
        }.store(in: &store)
    }
    
    func start() {
        state = .stop
        startTime = Date.timeIntervalSinceReferenceDate
        accumulatedTime = 0
        initiateTimePublishers()
    }
    
    func stop() {
        state = .resume
        timer.upstream.connect().cancel()
        milisecondsTimer.upstream.connect().cancel()
        pauseTime = Date.timeIntervalSinceReferenceDate
        startTime = pauseTime - startTime
    }
    
    func resume() {
        state = .stop
        startTime = Date.timeIntervalSinceReferenceDate - startTime
        initiateTimePublishers()
    }
    
    func reset() {
        state = .start
        timer.upstream.connect().cancel()
        milisecondsTimer.upstream.connect().cancel()
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
