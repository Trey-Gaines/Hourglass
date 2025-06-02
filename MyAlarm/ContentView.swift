//
//  ContentView.swift
//  MyAlarm
//
//  Created by Trey Gaines on 5/30/25.
//

import SwiftUI

struct ContentView: View {
    @State private var myTimer = TimerObject()
    
    var body: some View {
        VStack(spacing: 25) {
            Countdown()
            HStack {
                RestartButton()
                StopButton()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
