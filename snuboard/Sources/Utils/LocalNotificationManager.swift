//
//  LocalNotificationManager.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/15.
//
// Reference: https://velog.io/@wimes/SwiftUI%EC%97%90%EC%84%9C-LocalNotification-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0-4sk60gjlbf


import Foundation
import UserNotifications


class LocalNotificationManager {
    var notifications = [NotificationData]()
    
    func requestPermission() -> Void {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) { granted, error in
                if granted == true && error == nil {
                    // We have permission!
                }
        }
    }
    
    func addNotification(notification: NotificationData) -> Void {
        notifications.append(notification)
    }
    
    func scheduleNotifications() -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: notification.noticeIdStr, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.noticeId)")
            }
        }
    }
    
    
    static func setNotifications(notification: NotificationData) {
        let manager = LocalNotificationManager()
        manager.requestPermission()
        manager.addNotification(notification: notification)
        manager.scheduleNotifications()
    }
    
    
    
}
