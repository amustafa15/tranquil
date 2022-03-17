//
//  MotherView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 3/15/22.
//

import Foundation
import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var appState = AppState()
    
    var body: some View {
        VStack {
            if viewRouter.currentPage == "onboardingView" {
                OnboardingView()
            } else if viewRouter.currentPage == "contentView" {
//                OnboardingView()
                ContentView()
                    .environmentObject(appState)
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
