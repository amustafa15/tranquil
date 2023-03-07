//
//  HomeViewMinutesPicker.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/23/23.
//

import SwiftUI

struct HomeViewMinutesPicker: View {
    
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        
        Group {
            VStack {
                Section(header: HStack {
                    Text("Time in Minutes")
                        .font(.title2)

                        .padding(.bottom, 0)
                        .padding(.leading, 30)
                    Spacer()
                } // section

                .listRowInsets(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 0))
                ) {
                    Form {
                        Picker(selection: self.$timerViewModel.timerModel.timerVal, label: Text("How many minutes?")
                        ) {
                            ForEach(0..<self.timerViewModel.getTimes().count, id: \.self) {
                                Text("\(self.timerViewModel.getTimes()[$0])")
                                    .tag(self.timerViewModel.getTimes()[$0])
                                    .accessibilityIdentifier("\(self.timerViewModel.getTimes()[$0])")
                            }
                        } // picker
                        // to identify picker for testing
                        .accessibilityIdentifier("TimePicker")
                    } // form
                    .frame(width:350, height: 48)
                    .padding(.top, 0)
                    .onAppear {
                        UITableView.appearance().backgroundColor = .clear
                        UITableView.appearance().isScrollEnabled = false
                    }
                } // section callback
            } // ZStack
        } // first group
    }
}

struct HomeViewMinutesPicker_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewMinutesPicker()
    }
}
