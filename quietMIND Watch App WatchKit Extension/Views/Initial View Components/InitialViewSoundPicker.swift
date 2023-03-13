//
//  InitialViewSoundPicker.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 3/8/23.
//

import SwiftUI

struct InitialViewSoundPicker: View {
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        Picker(selection: self.$timerViewModel.timerModel.chosenSound, label: Text("Background sounds")) {
            ForEach(self.timerViewModel.getSounds(), id: \.self) { sound in
                Text("\(sound)")
            }
//            Text("None").tag("None")
//            Text("Light Rain").tag("Light Rain")
//            Text("Spring Forest").tag("Spring Forest")
//            Text("Relaxing Beach").tag("Relaxing Beach")
        }
        .foregroundColor(Color.ColorPrimary)
        .pickerStyle(.wheel)
        .accessibilityIdentifier("SoundsPicker")
    }
}

struct InitialViewSoundPicker_Previews: PreviewProvider {
    static var previews: some View {
        InitialViewSoundPicker()
    }
}
