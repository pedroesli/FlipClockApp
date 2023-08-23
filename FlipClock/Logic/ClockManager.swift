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
    
    func onHourFormatChange(_ hourFormat: HourFormat) {
        let periodText = hourFormat.periodText(from: firedTime)
        hour.value = hourFormat.formatHour(from: firedTime)
        print(hour.value, hourFormat)
        hour.periodText = periodText
    }
    
    func updateDials(with date: Date) {
        guard let hourFormat = settingsManager?.settings.hourFormat else { return }
        let periodText = hourFormat.periodText(from: date)
        hour = FlipTextInfo(value: hourFormat.formatHour(from: date), periodText: periodText)
        minute.value = date.formatted("mm")
        second.value = date.formatted("ss")
    }
}
