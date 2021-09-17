//
//  NotificationDataHandler.swift
//  snuboard
//
//  Created by Subeen Park on 2021/09/15.
//
// Reference: https://zeddios.tistory.com/987

import SwiftUI
import CoreData


class NotificationDataHandler {
    
    
    static func fetchNotifications() -> [NotificationDataModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var results: [NotificationDataModel] = []
            
        do {
           let notifications = try context.fetch(NotificationDataModel.fetchRequest()) as! [NotificationDataModel]
            notifications.forEach {
                print($0.title)
                print($0.body)
            }
            results = notifications.reversed()
        } catch {
           print(error.localizedDescription)
        }
        return results
    }
    
    static func saveData(notificationData: NotificationData) -> Bool {
        
        let notifications = fetchNotifications()
        
        if !notifications.filter( { $0.noticeId == notificationData.noticeId } ).isEmpty {
            print("overlapping notice")
            return false
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Notification", in: context)
        if let entity = entity {
            let notification = NSManagedObject(entity: entity, insertInto: context)
            
            notification.setValue(notificationData.title, forKey: "title")
            notification.setValue(notificationData.body, forKey: "body")
            notification.setValue(notificationData.preview, forKey: "preview")
            notification.setValue(notificationData.noticeId, forKey: "noticeId")
            notification.setValue(notificationData.departmentId, forKey: "departmentId")
            notification.setValue(notificationData.departmentName, forKey: "departmentName")
            notification.setValue(notificationData.tags, forKey: "tags")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        return true
    }
    
}
