//
//  HomeViewSoundsPicker.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/23/23.
//

import SwiftUI

struct HomeViewSoundsPicker: View {
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        Group {
            VStack {
                Section(header: HStack {
                    Text("Any Background Sounds?")
                        .font(.title2)

                        .padding(.bottom, 0)
                        .padding(.leading, 30)
                    Spacer()
                }
                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0))
                ) {
                    Form {
                        Picker(selection: self.$timerViewModel.timerModel.chosenSound, label: Text("What will you listen to?")) {
                            ForEach(self.timerViewModel.getSounds(), id: \.self) { sound in
                                Text("\(sound)")
                                    .accessibilityIdentifier("\(sound)")
                            }
                        } // picker
                        .accessibilityIdentifier("SoundsPicker")
                    } // form
                    .frame(width:350, height: 45)
                    .padding(.top, 0)
                } // section callback
            }
        } // second group
    }
}

struct HomeViewSoundsPicker_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSoundsPicker()
    }
}
