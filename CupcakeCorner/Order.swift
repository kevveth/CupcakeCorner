//
//  Order.swift
//  CupcakeCorner
//
//  Created by Kenneth Oliver Rathbun on 4/16/24.
//

import SwiftUI

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    init() {
        if let savedName = UserDefaults.standard.data(forKey: "name") {
            if let decodedName = try? JSONDecoder().decode(String.self, from: savedName) {
                name = decodedName
            }
        }
        
        if let savedAddress = UserDefaults.standard.data(forKey: "address") {
            if let decodedAddress = try? JSONDecoder().decode(String.self, from: savedAddress) {
                streetAddress = decodedAddress
            }
        }
        
        if let savedCity = UserDefaults.standard.data(forKey: "city") {
            if let decodedCity = try? JSONDecoder().decode(String.self, from: savedCity) {
                city = decodedCity
            }
        }
        
        if let savedZip = UserDefaults.standard.data(forKey: "zip") {
            if let decodedZip = try? JSONDecoder().decode(String.self, from: savedZip) {
                zip = decodedZip
            }
        }
        
        return
    }
    
    static let types = ["Strawberry", "Chocolate", "Vanilla", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(name) {
                UserDefaults.standard.set(encoded, forKey: "name")
            }
        }
    }
    
    var streetAddress = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(streetAddress) {
                UserDefaults.standard.set(encoded, forKey: "address")
            }
        }
    }
    
    var city = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.set(encoded, forKey: "city")
            }
        }
    }
    
    var zip = "" {
        didSet {
            if let encoded = try? JSONEncoder().encode(zip) {
                UserDefaults.standard.set(encoded, forKey: "zip")
            }
        }
    }
    
    var hasValidAddress: Bool {
        let trimmedAddress = streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if name.isEmpty || trimmedAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // 2$ per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // 1$/cake for extra frosting
        cost += Double(quantity) * 1
        
        // 0.50$/cake for sprinkles
        cost += Double(quantity) / 2
        
        return cost
    }
}
