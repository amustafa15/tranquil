//
//  OnboardingPopupView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/23/23.
//

import SwiftUI

struct OnboardingPopupView: View {
    
    @State private var pressed = false
    
    var body: some View {
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
    }
}

struct OnboardingPopupView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPopupView()
    }
}
