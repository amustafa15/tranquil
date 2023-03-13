//
//  TimerModel.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 2/28/22.
//

import Foundation

struct TimerModel {
    
    var timerVal: Int = 1
    var chosenSound: String = "None"
    var initialTime: Int = 1
    var paused: Bool = false
    
    var times = [1, 2, 3, 4, 5, 10, 15, 20, 30, 45, 60]
    var soundsLight = ["None", "Light Rain", "Spring Forest", "Relaxing Beach", "Lenny And Carl" ]
    var soundsDark = ["None", "Creepy Kids", "The Forbidden Forest", "Conjuring The Dark One", "Lenny And Carl"]
}
