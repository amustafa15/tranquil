//
//  PostTimerWatchView.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 3/8/23.
//

import SwiftUI

struct PostTimerWatchView: View {
    
    var quotes = QuotesController()
    @EnvironmentObject var timerViewModel: TimerViewModel
    @EnvironmentObject var appState: AppState
    @StateObject var vm = CoreDataStackRelationshipViewModel()
    
    var body: some View {
        VStack {
            
            Text("\(quotes.returnQuote()[0])")
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.75)
                .onAppear() {
                    timerViewModel.audioPlayer?.stop()
                    vm.addTodaysSession(Double(self.timerViewModel.getInitialTime()))
                    timerViewModel.playSounds("ding")
                }
            
            Text("- \(quotes.returnQuote()[1])")
                .multilineTextAlignment(.center)
                .accessibilityIdentifier("quoteAuthor")
//            WatchNavButton(
//                destination: {PostSessionStatView().environmentObject(appState)},
//                label: {Text("Good Job!")})
//            .background(Color.pink)
            
            NavigationLink(
                destination: PostSessionStatView().environmentObject(appState),
                label: {Text("Good Job!")})
                .frame(minWidth: 0,maxWidth: 100, alignment: .bottom)
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(Color.ColorPrimary)
                .overlay(
                    Capsule(style: .continuous)
                        .stroke(Color.ColorPrimary, lineWidth: 1)
                        .frame(width: 150, height: 30, alignment: .center)
                )
                .padding(.top, 10)
                .accessibilityIdentifier("goodJobBtn")
//
            }
    }
}

struct PostTimerWatchView_Previews: PreviewProvider {
    static var previews: some View {
        PostTimerWatchView()
    }
}
