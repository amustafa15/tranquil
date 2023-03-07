//
//  CurrentStreakView.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/22/23.
//

import SwiftUI

struct CurrentStreakView: View {
    
//    @StateObject var vm = CoreDataStackRelationshipViewModel()
    @EnvironmentObject var vm: CoreDataStackRelationshipViewModel
    @State var progressValue: Float = 0.00
    
    var body: some View {
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
    }
}

struct CurrentStreakView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStreakView()
    }
}
