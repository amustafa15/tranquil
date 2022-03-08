//
//  StatsView.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/15/22.
//

import SwiftUI
import CoreData
import UIKit

struct StatsView: View {
    
    @StateObject var vm = CoreDataStackRelationshipViewModel()
    @State var progressValue: Float = 0.00
    
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        
        ScrollView {
            VStack { // VStack1
                    VStack { // vstack0
                        VStack {
                            Text("Total mindful minutes: \(String(format: "%.0f", vm.getTotalMinutes()))")
                            Text("Total mindful sessions: \(String(format: "%.0f", vm.getTotalSessions()))")
                            Text("current streak: \(vm.getDates()) days")
                            Text("longest streak: \(vm.getDatesLong()) days")
                        }
                        .padding()
                            
                        VStack {
                            Text("CURRENT DAILY STREAK MILESTONES")
                                .font(.system(size: 20))

                            ForEach(0..<Milestones.init().milestonesArray.count/3 ) { row in
                                HStack {
                                    ForEach(0..<3) { column in
                                        CurrentProgressBar(currentStreak: vm.getDates(), selectedMilestones: Milestones.init().milestonesArray[row * 3 + column], progress: self.progressValue)
                                            .frame(
//                                                maxWidth: .infinity,
//                                                maxHeight: .infinity,
                                                // ^^^^ ????
                                                alignment: .center
                                            )
                                            .padding(15.0)
                                    }
                                }
                            }
                        } // current streak vstack

                        VStack {
                            Text("LONGEST STREAK MILESTONES")
                                .font(.system(size: 20))
//                                .foregroundColor(.black)
                            ForEach(0..<Milestones.init().milestonesArray.count/3) { row in
                                HStack {
                                    ForEach(0..<3) { column in
                                        MilestoneProgressBar(currentStreak: vm.getDatesLong(), selectedMilestones: Milestones.init().milestonesArray[row * 3 + column], progress: self.progressValue)
                                            .frame(
//                                                maxWidth: .infinity,
//                                                maxHeight: .infinity,
                                                // ^^^^ ????
                                                alignment: .center
                                            )
                                            .padding(15.0)
                                    }
                                }
                            }
                        } // milestone vstack
                    } // vstack0
                    .frame(
                        minWidth: UIScreen.main.bounds.width,
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .top
                    )
                    .background(Color.ui.RectangleOverlay.opacity(0.55))
                    .padding()
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button(action : {
                        appState.rootViewId = UUID()
                    }){
                        Image(systemName: "arrow.left")
                    })
            } // vstack1
            .frame(
                minWidth: UIScreen.main.bounds.width,
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .padding(.top, 65)
            .padding(.bottom, 100)
        } // scrollview
        .edgesIgnoringSafeArea([.top, .bottom])
        .background(
            Image("StatsPageBackground")
                .resizable()
                .ignoresSafeArea()
        )
    } // view
}

struct CurrentProgressBar: View {

    @State var currentStreak: Int
    @State var selectedMilestones: Int
    @State var progress: Float

    init(currentStreak: Int, selectedMilestones: Int, progress: Float){

        self.currentStreak = currentStreak
        self.selectedMilestones = selectedMilestones
        var convertedFloat = Float(currentStreak) / Float(selectedMilestones)
        self.progress = convertedFloat
    }

    var body: some View {
        
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20.0)
                        .opacity(0.3)
                        .foregroundColor(Color.ui.ImperialRed)

                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.ui.DodgerBlue)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: 1)

                    if currentStreak < selectedMilestones {
                        Text("\(currentStreak)/\(selectedMilestones) days")
                            .font(.system(size: 12))
                    } else {
                        Text("\(selectedMilestones) days 🏆")
                            .font(.system(size: 12))
                    }
                }
                .frame(
                    minWidth: 90,
                    maxWidth: .infinity,
                    minHeight: 90,
                    maxHeight: .infinity,
                    alignment: .center
                )
        }
    }

struct MilestoneProgressBar: View {
    
    @State var currentStreak: Int
    @State var selectedMilestones: Int
    @State var progress: Float

    init(currentStreak: Int, selectedMilestones: Int, progress: Float){
        self.currentStreak = currentStreak
        self.selectedMilestones = selectedMilestones
        var convertedFloat = Float(currentStreak) / Float(selectedMilestones)
        self.progress = convertedFloat
    }

    var body: some View {
        
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20.0)
                        .opacity(0.3)
                        .foregroundColor(Color.ui.ImperialRed)

                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.ui.DodgerBlue)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: 1)

                    if currentStreak < selectedMilestones {
                        Text("\(currentStreak)/\(selectedMilestones) days")
                            .font(.system(size: 12))
                    } else {
                        Text("\(selectedMilestones) days 🏆")
                            .font(.system(size: 12))
                    }
                }.frame(
                    minWidth: 90,
                    maxWidth: .infinity,
                    minHeight: 90,
                    maxHeight: .infinity,
                    alignment: .center
                )
        }
}
