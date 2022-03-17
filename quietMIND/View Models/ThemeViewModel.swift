//
//  ProfileViewModel.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 3/15/22.
//

import Foundation
import SwiftUI
import Combine

class ThemeViewModel: ObservableObject {
    
    @AppStorage("isSerialKiller") private var isSerialKiller: Bool = false
    
    func setAppTheme(colorScheme: ColorScheme){
//        colorScheme == .dark ? isSerialKiller = true : isSerialKiller = false
        if (colorScheme == .dark) {
            isSerialKiller = true
        } else {
            isSerialKiller = false
        }
        changeDarkMode(state: isSerialKiller)
    }
    
    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultUtils.shared.setDarkMode(enable: state)
    }
}

