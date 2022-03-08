//
//  ContentView.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 1/15/22.
//

import SwiftUI
import AVFoundation
import CoreData

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        InitialView()
            .id(appState.rootViewId)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


