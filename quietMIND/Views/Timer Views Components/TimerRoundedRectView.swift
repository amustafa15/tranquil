//
//  TimerRoundedRectView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/22/23.
//

import SwiftUI

struct TimerRoundedRectView: View {
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.RectangleOverlay)
                .frame(width: 350, height: 325)
                .opacity(0.75)
                .padding()
                .overlay (
                    TimerView().environmentObject(timerViewModel)
                )
        } // VStack 2
        .frame(
            minWidth: UIScreen.main.bounds.width,
            maxWidth: .infinity,
            minHeight: UIScreen.main.bounds.height,
            maxHeight: .infinity,
            alignment: .center
        )
    }
}

struct TimerRoundedRectView_Previews: PreviewProvider {
    static var previews: some View {
        TimerRoundedRectView()
    }
}
