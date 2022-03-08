//
//  CoreDataStack.swift
//  quietMind
//
//  Created by Ameen Mustafa on 1/15/22.
//

import CoreData

class CoreDataStack {
    
    private let containerName: String
    var viewContext: NSManagedObjectContext { persistentContainer.viewContext }
    
    static let shared: CoreDataStack = {
        let stack = CoreDataStack(containerName: "UserStatsTracker")
        stack.viewContext.automaticallyMergesChangesFromParent = true
        return stack
    }()
    
    private lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("here in the lazy var persistentContainer \(error.localizedDescription)")
            }
            print("store description: \(storeDescription)")
        })
        return container
    }()
    
    init(containerName: String) {
        self.containerName = containerName
        _ = persistentContainer
    }
    
    func addTodaysSession(_ initialTime: Double) {
        let newStats = UserStats(context: viewContext)
 //       let newTotal = newStats.totalMinutes + initialTime
        newStats.totalMinutes = newStats.totalMinutes + initialTime
        newStats.id = UUID()
        newStats.date = Date()
        newStats.totalNumSessions = newStats.totalNumSessions + 1.0
        
        do {
            try viewContext.saveContext()
        } catch let error {
            print("error saving new session \(error.localizedDescription)")
        }
    }
    
}

extension NSManagedObjectContext {
    
    func saveContext() throws {
        guard hasChanges else { return }
        try save()
    }

}

class CoreDataStackRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataStack.shared
    @Published var allTimeUserStats: [UserStats] = []
    
    var longerest: Double = 0.0
    var currenterist: Double = 0.0
    
    init(){
        getAllTimeUserStats()
    }
    
    func addTodaysSession(_ initialTime: Double) {
        
        let newStats = UserStats(context: manager.viewContext)
        
        if allTimeUserStats.isEmpty {
            newStats.totalMinutes = initialTime
            newStats.id = UUID()
            newStats.date = Date()
            newStats.totalNumSessions = 1.0
            newStats.currentDailyStreak = 1.0
            newStats.longestDailyStreak = 1.0
            
            do {
                try manager.viewContext.saveContext()
            } catch let error {
                print("error saving new session \(error.localizedDescription)")
            }
        } else {
    
            newStats.totalMinutes = newStats.totalMinutes + initialTime
            newStats.id = UUID()
            newStats.date = Date()
            
            newStats.totalNumSessions = newStats.totalNumSessions + 1.0
            
            newStats.currentDailyStreak = Double(getDates())
            
            newStats.longestDailyStreak = Double(getDatesLong())
            
            do {
                try manager.viewContext.saveContext()
            } catch let error {
                print("error saving new session \(error.localizedDescription)")
        }
        }
    }
    
    func getDates() -> Int {

        var calender = Calendar.current
        
        var dates = [Date]()
        for datez in allTimeUserStats.map { $0.date } {
            dates.append(datez)
        }
        
        dates.sort()
        
        if dates.count == 0 {
            return 0
        }
        let referenceDate = calender.startOfDay(for: dates.first!)
        
        let diffDays = dates.map { (date) -> Int in
            calender.dateComponents([.day], from: referenceDate, to: date).day!
        }
        
        let consecutiveDaysCount = currentConsecutiveStreak(in: diffDays)
        
        return consecutiveDaysCount
    }
    
    /// Find maximal length of a subsequence of consecutive numbers in the array.
    /// It is assumed that the array is sorted in non-decreasing order.
    /// Consecutive equal elements are ignored.

    func currentConsecutiveStreak(in array: [Int]) -> Int {
        var longest = 0 // length of longest subsequence of consecutive numbers
        var current = 1 // length of current subsequence of consecutive numbers

        for (prev, next) in zip(array, array.dropFirst()) {
            if next > prev + 1 {
                // Numbers are not consecutive, start a new subsequence.
                current = 1
            } else if next == prev + 1 {
                // Numbers are consecutive, increase current length
                current += 1
            }
            if current > longest {
                longest = current
            }
        }
        return current
    }
    
    func getDatesLong() -> Int {
        var calender = Calendar.current
        
        var dates = [Date]()
        for datez in allTimeUserStats.map { $0.date } {
            dates.append(datez)
        }
        
        dates.sort()
        
        if dates.count == 0 {
            return 0
        }
        
        let referenceDate = calender.startOfDay(for: dates.first!)
        
        
        let diffDays = dates.map { (date) -> Int in
            calender.dateComponents([.day], from: referenceDate, to: date).day!
        }
        
        let longestDaysCount = getLongestStreak(in: diffDays)
        
        return longestDaysCount
    }
    
    func getLongestStreak(in array: [Int]) -> Int {
        
        var longest = 0 // length of longest subsequence of consecutive numbers
        var current = 1 // length of current subsequence of consecutive numbers

        for (prev, next) in zip(array, array.dropFirst()) {
            if next > prev + 1 {
                // Numbers are not consecutive, start a new subsequence.
                current = 1
            } else if next == prev + 1 {
                // Numbers are consecutive, increase current length
                current += 1
            }
            if current > longest {
                longest = current
            }
        }
        
        return longest
    }
    
    func getAllTimeUserStats(){
        
        let request = NSFetchRequest<UserStats>(entityName: "UserStats")

        do {
            allTimeUserStats = try manager.viewContext.fetch(request)
        } catch let error {
            print("Error fetching user's all time stats \(error.localizedDescription)")
        }
    }
    
    func getAverage() -> Double {
        
        let totalMinutes = allTimeUserStats.map { $0.totalMinutes }.reduce(0, +)
        
        let totalSessions = allTimeUserStats.map { $0.totalNumSessions }.reduce(0, +)
        
        let avg = totalMinutes/totalSessions
        
        return avg
    }
    
    func getTotalMinutes() -> Double {
        return allTimeUserStats.map { $0.totalMinutes }.reduce(0, +)
    }
    
    func getTotalSessions() -> Double {
        return allTimeUserStats.map { $0.totalNumSessions }.reduce(0, +)
    }
    
}

