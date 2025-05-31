//
//  Other.swift
//  MyAlarm
//
//  Created by Trey Gaines on 5/30/25.
//


import Observation
import SwiftUI

@Observable
class Other {
    var colorPreference: ColorScheme
    var timer: Timer?
    let currentTime: Date
    
    init() {
        self.currentTime = Date()
        let hour = Calendar.current.component(.hour, from: currentTime)
        
        if hour < 12 {
            self.colorPreference = .light
        } else { self.colorPreference = .dark }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let now = self.currentTime
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            print("Current time: \(formatter.string(from: now))")
        }
    }
}
