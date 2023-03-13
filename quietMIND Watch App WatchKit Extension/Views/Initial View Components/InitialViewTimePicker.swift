//
//  InitialViewTimePicker.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 3/8/23.
//

import SwiftUI

struct InitialViewTimePicker: View {
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        Picker(selection: self.$timerViewModel.timerModel.timerVal, label: Text("How many minutes?")) {
            ForEach(0..<self.timerViewModel.getTimes().count, id: \.self) {
                Text("\(self.timerViewModel.getTimes()[$0])")
                    .tag(self.timerViewModel.getTimes()[$0])
                    .accessibilityIdentifier("\(self.timerViewModel.getTimes()[$0])")
            }
        }
        .foregroundColor(Color.ColorPrimary)
        .pickerStyle(.wheel)
        .accessibilityIdentifier("TimePicker")
    }
}

struct InitialViewTimePicker_Previews: PreviewProvider {
    static var previews: some View {
        InitialViewTimePicker()
    }
}
