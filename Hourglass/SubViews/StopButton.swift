//
//  StopButton.swift
//  MyAlarm
//
//  Created by Trey Gaines on 5/30/25.
//
import SwiftUI

struct StopButton: View {
    @Environment(TimerObject.self) var myTimer
    var size: CGFloat
    var myFontSize: CGFloat { size / 5 }
    var newTimerLength: Int
    
    var body: some View {
        Button {
            if myTimer.progress == 0 {
                myTimer.timerLength = newTimerLength
                UserDefaults.standard.set(Date(), forKey: UDKeys.timeStarted)
                UserDefaults.standard.set(true, forKey: UDKeys.running)
                UserDefaults.standard.set(myTimer.remainingTime / 1000, forKey: UDKeys.timeLeft)
            } else if myTimer.isTimerRunning {
                myTimer.pauseTimer()
                UserDefaults.standard.set(true, forKey: UDKeys.running)
                UserDefaults.standard.set(myTimer.remainingTime / 1000, forKey: UDKeys.timeLeft)
                UserDefaults.standard.set(Date(), forKey: UDKeys.timeStarted)
            } else if myTimer.isTimerPaused {
                myTimer.resumeTimer()
                UserDefaults.standard.set(false, forKey: UDKeys.running)
                UserDefaults.standard.set(0, forKey: UDKeys.timeLeft)
                UserDefaults.standard.set(nil, forKey: UDKeys.timeStarted)
            }
        } label: {
            if myTimer.progress == 0 {
                Text("Start")
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                    .font(.system(size: myFontSize))
                    .background {
                        Circle()
                            .fill(Color.blue)
                            .stroke(Color.black, lineWidth: 1.5)
                            .frame(minWidth: size, minHeight: size)
                            .padding()
                    }
            } else if myTimer.isTimerRunning {
                Text("Pause")
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                    .font(.system(size: myFontSize))
                    .background {
                        Circle()
                            .fill(Color.darkRed)
                            .stroke(Color.black, lineWidth: 1.5)
                            .frame(minWidth: size, minHeight: size)
                            .padding()
                    }
            } else if myTimer.isTimerPaused {
                Text("Resume")
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                    .font(.system(size: myFontSize))
                    .background {
                        Circle()
                            .fill(Color.blue)
                            .stroke(Color.black, lineWidth: 1.5)
                            .frame(minWidth: size, minHeight: size)
                            .padding()
                    }
            }
        }
    }
}
