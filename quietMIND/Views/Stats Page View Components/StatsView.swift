//
//  StatsView.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/15/22.
//

import SwiftUI
import UIKit

struct StatsView: View {
    
    // should there be like an environmental or observed object or something?
    // that way it is passed to all views?
    // probably
    // let's try that
    @ObservedObject var vm = CoreDataStackRelationshipViewModel()
    
    var body: some View {
        
        ScrollView {
            VStack { // VStack1
                StatsParentView().environmentObject(vm)
            } // vstack1
            .frame(
                minWidth: UIScreen.main.bounds.width,
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .padding(.top, 65)
            .padding(.bottom, 100)
        } // scrollview
        .edgesIgnoringSafeArea([.top, .bottom])
        .background(
            Image("StatsPageBackground")
                .resizable()
                .ignoresSafeArea()
        )
    } // view
}



