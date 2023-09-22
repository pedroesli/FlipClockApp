//
//  LocalNotification.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 14/08/23.
//

import Foundation
import UserNotifications

class LocalNotification {
    static let current = LocalNotification()
    
    let timerIdentifier = UUID().uuidString
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, error in
            guard error == nil else {
                print("Request Authorization error: \(error!)")
                return
            }
        }
    }
    
    func timerNotification(timeInterval: Int) {
        let content = UNMutableNotificationContent()
        content.title = Localization.Notification.title
        content.subtitle = Localization.Notification.subtitle
        content.sound = UNNotificationSound.defaultCritical
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
        let request = UNNotificationRequest(identifier: timerIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelTimerNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [timerIdentifier])
    }
}
