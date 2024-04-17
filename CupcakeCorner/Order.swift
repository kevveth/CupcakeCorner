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
}
