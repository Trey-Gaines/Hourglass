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
    var timerLength: Int {
        didSet { if timerLength != 0 { startTimer() } }
    }
    var timer: Timer? = nil
    var timeElapsed = 0
    var isTimerRunning = false
    var isTimerPaused = false
    
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
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.isTimerRunning {
                if self.remainingTime > 0 {
                    self.timeElapsed += 100
                } else {
                    self.isTimerRunning = false
                    self.stopTimer()
                }
            }
        }
    }
    
    func pauseTimer() {
        isTimerPaused = true
        isTimerRunning = false
        stopTimer()
    }
    
    func resumeTimer() {
        isTimerPaused = false
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.isTimerRunning {
                if self.remainingTime > 0 {
                    self.timeElapsed += 100
                } else {
                    self.isTimerRunning = false
                    self.stopTimer()
                }
            }
        }
    }
    
    func stopTimer() { timer?.invalidate()  }
    
    func resetTimer() {
        timeElapsed = 0
        timerLength = 0
        isTimerRunning = false
    }
    
    init() {
        if UserDefaults.standard.bool(forKey: UDKeys.running) {
            let timeLeft = UserDefaults.standard.integer(forKey: UDKeys.timeLeft)
            if let timeStarted = UserDefaults.standard.object(forKey: UDKeys.timeStarted) as? Date {
                let elapsed = Int(Date().timeIntervalSince(timeStarted))
                let adjustedTime = max(0, ((timeLeft * 1000) - elapsed) / 1000)
                

                if adjustedTime > 0 {
                    self.timerLength = adjustedTime
                    self.startTimer()
                } else { self.isTimerRunning = false; self.timerLength = 0 }
            } else { self.isTimerRunning = false; self.timerLength = 0 }
        } else { self.isTimerRunning = false; self.timerLength = 0 }
    }
}



public struct UDKeys {
    static let running = "running"
    static let timeLeft = "timeleft"
    static let timeStarted = "timestarted"
}

