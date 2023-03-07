//
//  StatsInfoView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/22/23.
//

import SwiftUI

struct StatsInfoView: View {
    
    // state object is not destroyed when view is discarded
    // this may be why stats view does not show updated info
    // observedobject is destroyed when view is discarded so
    // that means recreating it which means it should be updated?
    // so maybe create as OO in parent view then pass it as environmentalObject?
    // lets try
    
//    @StateObject var vm = CoreDataStackRelationshipViewModel()
    
    @EnvironmentObject var vm: CoreDataStackRelationshipViewModel
    
    var body: some View {
        
        Text("Total mindful minutes: \(String(format: "%.0f", vm.getTotalMinutes()))")
            .accessibilityIdentifier("mindfulMinutes")
        Text("Total mindful sessions: \(String(format: "%.0f", vm.getTotalSessions()))")
            .accessibilityIdentifier("mindfulSessions")
        Text("current streak: \(vm.getDates()) days")
        Text("longest streak: \(vm.getDatesLong()) days")
        
    }
}

struct StatsInfoView_Previews: PreviewProvider {
    static var previews: some View {
        StatsInfoView()
    }
}
