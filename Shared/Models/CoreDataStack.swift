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
//            print("store description: \(storeDescription)")
        })
        return container
    }()
    
    init(containerName: String) {
        self.containerName = containerName
        _ = persistentContainer
    }
    
}

extension NSManagedObjectContext {
    
    func saveContext() throws {
        guard hasChanges else { return }
        try save()
    }

}

