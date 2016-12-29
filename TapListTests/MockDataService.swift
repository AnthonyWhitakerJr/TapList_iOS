//
//  MockDataService.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/24/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
@testable import TapList

class MockDataService: DataService {
    
    override func loadCart() {
        // Do nothing
    }
    
    override func product(for sku: String, completion: @escaping (Product?) -> ()) {
        let product: Product?
        switch sku {
        case "0001234567890":
            product = Product(sku: "0001234567890", name: "Regular price product", listPrice: 4.99, detail: "$4.99 each")
        case "0009876543210":
            product = Product(sku: "0009876543210", name: "Sale item", listPrice: 2.99, offerPrice: 1.99, detail: "14 oz")
        case "0001234543210":
            product = Product(sku: "0001234543210", name: "Sold by weight", listPrice: 8.49, detail: "$1.70/lb", soldBy: .weight, orderBy: .unit)
        default:
            product = nil
        }
        
        completion(product)
    }
    
}
