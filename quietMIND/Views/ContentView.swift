//
//  ContentView.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/15/22.
//

import SwiftUI
import UIKit
import Foundation


struct ContentView: View {

    static let id = String(describing: Self.self)
    @State var secondScreenShown = true

    @State private var tabSelection = 0
    @State private var tappedTwice:Bool = false
    // instead of stateobject?
    @ObservedObject var themeVM: ThemeViewModel
    
    var handler: Binding<Int> { Binding (
        get: {self.tabSelection},
        set: {
            if $0 == self.tabSelection {
                tappedTwice = true
            }
            self.tabSelection = $0
        }
    )}
    
    @EnvironmentObject var appState: AppState

    let appearance: UITabBarAppearance = UITabBarAppearance()

    init() {
        UITabBar.appearance().scrollEdgeAppearance = appearance
        self.themeVM = ThemeViewModel()
    }

    var body: some View {
        TabView(selection:handler) {
            NavigationView {
                HomeView()
            }
            .tabItem {
              Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            .id(appState.rootViewId)
            .navigationViewStyle(StackNavigationViewStyle())

            .onChange(of: tappedTwice, perform: { tappedTwice in
                guard tappedTwice else { return }
                appState.rootViewId = UUID()
                self.tappedTwice = false
            })

            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "heart.circle.fill")
                }.tag(1)
            
            ProfileView(themeVM: self.themeVM)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }.tag(2)
        }
        .frame(
            minWidth: 90,
            maxWidth: .infinity,
            minHeight: 90,
            maxHeight: .infinity,
            alignment: .center
        )
        .edgesIgnoringSafeArea(.all)
        .frame(
            minWidth: UIScreen.main.bounds.width,
            maxWidth: .infinity,
            minHeight: UIScreen.main.bounds.height,
            maxHeight: .infinity,
            alignment: .center
        )
        .accentColor(Color.ColorPrimary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
