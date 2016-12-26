//
//  Product.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/4/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Product {
    /// 14 digit product sku/upc. Stored as String to preserve preceeding zeros.
    var sku: String
    
    /// Name of product.
    var name: String
    
    /// Regular price of product.
    var listPrice: Double?
    
    /// Sale price of product.
    var offerPrice: Double?
    
    var soldBy: SoldBy?
    var orderBy: OrderBy?
    
    /// Catch-all for additional text.
    var detail: String?
    
    enum SoldBy: String {
        case weight
    }
    
    enum OrderBy: String {
        case unit
    }
    
    /// Keys used for dictionary representation of `Product`.
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
    
    /// Constructs a Product based on given data.
    /// returns - Product based on given data. Returns `nil` if `name`, `listPrice` and `detail` are not provided.
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
