//
//  InitialViewStartBtn.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 3/8/23.
//

import SwiftUI

struct InitialViewStartBtn: View {
    
    @EnvironmentObject var timerViewModel: TimerViewModel
//    @State var secondScreenShown = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        WatchNavButton(
            action: {self.timerViewModel.setInitTime()},
            destination: {
                WatchTimerViewScreen(timerViewModel: timerViewModel)
                    .environmentObject(appState)
            },
            label: {
                Text("Go")
            }
        )
//        .background(Color.orange)
        
//        NavigationLink(
//            destination: WatchTimerViewScreen(timerViewModel: timerViewModel)
//                    .environmentObject(timerViewModel)
//                    .environmentObject(appState),
////            isActive: $secondScreenShown,
//            label: {Text("Go")})
//                .frame(width: 150, height: 20, alignment: .center)
//                .buttonStyle(PlainButtonStyle())
//                .foregroundColor(Color.ColorPrimary)
//                .overlay(
//                    Capsule(style: .continuous)
//                        .stroke(Color.ColorPrimary, lineWidth: 1)
//                        .frame(width: 150, height: 40, alignment: .center)
//                )
    }
}

struct InitialViewStartBtn_Previews: PreviewProvider {
    static var previews: some View {
        InitialViewStartBtn()
    }
}
