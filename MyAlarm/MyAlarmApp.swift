//
//  MyAlarmApp.swift
//  MyAlarm
//
//  Created by Trey Gaines on 5/30/25.
//

import SwiftUI

@main
struct MyAlarmApp: App {
    @State private var other = Other()
    @State private var myTimer = TimerObject()
    var body: some Scene {
        WindowGroup {
            ContentView(size: 100)
                .environment(other)
                .environment(myTimer)
                .preferredColorScheme(other.colorPreference)
                //When the app is suspended
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification), perform: { _ in
                    UserDefaults.standard.set(myTimer.isTimerRunning, forKey: UDKeys.running)
                    UserDefaults.standard.set(myTimer.remainingTime, forKey: UDKeys.timeLeft)
                })
                //When the app is closed
                //                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification), perform: { _ in
                //                    UserDefaults.standard.set(myTimer.isTimerRunning, forKey: UDKeys.running)
                //                    UserDefaults.standard.set(myTimer.remainingTime, forKey: UDKeys.timeLeft)
                //                })
        }
    }
}
