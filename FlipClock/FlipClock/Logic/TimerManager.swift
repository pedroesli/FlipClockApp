//
//  TimerViewManager.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 11/08/23.
//

import SwiftUI
import Combine

class TimerManager: ObservableObject {
    @Published var hour = FlipTextInfo(value: "0")
    @Published var minute = FlipTextInfo(value: "00")
    @Published var second = FlipTextInfo(value: "00")
    @Published var hourPicker = 0
    @Published var minutePicker = 0
    @Published var secondPicker = 0
    @Published var state: TimerState = .start
    @Published var timerInfo = TimerInfo()
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private var cancellable: AnyCancellable?
    private let exitDateKey = "EXITDATEKEY"
    
    init() {
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { _ in
            self.didBecomeActive()
        }
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
            self.didEnterBackground()
        }
    }
    
    func didBecomeActive() {
        guard state != .start else { return }
        guard let exitDate = UserDefaults.standard.object(forKey: exitDateKey) as? Date else { return }
        let timeLapse = timerInfo.timeInterval - Int(Date().timeIntervalSince(exitDate).rounded(.up))
        if timeLapse <= 0 {
            timerInfo.timeInterval = 0
        } else {
            timerInfo.timeInterval = timeLapse
        }
        cancellable = timer.sink { [weak self] _ in
            self?.updateDials()
        }
    }
    
    func didEnterBackground() {
        guard state != .start else { return }
        // Stop timer to avoid race condition
        timer.upstream.connect().cancel()
        UserDefaults.standard.set(Date(), forKey: exitDateKey)
        print(Date())
    }
    
    func requestAuthorization() {
        LocalNotification.current.requestAuthorization()
    }
    
    func updateDials() {
        if timerInfo.isComplete {
            complete()
            return
        }
        timerInfo.countDown()
        hour.value = String(timerInfo.hour)
        minute.value = timerInfo.minute.formattedTime()
        second.value = timerInfo.second.formattedTime()
    }
    
    func start() {
        state = .pause
        cancellable = timer.sink { [weak self] _ in
            self?.updateDials()
        }
        LocalNotification.current.timerNotification(timeInterval: timerInfo.timeInterval)
    }
    
    func pause() {
        state = .resume
        timer.upstream.connect().cancel()
        LocalNotification.current.cancelTimerNotification()
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
        timerInfo = TimerInfo(hour: hourPicker, minute: minutePicker, second: secondPicker)
    }
    
    func reset() {
        state = .start
        timer.upstream.connect().cancel()
        hour.value = String(hourPicker)
        minute.value = minutePicker.formattedTime()
        second.value = secondPicker.formattedTime()
        timerInfo = TimerInfo(hour: hourPicker, minute: minutePicker, second: secondPicker)
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
    
    func updateHourInfo(_ hour: Int) {
        self.hour.value = String(hour)
        timerInfo = TimerInfo(hour: hour, minute: timerInfo.minute, second: timerInfo.second)
    }
    
    func updateMinuteInfo(_ minute: Int) {
        self.minute.value = minute.formattedTime()
        timerInfo = TimerInfo(hour: timerInfo.hour, minute: minute, second: timerInfo.second)
    }
    
    func updateSecondInfo(_ second: Int) {
        self.second.value = second.formattedTime()
        timerInfo = TimerInfo(hour: timerInfo.hour, minute: timerInfo.minute, second: second)
    }
}
