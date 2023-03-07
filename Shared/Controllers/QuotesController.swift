//
//  QuotesController.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/21/23.
//

import Foundation
import SwiftUI

class QuotesController: ObservableObject {
    
    var mockNetworkReq = MockNetworkRequest()
    @Published var parsedJSON = [Quotes]()
    var returnedQuote = [String]()
    @State private var isSerialKiller = UserDefaults.standard.bool(forKey: "isSerialKiller")
    
    init(){
        getQuote(isSerialKiller)
    }
    
    // so the idea is if evil then pull from first half of quotes
    // else return last half
    func getQuote(_ isSerialKiller: Bool) {
        
        if self.parsedJSON.isEmpty {
            mockNetworkReq.performMockRequest("Quotes.json") { result in
                self.parsedJSON = result
            }
        } else {
            print("self.parsedJSON is not empty")
        }
        
        let middle = self.parsedJSON.count / 2
        if isSerialKiller {
            let index = Int.random(in: 0..<middle)
            let quote = self.parsedJSON[index].quote
            let author = self.parsedJSON[index].author
            returnedQuote.append(quote)
            returnedQuote.append(author)
        } else {
            let index = Int.random(in: middle..<parsedJSON.count)
            let quote = self.parsedJSON[index].quote
            let author = self.parsedJSON[index].author
            returnedQuote.append(quote)
            returnedQuote.append(author)
        }
    }
    
    func returnQuote() -> [String] {
        return returnedQuote
    }
}
