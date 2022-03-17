//
//  SceneDelegate.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/15/22.
//

import UIKit
import SwiftUI
import NavigationStack

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @ObservedObject var appState = AppState()
    
//    var coreDataStack = CoreDataStack(containerName: "UserStats")

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // this may not be necessary
//    coreDataStack.viewContext.automaticallyMergesChangesFromParent = true
        
//        let contentView = ContentView()
//            .environmentObject(appState)
//            .environmentObject(NavigationModel(silenceErrors: true))
//            .environment(\.managedObjectContext, coreDataStack.viewContext)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = UIHostingController(rootView: contentView)
            window.rootViewController = UIHostingController(rootView: MotherView().environmentObject(ViewRouter()))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
