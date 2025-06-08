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
    @State private var timerLength: Int = 1
    @State private var previousDragTranslation: CGFloat = 0
    
    var progressHeight: CGFloat {
        if myTimer.progress == 0 {
            return CGFloat(timerLength) / 60.0
        } else { return CGFloat(myTimer.remainingTime) / 60000.0 }
    }
    var progress: CGFloat {
        if myTimer.progress == 0 {
            CGFloat(timerLength)
        } else { CGFloat(myTimer.remainingTime) / 60000.0}
    }
    
    
    var timerString: String {
        if myTimer.progress == 0 {
            "\(timerLength) min"
        } else { "" }
    }
    
    var size: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                    VStack {
                        if timerLength <= 59 { Spacer() }
                        else if myTimer.progress > 0, myTimer.remainingTime <= 59900 { Spacer() }
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.darkPurple, .indigo, .indigo]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                            )
                            .frame(
                                width: geo.size.width,
                                height: progressHeight * geo.size.height
                            )
                            .animation(.easeInOut(duration: 1), value: progressHeight)
                    }
                }
                .ignoresSafeArea()

            VStack(spacing: 25) {
                Spacer()
                HStack {
                    Text(timerString)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let dragDifference = value.translation.width - previousDragTranslation
                                    let sensitivity: CGFloat = 10
                                    
                                    if abs(dragDifference) >= sensitivity {
                                        let delta = Int(dragDifference / sensitivity)
                                        timerLength = max(1, min(60, timerLength + delta))
                                        previousDragTranslation = value.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    previousDragTranslation = 0
                                }
                        )
                }.frame(width: UIScreen.main.bounds.width)
                Spacer()
                Spacer()
                HStack(spacing: 100) {
                    RestartButton(size: size, newTimerLength: $timerLength)
                    StopButton(size: size, newTimerLength: timerLength)
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                Spacer()
                    .frame(height: 15)
                if myTimer.progress > 0 {
                    Text("Time Left: \(String(myTimer.remainingTime / 1000)) min")
                } else {
                    Text("\(String(describing: other.myTime))")
                }
            }
            .padding()
        }
    }
}

extension Color {
    static let darkPurple = Color(red: 48/255, green: 25/255, blue: 52/255)
    static let darkRed = Color(red: 153/255, green: 27/255, blue: 30/255)
}

#Preview {
    ContentView(size: 100)
        .environment(TimerObject.init())
        .environment(Other.init())
}
