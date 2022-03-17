//
//  UserDefaultUtils.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 3/15/22.
//

import Foundation

class UserDefaultUtils {
    
    static var shared = UserDefaultUtils()
    
    func setDarkMode(enable: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(enable, forKey: Constants.DARK_MODE)
    }
    
    func getDarkMode() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Constants.DARK_MODE)
    }
}
