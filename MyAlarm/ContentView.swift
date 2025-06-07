//
//  ContentView.swift
//  MyAlarm
//
//  Created by Trey Gaines on 5/30/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(TimerObject.self) var myTimer
    @Environment(Other.self) var other
    
    var size: CGFloat
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.indigo, .blue]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: CGFloat(myTimer.progress / 100) * UIScreen.main.bounds.height
                )
                .animation(.easeInOut(duration: 0.25), value: myTimer.progress)
                .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Spacer()
                HStack(spacing: 100) {
                    RestartButton(size: size)
                    StopButton(size: size)
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                Spacer()
                    .frame(height: 15)
                if myTimer.progress > 0 {
                    
                } else {
                    Text("\(String(describing: other.myTime))")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(size: 100)
        .environment(TimerObject.init())
        .environment(Other.init())
}
