//
//  TimerButtonsView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/22/23.
//

import SwiftUI

struct TimerButtonsView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        HStack {
            self.timerViewModel.getPaused() == true ? Image(systemName: "play.circle")
                .foregroundColor(Color.DodgerBlue)
                .font(.system(size: 75))
                .onTapGesture {
                    self.timerViewModel.pressPause()
                    if self.timerViewModel.getChosenSound() != "None" {
                        self.timerViewModel.audioPlayer.play()
                    }
                }
                .accessibilityIdentifier("play.circle")
            // this is for UI tests so image can be clicked
            : Image(systemName: "pause.circle")
                .foregroundColor(Color.DodgerBlue)
                .font(.system(size: 75))
                .onTapGesture {
                    self.timerViewModel.pressPause()
                    if self.timerViewModel.getChosenSound() != "None" {
                        self.timerViewModel.audioPlayer.pause()
                    }
                }
                .accessibilityIdentifier("pause.circle")

            // cancel button
            Image(systemName: "xmark.circle")
                .font(.system(size: 75))
                .foregroundColor(Color.ImperialRed)
                .onTapGesture {
                    appState.rootViewId = UUID()
                    if self.timerViewModel.getChosenSound() != "None" {
                        self.timerViewModel.audioPlayer.stop()
                    }
                }
                .accessibilityIdentifier("cancel.circle")
        }
    }
}

//struct TimerButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerButtonsView()
//    }
//}
