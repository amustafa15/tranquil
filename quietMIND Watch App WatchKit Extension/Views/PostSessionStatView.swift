//
//  PostSessionView.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 1/17/22.
//

import SwiftUI
import WatchKit
import CoreData
import Foundation

struct PostSessionStatView: View {
    
    @StateObject var vm = CoreDataStackRelationshipViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
            VStack {
                
                Text("Way to go!!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                Text("You are on a \(vm.getDates()) day streak!")
                    .multilineTextAlignment(.center)
                
                vm.getDatesLong() == 1 ?
                    Text("Your longest streak is \(vm.getDatesLong()) day")
                        .multilineTextAlignment(.center)
                    : Text("Your longest streak is \(vm.getDatesLong()) days")
                        .multilineTextAlignment(.center)
                
                NavigationLink(
                    destination: InitialView().environmentObject(appState),
                    label: {Text("Home")}
                )
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(Color.ColorPrimary)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color.ColorPrimary, lineWidth: 1)
                        .frame(width: 150, height: 30, alignment: .center)
                )
                .padding(.top, 10)
                .onTapGesture{
                    appState.rootViewId = UUID()
                }
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.move(edge: .top)
    }
}
