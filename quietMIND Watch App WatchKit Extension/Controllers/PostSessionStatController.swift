//
//  PostSessionStatController.swift
//  quietMIND Watch App WatchKit Extension
//
//  Created by Ameen Mustafa on 1/22/22.
//

import Foundation
import WatchKit
import SwiftUI
import CoreData

class PostSessionStatController: WKHostingController<PostSessionView> {
    
    override var body: PostSessionView {
        return PostSessionView(context: CoreDataStack.shared.viewContext)
    }
}

struct PostSessionView: View {
    
    var context: NSManagedObjectContext
    
    var body: some View {
        PostSessionStatView()
            .environment(\.managedObjectContext, context)
    }
}
