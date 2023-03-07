//
//  CurrentProgressBar.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/22/23.
//

import SwiftUI

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
                        .foregroundColor(Color.ImperialRed)

                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.DodgerBlue)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: 1)

                    // should be in logic? 
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

//struct CurrentProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentProgressBar()
//    }
//}
