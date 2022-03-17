//
//  Quotes.swift
//  quietMIND
//
//  Created by Ameen Mustafa on 2/3/22.
//

import Foundation

class Quotes {
    
    var endQuotesEvil = [String: String]()
    var endQuotesGood = [String: String]()
    var quote: [String] = []
    let index: Int
    
    init(){
        endQuotesEvil = [
            "Try to touch the past. Try to deal with the past. It's not real. It's just a dream." : "- Ted Bundy",
            "He who stops being better stops being good." : "- Oliver Cromwell",
            "The real strong have no need to prove it to phonies." : "- Charles Manson",
            "I believe in one thing only, the power of human will." : "- Joseph Stalin",
            "Countless millions who have walked this earth before us have gone through this, so this is just an experience we all share." : "- Ted Bundy",
            "Impossible is a word found only in the dictionary of fools." : "- Napoleon Bonaparte"
        ]
        
        endQuotesGood = [
            "The more you praise and celebrate your life, the more there is in life to celebrate" : "- Oprah",
            "The greatest glory in living lies not in never falling, but in rising every time we fall" : "- Nelson Mandela",
            "Stay away from negative people, they have a problem for every solution" : "- Albert Einstein",
            "If you have the ability to love, love yourself first" : "- Charles Bukwoski",
            "Believe you can and you're halfway there" : "- Teddy Roosevelt",
            "You cannot swim for new horizons until you have the courage to lose sight of the shore" : "- William Faulkner"
        ]
        
        index = Int(arc4random_uniform(UInt32(endQuotesEvil.count)))
        
    }
    
    func getQuote(_ isSerialKiller: Bool) -> [String] {
        
        if isSerialKiller == true {
            let value = Array(endQuotesEvil.values)[index]
            let key = Array(endQuotesEvil.keys)[index]
            let values = endQuotesEvil[key]
            quote.append(key)
            quote.append(values!)
            
            quote = Array(quote)
            return quote
        } else {
            let value = Array(endQuotesGood.values)[index]
            let key = Array(endQuotesGood.keys)[index]
            let values = endQuotesGood[key]
            quote.append(key)
            quote.append(values!)
            
            quote = Array(quote)
            return quote
        }
    }
    
    func getQuote() -> [String] {
        let value = Array(endQuotesEvil.values)[index]
        let key = Array(endQuotesEvil.keys)[index]
        let values = endQuotesEvil[key]
        quote.append(key)
        quote.append(values!)
        
        quote = Array(quote)
        return quote
    }
}
