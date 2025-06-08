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
    var currentTime = Date()
    
    var myTime: String
    
    init() {
        let hour = Calendar.current.component(.hour, from: Date())
        self.myTime = "Getting the current time..."
        
        if hour < 12 {
            self.colorPreference = .light
        } else { self.colorPreference = .dark }
        
        let formatter: DateFormatter = {
            let df = DateFormatter()
            df.timeStyle = .medium
            return df
        }()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let now = Date()
            self.currentTime = now
            self.myTime = "Current time: \(formatter.string(from: now))"
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
