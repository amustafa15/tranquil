//
//  HomeView.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/16/22.
//

import SwiftUI
import CoreData
import Foundation
import NavigationStack
import Combine

struct HomeView: View {

    @State var secondScreenShown = false

    @ObservedObject var timerViewModel: TimerViewModel

    init() {
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        UITableView.appearance().tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        self.timerViewModel = TimerViewModel()
    }

    var body: some View {
            VStack {
                VStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.ui.RectangleOverlay)
                        .frame(width: 350, height:300)
                        .opacity(0.90)
                        .overlay(
                            VStack {
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
                                                    }
                                                } // picker
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


                                Group {
                                    VStack {
                                        Section(header: HStack {
                                            Text("Any Background Sounds?")
                                                .font(.title2)

                                                .padding(.bottom, 0)
                                                .padding(.leading, 30)
                                            Spacer()
                                        }
                                        .listRowInsets(EdgeInsets(
                                            top: 0,
                                            leading: 0,
                                            bottom: 0,
                                            trailing: 0))
                                        ) {
                                            Form {
                                                Picker(selection: self.$timerViewModel.timerModel.chosenSound, label: Text("What will you listen to?")) {
                                                    ForEach(self.timerViewModel.getSounds(), id: \.self) { sound in
                                                        Text("\(sound)")
                                                    }
                                                } // picker
                                            } // form
                                            .frame(width:350, height: 45)
                                            .padding(.top, 0)
                                        } // section callback
                                    }
                                } // second group

                                Group {
                                    
                                    NavigationButton(
                                        action: {},
                                        destination: {TimerView( timerScreenShown: $secondScreenShown, timerViewModel: self.timerViewModel)
                                        },
                                        label: { Text("Start Session")})
                                            .padding(.top, 10)
                                } // third group
                            }
                    ) // rectangle.overlay()
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
