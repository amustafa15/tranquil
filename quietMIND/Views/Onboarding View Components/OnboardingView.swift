//
//  OnboardingView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 3/15/22.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    
    @ObservedObject var appState = AppState()
    @State var isSerialKiller = false
    @ObservedObject var themeVM: ThemeViewModel
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var pressed = false
    
    init(){
        self.themeVM = ThemeViewModel()
    }
    
    var body: some View {
        VStack { // VStack 0
            VStack { // VStack 1
                if pressed == false {
                    OnboardingPopupView()
                } else {
                    OnboardingQuestionView()
                        .environmentObject(appState)
                        .environmentObject(self.themeVM)
                } // else
            } // VStack 1
            .frame(
                width: 350,
                height: 350,
                alignment: .center
            )
            .background(Color.RectangleOverlay)
            .cornerRadius(25)
        } // VStack 0
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height,
            alignment: .center
        )
        .background(Color.gray)
    }
}
