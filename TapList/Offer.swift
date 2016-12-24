//
//  Offer.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/6/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Offer {
    
    enum OfferType: String {
        case n
        case b
    }
    
    enum DataKey: String {
        case endDate
        case offerType
        case offerQuantity
        case offerPriceTitle
        case offerDescription
        case offerShortDescription
    }
    
    var productSku: String
    var endDate: String? // TODO: Change to Date.
    var offerType: OfferType?
    var offerQuantity: Int?
    var stringDivider: String? // Is this needed? Hard-code?
    var currency: String? // Should this be determined by localization?
    var offerPriceTitle: String?
    var offerDescription: String?
    var offerShortDescription: String?
    
    init(productSku: String, endDate: String?, offerType: OfferType?, offerQuantity: Int?,
         stringDivider: String? = "/", currency: String? = "$",
         offerPriceTitle: String?, offerDescription: String?, offerShortDescription: String?) {
        self.productSku = productSku
        self.endDate = endDate
        self.offerType = offerType
        self.offerQuantity = offerQuantity
        self.stringDivider = stringDivider
        self.currency = currency
        self.offerPriceTitle = offerPriceTitle
        self.offerDescription = offerDescription
        self.offerShortDescription = offerShortDescription
    }
    
    convenience init?(productSku: String, data: Dictionary<String, Any>) {
        let endDate = data[DataKey.endDate.rawValue] as? String
        let offerTypeString = data[DataKey.offerType.rawValue] as? String
        
        var offerType: OfferType? = nil
        if let offerTypeString = offerTypeString {
            offerType = OfferType(rawValue: offerTypeString)
        }
        
        let offerQuantity = data[DataKey.offerQuantity.rawValue] as? Int
        let offerPriceTitle = data[DataKey.offerPriceTitle.rawValue] as? String
        let offerDescription = data[DataKey.offerDescription.rawValue] as? String
        let offerShortDescription = data[DataKey.offerShortDescription.rawValue] as? String
        
        self.init(productSku: productSku, endDate: endDate, offerType: offerType, offerQuantity: offerQuantity,
                  offerPriceTitle: offerPriceTitle, offerDescription: offerDescription, offerShortDescription: offerShortDescription)
    }
    
}
