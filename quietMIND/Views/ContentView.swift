//
//  ContentView.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/15/22.
//

import SwiftUI
import UIKit
import NavigationStack
import Foundation


struct ContentView: View {

    static let id = String(describing: Self.self)
    
    @State private var selectedTab = 0
    let numTabs = 2
    let minDragTranslationForSwipe: CGFloat = 50
    @State var secondScreenShown = true

    @State private var tabSelection = 0
    @State private var tappedTwice:Bool = false
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
                    .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            }
            .tabItem {
              Label("Home", systemImage: "house.fill")
            }
            .tag(0)
//            .id(homeID)
            .id(appState.rootViewId)
            .navigationViewStyle(StackNavigationViewStyle())

            .onChange(of: tappedTwice, perform: { tappedTwice in
                guard tappedTwice else { return }
//                homeID = UUID()
                appState.rootViewId = UUID()
                self.tappedTwice = false
            })

            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "heart.circle.fill")
                }.tag(1)
                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            
            ProfileView(themeVM: self.themeVM)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }.tag(2)
                .highPriorityGesture(DragGesture().onEnded({self.handleSwipe(translation: $0.translation.width)}))
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
//        .accentColor(UserDefaults.standard.bool(forKey: "isSerialKiller") == true ? Color.ui.ImperialRed : Color.ui.DodgerBlue)
        .accentColor(Color.ColorPrimary)
    }

    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslationForSwipe && selectedTab > 0 {
            selectedTab -= 1
        } else  if translation < -minDragTranslationForSwipe && selectedTab < numTabs-1 {
            selectedTab += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
