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
        load()
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
            save()
        }
    }
    
    var streetAddress = "" {
        didSet {
            save()
        }
    }
    
    var city = "" {
        didSet {
            save()
        }
    }
    
    var zip = "" {
        didSet {
            save() 
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "OrderData")
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: "OrderData") {
            do {
                let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                
                //Assign decoded properties to self
                self.name = decodedOrder.name
                self.streetAddress = decodedOrder.streetAddress
                self.city = decodedOrder.city
                self.zip = decodedOrder.zip
            } catch {
                
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
