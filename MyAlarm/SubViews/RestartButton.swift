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
    
    var body: some View {
        Button {
            myTimer.stopTimer()
            UserDefaults.standard.set(false, forKey: UDKeys.running)
            UserDefaults.standard.set(0, forKey: UDKeys.timeLeft)
        } label: {
            Text("Restart")
                .foregroundStyle(Color.white)
                .fontWeight(.semibold)
                .font(.system(size: myFontSize))
                .background {
                    Circle()
                        .fill(Color.red)
                        .stroke(Color.black, lineWidth: 1.5)
                        .frame(minWidth: size, minHeight: size)
                        .padding()
                }
        }
    }
}


#Preview {
    RestartButton(size: 150)
        .environment(TimerObject.init())
}
