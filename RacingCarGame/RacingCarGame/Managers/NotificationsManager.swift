//
//  PushNotificationsManager.swift
//  RacingCarGame
//
//  Created by Admin on 15.08.21.
//

import UserNotifications

class NotificationsManager {

    static var shared = NotificationsManager()

    private let identifier = String(describing: NotificationsManager.self)
    private let notificationCenter = UNUserNotificationCenter.current()
    private let timeInterval: Double = 3600

    func push() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Hi, player!"
                content.body = "You don't played for a long time. Come in to set a new records!"
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.timeInterval, repeats: true)
                let request = UNNotificationRequest(identifier: self.identifier, content: content, trigger: trigger)
                self.notificationCenter.add(request) { (error) in
                    print(error?.localizedDescription)
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    func remove() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
