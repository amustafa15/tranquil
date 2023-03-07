//
//  OnboardingQuestionView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/23/23.
//

import SwiftUI

struct OnboardingQuestionView: View {
    
    @EnvironmentObject var themeVM: ThemeViewModel
    @State var isSerialKiller = false
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Text("Are you a serial killer?")
            .font(.title)
        // modularize this?
        HStack { // yes/no butttons HStacks
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
    }
}

extension OnboardingQuestionView {
    public func goHome() {
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

//struct OnboardingQuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingQuestionView()
//    }
//}
