//
//  MockRequest.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/21/23.
//

import Foundation

class MockNetworkRequest {
    // so needs to create an array (or 2?)
    // of quotes
    // so how does this work?
    // it's a normal json request but it returns 2 arrays?
    // what if in jsonParser you filter based on array?
    // have two different arrays up top?
    // or since arrays are ordered you can just have first half evil
    // and last half good
    
    var decodedQuotesData = [Quotes]()
    
    func performMockRequest(_ fileName: String, completion: @escaping ([Quotes]) -> Void) {
        guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("couldn't find \(fileName) in main bundle")
        }
        do {
            let jsonData = try Data(contentsOf: file)
            var parsedJSON = jsonParser(jsonData)
            completion(parsedJSON)
        } catch {
            print("\(error) with json decoding")
            completion([])
        }
    }
    
    func jsonParser(_ quoteData: Data) -> [Quotes] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Quotes].self, from: quoteData)
            for i in 0..<decodedData.count {
                var quote = decodedData[i].quote
                var author = decodedData[i].author
                var evil = decodedData[i].evil
                var quotesModel = Quotes(quote: quote, author: author, evil: evil)
                decodedQuotesData.append(quotesModel)
            }
            return decodedQuotesData
        } catch {
            print("in jsonParser catch")
            return []
        }
    }
}
