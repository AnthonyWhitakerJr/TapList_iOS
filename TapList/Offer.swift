//
//  Offer.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/6/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation

class Offer {
    
    enum OfferType {
        case n
        case b
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
    
    init(productSku: String, endDate: String?, offerType: OfferType?, offerQuantity: Int?, stringDivider: String? = "/", currency: String? = "$",
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
}
