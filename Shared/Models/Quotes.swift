//
//  Quotes.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/3/22.
//

import Foundation

class Quotes {
    
    var endQuotes = [String: String]()
    var quote: [String] = []
    let index: Int
    
    init(){
        endQuotes = [
            "Try to touch the past. Try to deal with the past. It's not real. It's just a dream." : "- Ted Bundy",
            "He who stops being better stops being good." : "- Oliver Cromwell",
            "The real strong have no need to prove it to phonies." : "- Charles Manson",
            "I believe in one thing only, the power of human will." : "- Joseph Stalin",
            "Countless millions who have walked this earth before us have gone through this, so this is just an experience we all share." : "- Ted Bundy",
            "Impossible is a word found only in the dictionary of fools." : "- Napoleon Bonaparte"
        ]
        
        index = Int(arc4random_uniform(UInt32(endQuotes.count)))
        
    }
    
    func getQuote() -> [String] {
        
        let value = Array(endQuotes.values)[index]
        let key = Array(endQuotes.keys)[index]
        let values = endQuotes[key]
        quote.append(key)
        quote.append(values!)
        
        quote = Array(quote)
        return quote
    }
}
