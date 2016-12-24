//
//  Product.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Product {
    // 14 digit product upc. Stored as String to preserve preceeding zeros.
    var sku: String
    var name: String
    var listPrice: Double?
    var offerPrice: Double?
    var regularPrice: Double?
    var soldBy: SoldBy?
    var orderBy: OrderBy?
    // Catch-all for additional text. TODO: Refactor into specific fields?
    var detail: String?
    
    enum SoldBy: String {
        case weight
    }
    
    enum OrderBy: String {
        case unit
    }
    
    enum DataKey: String {
        case name
        case listPrice
        case offerPrice
        case detail
        case soldBy
        case orderBy
    }
    
    init(sku: String, name: String,
                     listPrice: Double, offerPrice: Double? = nil,
                     detail: String,
                     soldBy: SoldBy? = nil, orderBy: OrderBy? = nil) {
        self.sku = sku
        self.name = name
        self.listPrice = listPrice
        self.offerPrice = offerPrice
        self.detail = detail
        self.soldBy = soldBy
        self.orderBy = orderBy
    }
    
    convenience init?(sku: String, data: Dictionary<String, Any>) {
        let name = data[DataKey.name.rawValue] as? String
        let listPrice = data[DataKey.listPrice.rawValue] as? Double
        let offerPrice = data[DataKey.offerPrice.rawValue] as? Double
        let detail = data[DataKey.detail.rawValue] as? String
        
        let soldByString = data[DataKey.soldBy.rawValue] as? String
        var soldBy: SoldBy? = nil
        if let soldByString = soldByString {
            soldBy = SoldBy(rawValue: soldByString)
        }
        
        let orderByString = data[DataKey.orderBy.rawValue] as? String
        var orderBy: OrderBy? = nil
        if let orderByString = orderByString {
            orderBy = OrderBy(rawValue: orderByString)
        }


        if let name = name, let listPrice = listPrice, let detail = detail {
            self.init(sku: sku, name: name,
                      listPrice: listPrice, offerPrice: offerPrice,
                      detail: detail,
                      soldBy: soldBy, orderBy: orderBy)
        } else {
            return nil
        }
    }
}

extension Product: CustomStringConvertible {
    var description: String {
        return "SKU: \(sku), Name: \(name), List Price: \(listPrice)"
    }
}
