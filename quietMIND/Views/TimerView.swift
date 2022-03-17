//
//  TimerView.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/16/22.
//

import SwiftUI
import CoreData
import AVFoundation
import Foundation
import NavigationStack


struct TimerView: View {
    
    @Binding var timerScreenShown:Bool
    var quotes = Quotes()

    @StateObject var vm = CoreDataStackRelationshipViewModel()
    @ObservedObject var timerViewModel: TimerViewModel
    @State private var isSerialKiller = UserDefaults.standard.bool(forKey: "isSerialKiller")
    
    @EnvironmentObject var appState: AppState
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            VStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.RectangleOverlay)
                    .frame(width: 350, height: 325)
                    .opacity(0.75)
                    .padding()
                    .overlay (
                        VStack {
                            if timerViewModel.timerModel.timerVal > 0 {
                                Text(timerViewModel.timeString(time: timerViewModel.getTimerVal()))
                                    .font(.system(size: 90))
//                                    .foregroundColor(UserDefaults.standard.bool(forKey: "isSerialKiller") == true ? Color.ui.ImperialRed : Color.ui.DodgerBlue)
                                    .foregroundColor(Color.ColorPrimary)
                                    .onReceive(timer) { _ in
                                        timerViewModel.startTimer()
                                    }
                                    .onAppear(){
                                        self.timerViewModel.timerModel.timerVal *= 60
                                        // this does seconds to minutes
                                        self.timerViewModel.playSounds(self.timerViewModel.getChosenSound())
                                        self.timerViewModel.setInitTime()
                                    }
                                
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
                                    : Image(systemName: "pause.circle")
                                        .foregroundColor(Color.DodgerBlue)
                                        .font(.system(size: 75))
                                        .onTapGesture {
                                            self.timerViewModel.pressPause()
                                            if self.timerViewModel.getChosenSound() != "None" {
                                                self.timerViewModel.audioPlayer.pause()
                                            }
                                        }

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
                                }
                            } else {
                                Text("\(quotes.getQuote(self.isSerialKiller)[0])")
                                    .padding()
                                    .font(.system(size: 20))
                                    .padding(.bottom, -15)
                                    .onAppear() {
                                        timerViewModel.audioPlayer?.stop()
                                        vm.addTodaysSession(Double(self.timerViewModel.getInitialTime()))
                                        timerViewModel.playSounds("ding")
                                    }
                                Text("\(quotes.getQuote(self.isSerialKiller)[1])")
                                    .padding(.bottom, 5)
                                    .font(.system(size: 23))
                                    .frame(alignment: .trailing)
                                
                                NavigationButton(
                                    action: {appState.rootViewId = UUID()},
                                    destination: {HomeView()},
                                    label: {Text("Home Page")})
                                        .padding(.top, 35)

                                NavigationButton(
                                    action: {},
                                    destination: {StatsView()},
                                    label: {Text("Stats Page")})
                                        .padding(.top, 5)
                                
                                } // else
                        } // innermost VStack
                        .frame(
                            alignment: .center
                        )
                        .padding()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: Button(action : {
                            appState.rootViewId = UUID()
                        }){
                            Image(systemName: "arrow.left")
                        })
                )
            } // VStack 2
            .frame(
                minWidth: UIScreen.main.bounds.width,
                maxWidth: .infinity,
                minHeight: UIScreen.main.bounds.height,
                maxHeight: .infinity,
                alignment: .center
            )
            
        } // VStack
        .edgesIgnoringSafeArea([.top, .bottom])
        .background(
            Image("HomePageBackground")
                .resizable()
                .ignoresSafeArea()
        )
        .frame(
            minWidth: UIScreen.main.bounds.width,
            maxWidth: .infinity,
            minHeight: UIScreen.main.bounds.height,
            maxHeight: .infinity,
            alignment: .center
        )
        
        .onAppear(){
            UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
            UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        }
    } // View
}
