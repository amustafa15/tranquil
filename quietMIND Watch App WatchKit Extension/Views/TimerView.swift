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

struct TimerView: View {
    
    var quotes = Quotes()
    
    @StateObject var vm = CoreDataStackRelationshipViewModel()
    @ObservedObject var timerViewModel: TimerViewModel
    @EnvironmentObject var appState: AppState

    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        
        VStack {
            if timerViewModel.timerModel.timerVal > 0 {
                Text(timerViewModel.timeString(time: timerViewModel.getTimerVal()))
                    .font(.system(size: 55))
                    .onReceive(timer) { _ in
                        timerViewModel.startTimer()
                    }
                    .onAppear(){
                        self.timerViewModel.timerModel.timerVal *= 60
                        self.timerViewModel.playSounds(self.timerViewModel.getChosenSound())
                        self.timerViewModel.setInitTime()
                    }
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
                }
            } else {
                VStack {
                    
                    Text("\(quotes.getQuote()[0])")
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.75)
                    
                    Text("\(quotes.getQuote()[1])")
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(
                        destination: PostSessionStatView().environmentObject(appState),
                        label: {Text("Good Job!")})
                        .frame(minWidth: 0,maxWidth: 100, alignment: .bottom)
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color.ColorPrimary)
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color.ColorPrimary, lineWidth: 1)
                                .frame(width: 150, height: 30, alignment: .center)
                        )
                        .padding(.top, 10)
                        .onAppear() {
                            timerViewModel.audioPlayer?.stop()
                            vm.addTodaysSession(Double(self.timerViewModel.getInitialTime()))
                            timerViewModel.playSounds("ding")
                        }
                    }
                } // else
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
