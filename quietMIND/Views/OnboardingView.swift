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
                    Text("welcome to tranquil!")
                        .font(.largeTitle)
                        .padding(.bottom, 15)
                    Text("when we made tranquil we had one goal in mind - to create a meditation app for everyone. in order to provide you with the optimal experience we have to ask a few personal questions")
                        .frame(
                            width: 345,
                            alignment: .center
                        )
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 15)
                    
                    Button(action: {
                        pressed = true
                    }) {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Sounds good!")
                            Spacer()
                        }
                    }
                    .foregroundColor(Color.DodgerBlue)
                    .font(.system(size: 22))
                    .padding()
                    .frame(width: 250, height: 40, alignment: .center)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.ImperialRed, lineWidth: 3)
                    )
                } else {
                    Text("Are you a serial killer?")
                        .font(.title)
                    HStack { // yes/no butttons HStacks
    //                    Button(action: goHome) {
                        Button(action: {
                            themeVM.setAppTheme(colorScheme: .dark)
                            saveChoice(isSerialKillerClicked: true)
                            goHome()
                        }) {
                            HStack(alignment: .center) {
                                Spacer()
                                Text("Yes")
                                Spacer()
                            }
                        }
                        .foregroundColor(Color.ImperialRed)
                        .font(.title2)
                        .padding()
                        .frame(width: 150, height: 40, alignment: .center)
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color.ImperialRed, lineWidth: 3)
                        )
                        
    //                    Button(action: goHome) {
                        Button(action: {
                            themeVM.setAppTheme(colorScheme: .light)
                            saveChoice(isSerialKillerClicked: false)
                            goHome()
                        }) {
                            HStack(alignment: .center) {
                                Spacer()
                                Text("No")
                                Spacer()
                            }
                        }
                        .foregroundColor(Color.DodgerBlue)
                        .font(.title2)
                        .padding()
                        .frame(width: 150, height: 40, alignment: .center)
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color.DodgerBlue, lineWidth: 3)
                        )
                        
                    } // yes/no button hstack
                    .frame(width: 350, height: 60, alignment: .center)
                    HStack { // "don't worry" text Hstack
                        Text("Don't worry you can change your legally binding answer on the Profile Page")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .frame(width: 325, alignment: .center)
                    } // "don't worry" text Hstack
                    .frame(width: 350, alignment: .center)
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
//        .opacity(0.25)
    }
    
    func goHome() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(appState))
            window.makeKeyAndVisible()
        }
    }
    
    func saveChoice(isSerialKillerClicked: Bool) {
        self.isSerialKiller = isSerialKillerClicked
        UserDefaults.standard.set(self.isSerialKiller, forKey: "isSerialKiller")
    }
    
    
}
