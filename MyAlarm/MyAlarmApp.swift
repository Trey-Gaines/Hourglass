//
//  MyAlarmApp.swift
//  MyAlarm
//
//  Created by Trey Gaines on 5/30/25.
//

import SwiftUI

@main
struct MyAlarmApp: App {
    @State private var other = Other()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(other.colorPreference)
        }
    }
}
