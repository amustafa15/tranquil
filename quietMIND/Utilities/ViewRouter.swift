//
//  ViewRouter.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 3/15/22.
//

import Foundation
import SwiftUI

class ViewRouter: ObservableObject {
    
    init(){
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            currentPage = "onboardingView"
        } else {
            currentPage = "contentView"
        }
    }

    @Published var currentPage: String
}
