//
//  ClockManager.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 08/08/23.
//

import SwiftUI
import Combine

class ClockManager: ObservableObject {
    
    @Published var hour = FlipTextInfo(value: "00")
    @Published var minute = FlipTextInfo(value: "00")
    @Published var second = FlipTextInfo(value: "00")
    
    private weak var settingsManager: SettingsManager?
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private var firedTime = Date.now
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = timer.sink { [weak self] date in
            self?.updateDials(with: date)
            self?.firedTime = date
        }
    }
    
    func onAppear(settingsManager: SettingsManager) {
        self.settingsManager = settingsManager
        updateDials(with: Date.now)
    }
    
    func onHourFormatChange(_ newValue: HourFormat) {
        guard let settingsManager else { return }
        let periodText = firedTime.periodText(is24HourFormat: newValue.is24HourFormat)
        hour.value = settingsManager.formatHour(from: firedTime)
        hour.periodText = periodText
    }
    
    func updateDials(with date: Date) {
        guard let settingsManager else { return }
        let periodText = date.periodText(is24HourFormat: settingsManager.settings.hourFormat.is24HourFormat)
        hour = FlipTextInfo(value: settingsManager.formatHour(from: date), periodText: periodText)
        minute.value = date.formatted("mm")
        second.value = date.formatted("ss")
    }
}
