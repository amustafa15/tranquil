//
//  ProfileView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 3/15/22.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    @AppStorage("isSerialKiller") private var isSerialKiller: Bool = false // @AppStorage syncs this value with UserDefaults automatically
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
//    @State private var isDarkModeOn = false
    @ObservedObject var themeVM: ThemeViewModel
    @State private var showText = false
    
    
    var body: some View {
        VStack { // vstack 0
            Text("Profile Page")
                .font(.largeTitle)
            
            VStack { // vstack 1
                Toggle("Are you a serial killer or are you a liar?", isOn: $isSerialKiller)
                    .frame(
                        width: 350,
                        height: 75,
                        alignment: .center
                    )
                    .font(.system(size: 18))
//                    .multilineTextAlignment(.center)
//                    .onChange(of: isSerialKiller) { (state) in
//                        themeVM.changeDarkMode(state: state)
//                    }
                    .onChange(of: isSerialKiller, perform: { value in
                        themeVM.changeDarkMode(state: isSerialKiller)
                        showText = true // Once the toggle is interacted with, set showText to true
                    })
                    .toggleStyle(SwitchToggleStyle(tint: Color.ImperialRed))
                
                if showText {
                    Text( isSerialKiller ? "Thank you for being honest. Your FBI file has been updated!" : "Lying to the FBI is a criminal offense. Your FBI file has been updated!" )
                        .multilineTextAlignment(.center)
                }
                
            } // vstack 1
            .frame(
                width: 350,
//                height: UIScreen.main.bounds.height - 250,
                alignment: .center
            )
        } // vstack 0
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height - 200,
            alignment: .top
        )
        .onAppear(perform: {
            themeVM.setAppTheme(colorScheme: colorScheme)
        })
    }
}
