//
//  NotificationService.swift
//  YourSmartCity
//
//  Created by Aleksandr Parshakov on 4/26/20.
//  Copyright © 2020 Aleksandr Parshakov. All rights reserved.
//

import Foundation
import NotificationCenter

struct NotificationService {
    private init() {}
    
    static func showCriticalAlert(withTitle title: String, andMessage body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .defaultCritical
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
        
        let request = UNNotificationRequest(identifier: "CriticalRequest", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
