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
    
    var body: some View {
        Button {
//            if myTimer.isTimerRunning {
//                myTimer.pauseTimer()
//            } else if myTimer.isTimerPaused {
//                myTimer.resumeTimer()
//            }
        } label: {
            if !myTimer.isTimerRunning, !myTimer.isTimerPaused {
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
                Text("Stop")
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                    .font(.system(size: myFontSize))
                    .background {
                        Circle()
                            .fill(Color.red)
                            .stroke(Color.black, lineWidth: 1.5)
                            .frame(minWidth: size, maxWidth: .infinity, minHeight: size, maxHeight: .infinity)
                            .padding()
                    }
            } else if myTimer.isTimerPaused {
                Text("Resume")
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                    .font(.system(size: myFontSize))
                    .background {
                        Circle()
                            .fill(Color.gray)
                            .stroke(Color.black, lineWidth: 1.5)
                            .frame(minWidth: size, maxWidth: .infinity, minHeight: size, maxHeight: .infinity)
                            .padding()
                    }
            }
        }
    }
}
