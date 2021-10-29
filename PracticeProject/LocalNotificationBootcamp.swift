//
//  LocalNotificationBootcamp.swift
//  PracticeProject
//
//  Created by Luka Vujnovac on 29.10.2021..
//

import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthoratization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ode je error \(error)")
            }else {
                print("success")
            }
        }
    }
    
    func scheduleNotifications() {
        
        let content = UNMutableNotificationContent()
        content.title = "Ovo sam ja napravia obavijest da dode"
        content.subtitle = "imam zgodnu curu plavusu"
        content.sound = .default
        content.badge = 1
        
        //time
//        let triggerTime = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 00
        dateComponents.day = 2 //starts on sunday -> 1 == sunday
        let triggerCalendar = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: triggerCalendar)
        UNUserNotificationCenter.current().add(request)
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") { 
                NotificationManager.instance.requestAuthoratization()
            }
            
            Button("Schedule Notification") { 
                NotificationManager.instance.scheduleNotifications()
            }
        }.onAppear { 
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotificationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationBootcamp()
    }
}
