//
//  HomeView.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/16/22.
//

import SwiftUI
import CoreData
import Foundation

struct HomeView: View {

//    @State var secondScreenShown = false
//    @State private var isSerialKiller = UserDefaults.standard.bool(forKey: "isSerialKiller")
    
    // state object?
    @ObservedObject var timerViewModel: TimerViewModel

    init() {
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        self.timerViewModel = TimerViewModel()
    }

    var body: some View {
            VStack {
                VStack {
                    HomeViewRoundedRect().environmentObject(timerViewModel)
                } // VStack just outside rectangle
                .frame(
                    maxWidth: .infinity,
                    minHeight: UIScreen.main.bounds.height,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .padding()
            } // VStack
            .edgesIgnoringSafeArea([.top, .bottom])
            .background(
                Image("HomePageBackground")
                    .resizable()
                    .ignoresSafeArea()
            )
            .frame(
                minWidth: UIScreen.main.bounds.width,
                maxWidth: .infinity,
                minHeight: UIScreen.main.bounds.height,
                maxHeight: .infinity,
                alignment: .center
            )
    }
}
