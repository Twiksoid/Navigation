//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Nikita Byzov on 24.01.2023.
//

import UIKit
import UserNotifications

struct LocalNotificationsService {
    static func registeForLatestUpdatesIfPossible() {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .badge, .provisional]) { result, error in
            
            if let error = error { print(NSLocalizedString(LocalizedKeys.keySomeErrorWithAuthNotifications, comment: ""), " ", error) }
            
            if result == true {
                
                DispatchQueue.main.async {
                    let content = UNMutableNotificationContent()
                    content.title = NSLocalizedString(LocalizedKeys.keyTitleDailyUserNotification, comment: "")
                    content.body = NSLocalizedString(LocalizedKeys.keyBodyDailyUserNotification, comment: "")
                    content.sound = .default
                    content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
                    
                    var component = DateComponents()
                    component.hour = 13
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: false)
                    
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    
                    center.add(request)
                }
            }
        }
    }
}
