//
//  MyAlarmApp.swift
//  MyAlarm
//
//  Created by Trey Gaines on 5/30/25.
//

import SwiftUI

@main
struct HourGlassApp: App {
    @State private var other = Other()
    @State private var myTimer = TimerObject()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView(size: 100)
                .environment(other)
                .environment(myTimer)
                .preferredColorScheme(.dark)
            
                //Background
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                    saveTimerState()
                }
            
                //Termination
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                    saveTimerState()
                }
            
                //Restore
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    print("Entered")
                    guard let startedAt = UserDefaults.standard.object(forKey: UDKeys.timeStarted) as? Date else { print("returned"); return}
                    let wasRunning = UserDefaults.standard.bool(forKey: UDKeys.running)
                    let storedTime = UserDefaults.standard.integer(forKey: UDKeys.timeLeft)
                    
                    let elapsed = Int(Date().timeIntervalSince(startedAt))
                    let adjustedTime = max(0, storedTime - elapsed)
                    
                    if wasRunning && adjustedTime > 0 {
                        myTimer.timerLength = adjustedTime
                        myTimer.startTimer()
                    }
                }
        }
    }
    
    func saveTimerState() {
        UserDefaults.standard.set(myTimer.isTimerRunning, forKey: UDKeys.running)
        UserDefaults.standard.set(myTimer.remainingTime / 1000, forKey: UDKeys.timeLeft)
        UserDefaults.standard.set(Date(), forKey: UDKeys.timeStarted)
    }
}
