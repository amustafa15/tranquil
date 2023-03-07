//
//  PostTimerView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/22/23.
//

import SwiftUI

struct PostTimerView: View {
    
    var quotes = QuotesController()
    // how should this be passed?
    // SO does not recreate when view is discarded
    // does it matter?
    // this explains why it updates from this user flow vs tab bar user flow
    @StateObject var vm = CoreDataStackRelationshipViewModel()
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var appState: AppState
    @State private var isSerialKiller = UserDefaults.standard.bool(forKey: "isSerialKiller")
    
    var body: some View {
        Text("\(quotes.returnQuote()[0])")
            .padding()
            .font(.system(size: 20))
            .padding(.bottom, -15)
            .onAppear() {
                timerViewModel.audioPlayer?.stop()
                vm.addTodaysSession(Double(self.timerViewModel.getInitialTime()))
                timerViewModel.playSounds("ding")
            }
        Text("- \(quotes.returnQuote()[1])")
            .padding(.bottom, 5)
            .font(.system(size: 23))
            .frame(alignment: .trailing)
            .accessibilityIdentifier("quoteText")
        
        NavigationButton(
            action: {appState.rootViewId = UUID()},
            destination: {HomeView()},
            label: {Text("Home Page")})
                .padding(.top, 35)
                .accessibilityIdentifier("PostStatsHomeBtn")

        NavigationButton(
            action: {},
            destination: {StatsView()},
            label: {Text("Stats Page")})
                .padding(.top, 5)
                .accessibilityIdentifier("PostStatsStatsBtn")

    }
}

//struct PostTimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostTimerView()
//    }
//}
