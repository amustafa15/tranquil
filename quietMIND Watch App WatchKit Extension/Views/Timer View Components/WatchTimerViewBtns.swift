//
//  WatchTimerViewBtns.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 3/8/23.
//

import SwiftUI

struct WatchTimerViewBtns: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        HStack {
            // paused
            self.timerViewModel.getPaused() == true ?
                Image(systemName: "play.circle")
                    .foregroundColor(Color.DodgerBlue)
                    .font(.system(size: 45))
                    .onTapGesture {
                        self.timerViewModel.pressPause()
                        if self.timerViewModel.getChosenSound() != "None" {
                            self.timerViewModel.audioPlayer.play()
                        }
                    }
                    .accessibilityIdentifier("play.circle")
            :
                Image(systemName: "pause.circle")
                    .foregroundColor(Color.DodgerBlue)
                    .font(.system(size: 45))
                    .onTapGesture {
                        self.timerViewModel.pressPause()
                        if self.timerViewModel.getChosenSound() != "None" {
                            self.timerViewModel.audioPlayer.pause()
                    }
                }
                .accessibilityIdentifier("pause.circle")
            
            // cancel button
            Image(systemName: "xmark.circle")
                .font(.system(size: 45))
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

struct WatchTimerViewBtns_Previews: PreviewProvider {
    static var previews: some View {
        WatchTimerViewBtns()
    }
}
