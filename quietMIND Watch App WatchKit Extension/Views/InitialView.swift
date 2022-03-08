//
//  SetupView.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 1/17/22.
//

import SwiftUI
import Foundation
import CoreData
import WatchKit

struct InitialView: View {
    
    @State var secondScreenShown = false
    @ObservedObject var timerViewModel: TimerViewModel
    @EnvironmentObject var appState: AppState
    
    init(){
        self.timerViewModel = TimerViewModel()
    }
    
    var body: some View {
        
            VStack {
                VStack {
                    // forEach causes issues w/ state
                    Picker(selection: self.$timerViewModel.timerModel.timerVal, label: Text("How many minutes?")) {
                        /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                        /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                        Text("3").tag(3)
                        Text("4").tag(4)
                        Text("5").tag(5)
                        Text("10").tag(10)
                        Text("15").tag(15)
                        Text("20").tag(20)
                        Text("30").tag(30)
                        Text("60").tag(60)
                    }
                    .foregroundColor(Color.ui.DodgerBlue)
                    .pickerStyle(.wheel)
                
                    Picker(selection: self.$timerViewModel.timerModel.chosenSound, label: Text("Background sounds")) {
                        Text("None").tag("None")
                        Text("Light Rain").tag("Light Rain")
                        Text("Spring Forest").tag("Spring Forest")
                        Text("Relaxing Beach").tag("Relaxing Beach")
                    }
                    .foregroundColor(Color.ui.DodgerBlue)
                    .pickerStyle(.wheel)
                }
                
                VStack {
                    NavigationLink(
                        destination: TimerView(timerViewModel: self.timerViewModel)
                                .environmentObject(appState),
                        isActive: $secondScreenShown,
                        label: {Text("Go")})
                            .frame(width: 150, height: 20, alignment: .center)
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(Color.ui.DodgerBlue)
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(Color.ui.DodgerBlue, lineWidth: 1)
                                    .frame(width: 150, height: 40, alignment: .center)
                            )
                }
                .padding(.top, 10)
                .frame(width: 150, height: 30, alignment: .center)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .padding()
    }
}


