//
//  TimerView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/22/23.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            // modularize it?
            // should probably look into this and see if logic can be moved to vm
            if timerViewModel.timerModel.timerVal > 0 {
                Text(timerViewModel.timeString(time: timerViewModel.getTimerVal()))
                    .font(.system(size: 90))
                    .foregroundColor(Color.ColorPrimary)
                    .onReceive(timerViewModel.timer) { _ in
                        timerViewModel.startTimer()
                    }
                    .onAppear(){
                        // should this be here or in view model?
//                        self.timerViewModel.timerModel.timerVal *= 60
                        // this does seconds to minutes
                        
                        self.timerViewModel.playSounds(self.timerViewModel.getChosenSound())
                    }
                TimerButtonsView().environmentObject(timerViewModel)
                    
            } else {
                PostTimerView().environmentObject(timerViewModel)
                
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
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
