//
//  CircleColorPickerManager.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 30/08/23.
//

import SwiftUI

#if os(iOS)
class CircleColorPickerManager: NSObject, ObservableObject {
    
    @Published var pickedColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    var allowHitTesting: Bool {
            return false
    }
}
#else
class CircleColorPickerManager: NSObject, ObservableObject {
    
    @Published var pickedColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
    var allowHitTesting: Bool {
            return true
    }
    
    private weak var colorPanel: NSColorPanel?
    private var session: NSApplication.ModalSession?
    private let colorPickerId = UUID()
    private static var currentlyUsingId: UUID?
    
    func showColorPanel() {
        let colorPanel = NSColorPanel.shared
        colorPanel.showsAlpha = false
        colorPanel.delegate = self
        self.colorPanel = colorPanel
        session = NSApplication.shared.beginModalSession(for: colorPanel)
        Self.currentlyUsingId = colorPickerId
    }
    
    func createNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(selectedColor),
            name: NSColorPanel.colorDidChangeNotification,
            object: nil
        )
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: NSColorPanel.colorDidChangeNotification, object: nil)
    }
    
    @objc func selectedColor() {
        guard Self.currentlyUsingId == colorPickerId, let color = colorPanel?.color.cgColor else { return }
        pickedColor = color
    }
}

extension CircleColorPickerManager: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        
        guard let session else { return }
        NSApplication.shared.endModalSession(session)
    }
}
#endif
