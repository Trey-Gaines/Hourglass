//
//  TimerObj.swift
//  MyAlarm
//
//  Created by Trey Gaines on 5/30/25.
//


import Foundation
import SwiftUI
import Observation

@Observable
class TimerObject {
    var exists: Bool = false
    var timerLength: Int
    var timer: Timer? = nil
    var timeElapsed = 0
    var isTimerRunning = false
    
    var remainingTime: Int {
        return (timerLength * 1000) - timeElapsed
    }
    
    var progress: CGFloat {
        guard timerLength > 0 else { return 0 }
        guard remainingTime > 0 else { return 0 }
        return CGFloat((timerLength * 1000) - remainingTime) / CGFloat(timerLength * 10)
    }
    
    
    func startTimer() {
        stopTimer()
        timeElapsed = 0
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if self.isTimerRunning {
                DispatchQueue.main.async {
                    if self.remainingTime > 0 {
                        self.timeElapsed += 100
                    } else {
                        self.isTimerRunning = false
                        self.stopTimer()
                    }
                }
            }
        }
    }
    
    func stopTimer() { timer?.invalidate() }
    
    func resetTimer() {
        timeElapsed = 0
        isTimerRunning = false
    }
    
    init() {
        if UserDefaults.standard.object(forKey: Keys.timerFinished) != nil {
            self.exists = UserDefaults.standard.bool(forKey: Keys.timerFinished)
        } else { self.exists = false }
        
        if UserDefaults.standard.object(forKey: Keys.timerFinished) != nil {
            self.timerLength = UserDefaults.standard.integer(forKey: Keys.timerFinished)
        } else { self.timerLength = 0 }
    }
}

public struct Keys {
    static let timerFinished = "finished"
    static let timerLeft = "leftover"
}
