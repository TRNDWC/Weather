//
//  NotificationManager.swift
//  Weather
//
//  Created by Trần Đức on 23/8/24.
//

import Foundation

extension Notification.Name{
    static let unitChangeNoti = Notification.Name("UnitChange")
}

class NotificationManager {
    public static let shared: NotificationManager = NotificationManager()
    
    func unitChangePostNotification(){
        NotificationCenter.default.post(name: .unitChangeNoti, object: nil)
    }
}
