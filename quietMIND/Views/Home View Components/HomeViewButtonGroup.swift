//
//  HomeViewButtonGroup.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/23/23.
//

import SwiftUI

struct HomeViewButtonGroup: View {
    
    @State var secondScreenShown = false
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        Group {
            NavigationButton(
                action: {self.timerViewModel.setInitTime()},
                destination: {
                    TimerViewScreen(
                        timerScreenShown: $secondScreenShown, timerViewModel: timerViewModel
                    )
                },
                label: { Text("Start Session")})
                    .padding(.top, 10)
        } // third group
    }
}

struct HomeViewButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewButtonGroup()
    }
}
