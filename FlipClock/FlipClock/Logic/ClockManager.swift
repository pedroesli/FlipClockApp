//
//  ClockManager.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 08/08/23.
//

import SwiftUI
import Combine

class ClockManager: ObservableObject {
    
    @Published var time = Date.now
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = timer.sink { [weak self] output in
            self?.time = output
        }
    }
}
