//
//  TimerView.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 1/17/22.
//

import SwiftUI
import Foundation
import WatchKit
import CoreData
import AVFoundation

struct WatchTimerViewScreen: View {
    
//    @EnvironmentObject var timerViewModel: TimerViewModel
    @StateObject var timerViewModel: TimerViewModel
    @EnvironmentObject var appState: AppState
    
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        
        VStack {
            if timerViewModel.timerModel.timerVal > 0 {
                Text(timerViewModel.timeString(time: timerViewModel.getTimerVal()))
                    .font(.system(size: 55))
                    .onReceive(timerViewModel.timer) { _ in
                        timerViewModel.startTimer()
                    }
                    .onAppear(){
//                        self.timerViewModel.timerModel.timerVal *= 60
                        self.timerViewModel.playSounds(self.timerViewModel.getChosenSound())
//                        self.timerViewModel.setInitTime()
                    }
                
                WatchTimerViewBtns().environmentObject(timerViewModel)
                
            } else {
                PostTimerWatchView()
                    .environmentObject(timerViewModel)
//                    .environmentObject(appState)
            } // else
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
