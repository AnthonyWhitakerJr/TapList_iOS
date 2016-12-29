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
    
    struct TestProduct {
        let regularPriced = Product(sku: "0001234567890", name: "Regular price product", listPrice: 4.99, detail: "$4.99 each")
        let onSale = Product(sku: "0009876543210", name: "Sale item", listPrice: 2.99, offerPrice: 1.99, detail: "20 oz")
        let onSaleIndefinetly = Product(sku: "0009876543211", name: "Sale item", listPrice: 1.69, offerPrice: 1.49, detail: "1/2 gal")
        let onSale4For5 = Product(sku: "0009876543212", name: "Sale item", listPrice: 1.89, offerPrice: 1.25, detail: "2L")
        let onSaleTypeB = Product(sku: "0009876543210", name: "Sale item", listPrice: 2.99, offerPrice: 1.99, detail: "20 oz")
        let soldByWeight = Product(sku: "0001234543210", name: "Sold by weight", listPrice: 8.49, detail: "$1.70/lb", soldBy: .weight, orderBy: .unit)
    }
    
    struct TestOffer {
        let onSale = Offer(productSku: TestProduct().onSale.sku, endDate: "03/01/2017", offerDescription: "Great Deal!")
        let onSaleIndefinetly = Offer(productSku: TestProduct().onSaleIndefinetly.sku, offerDescription: "Great Deal!")
        let onSale4For5 = Offer(productSku: TestProduct().onSale4For5.sku, endDate: "02/01/2017", offerType: .n, offerQuantity: 4, offerPriceTitle: "$5", offerDescription: "Discount", offerShortDescription: "Buy 4 for 5")
        let onSaleTypeB = Offer(productSku: TestProduct().onSale.sku, endDate: "03/01/2017", offerType: .b, offerDescription: "Great Deal!")

    }
    
    override func loadCart() {
        // Do nothing
    }
    
    override func product(for sku: String, completion: @escaping (Product?) -> ()) {
        let product: Product?
        let testProduct = TestProduct()
        switch sku {
        case testProduct.regularPriced.sku:
            product = testProduct.regularPriced
        case testProduct.onSale.sku:
            product = testProduct.onSale
        case testProduct.soldByWeight.sku:
            product = testProduct.soldByWeight
        default:
            product = nil
        }
        
        completion(product)
    }
    
    override func offer(for productSku: String, completion: @escaping (Offer?) -> ()) {
        let offer: Offer?
        let testOffer = TestOffer()
        switch productSku {
        case testOffer.onSale.productSku:
            offer = testOffer.onSale
        case testOffer.onSaleIndefinetly.productSku:
            offer = testOffer.onSaleIndefinetly
        case testOffer.onSale4For5.productSku:
            offer = testOffer.onSale4For5
        default:
            offer = nil
        }
        
        completion(offer)
    }
    
}
