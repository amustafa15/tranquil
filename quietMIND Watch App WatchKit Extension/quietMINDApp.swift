//
//  quietMINDApp.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 1/15/22.
//

import SwiftUI

@main
struct quietMINDApp: App {
    
    @ObservedObject var appState = AppState()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(appState)
            }
        }

 //       WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
