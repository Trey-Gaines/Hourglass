//
//  RestartButton.swift
//  MyAlarm
//
//  Created by Trey Gaines on 5/30/25.
//
import SwiftUI

struct RestartButton: View {
    @Environment(TimerObject.self) var myTimer
    var size: CGFloat
    var myFontSize: CGFloat { size / 5 }
    @Binding var newTimerLength: Int
    
    var body: some View {
        Button {
            myTimer.stopTimer()
            myTimer.resetTimer()
            UserDefaults.standard.set(false, forKey: UDKeys.running)
            UserDefaults.standard.set(0, forKey: UDKeys.timeLeft)
            newTimerLength = 1
        } label: {
            Text("Restart")
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
        }
    }
}


#Preview {
    struct Preview: View {
            @State var number = 10
            var body: some View {
                RestartButton(size: 150, newTimerLength: $number)
                    .environment(TimerObject.init())
            }
    }; return Preview()
}
