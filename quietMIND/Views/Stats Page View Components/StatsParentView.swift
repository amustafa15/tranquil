//
//  StatsParentView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/22/23.
//

import SwiftUI

struct StatsParentView: View {
    
    @EnvironmentObject var appState: AppState
    
    // state object is not destroyed when view is discarded
    // this may be why stats view does not show updated info
    // observedobject is destroyed when view is discarded so
    // that means recreating it which means it should be updated?
    // so create coredatavm here?
    @EnvironmentObject var vm: CoreDataStackRelationshipViewModel
    
    var body: some View {
        VStack { // vstack0
            VStack {
                StatsInfoView().environmentObject(vm)
            }
            .padding()
                
            VStack {
                CurrentStreakView().environmentObject(vm)
            } // current streak vstack

            VStack {
                LongestStreakView().environmentObject(vm)
            } // milestone vstack
        } // vstack0
        .frame(
            minWidth: UIScreen.main.bounds.width,
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .background(Color.RectangleOverlay.opacity(0.55))
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
            appState.rootViewId = UUID()
        }){
            Image(systemName: "arrow.left")
        })
    }
}

struct StatsParentView_Previews: PreviewProvider {
    static var previews: some View {
        StatsParentView()
    }
}
