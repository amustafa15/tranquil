//
//  HomeViewRoundedRect.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/23/23.
//

import SwiftUI

struct HomeViewRoundedRect: View {
    
//    @State var secondScreenShown = false
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.RectangleOverlay)
            .frame(width: 350, height:300)
            .opacity(0.90)
            .overlay(
                VStack {
                    HomeViewMinutesPicker().environmentObject(timerViewModel)
                    HomeViewSoundsPicker().environmentObject(timerViewModel)
                    HomeViewButtonGroup().environmentObject(timerViewModel)
                }
        ) // rectangle.overlay()
    }
}

struct HomeViewRoundedRect_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRoundedRect()
    }
}
