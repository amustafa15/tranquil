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

// this is the parent view of all time components
struct TimerViewScreen: View {
    
    @Binding var timerScreenShown:Bool

    // instead of observedobject?
    // observedobject is recreated when the view is discarded
    // stateobject remains even after view is discarded
    @StateObject var timerViewModel: TimerViewModel
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            TimerRoundedRectView().environmentObject(timerViewModel)
            
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
