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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
