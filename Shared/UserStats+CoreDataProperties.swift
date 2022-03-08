//
//  UserStats+CoreDataProperties.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/21/22.
//
//

import Foundation
import CoreData


extension UserStats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserStats> {
        return NSFetchRequest<UserStats>(entityName: "UserStats")
    }

    @NSManaged public var currentDailyStreak: Double
    @NSManaged public var longestDailyStreak: Double
    @NSManaged public var totalMinutes: Double
    @NSManaged public var totalNumSessions: Double
    @NSManaged public var date: Date
    @NSManaged public var id: UUID

}

extension UserStats: Identifiable {
    
}
