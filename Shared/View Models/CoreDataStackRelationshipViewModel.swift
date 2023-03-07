//
//  CoreDataStackViewModel.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 3/3/23.
//

import Foundation
import CoreData

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
//            newStats.totalNumSessions = 1.0
//            newStats.currentDailyStreak = 1.0
//            newStats.longestDailyStreak = 1.0
            // test values if not used
            
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


