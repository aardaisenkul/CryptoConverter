//
//  CryptoCurrency.swift
//  CurrencyConverter
//
//  Created by Ali Arda İsenkul on 22.01.2022.
//

import Foundation

// MARK: - Welcome
struct CryptoCurrency: Codable {
    let query: Query
    let data: [String: Double]
}

// MARK: - Query
struct Query: Codable {
    let apikey: String
    let timestamp: Int
    let base_currency: String

}
struct Crypto : Decodable {
    var name: String
    var value : Double
}
struct Conversion{
var sourceN: Int
    var SourceT:String
    var targetT: String
}
