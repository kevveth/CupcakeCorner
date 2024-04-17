//
//  Order.swift
//  CupcakeCorner
//
//  Created by Kenneth Oliver Rathbun on 4/16/24.
//

import SwiftUI

@Observable
class Order {
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
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
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
