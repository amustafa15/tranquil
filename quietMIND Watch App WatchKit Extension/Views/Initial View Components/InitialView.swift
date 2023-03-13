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
    
//    @State var secondScreenShown = false
    @ObservedObject var timerViewModel: TimerViewModel
    @EnvironmentObject var appState: AppState
    
    init(){
        self.timerViewModel = TimerViewModel()
    }
    
    var body: some View {
            VStack {
                VStack {
                    InitialViewTimePicker().environmentObject(timerViewModel)
                    InitialViewSoundPicker().environmentObject(timerViewModel)
                }
                
                VStack {
                    InitialViewStartBtn().environmentObject(timerViewModel).environmentObject(appState)
                }
//                .background(Color.pink)
                .padding(.top, 20)
                .frame(width: 150, height: 30, alignment: .center)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .padding()
    }
}


