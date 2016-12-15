//
//  ProductView.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/9/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

protocol ProductView {
    
    weak var productNameLabel: UILabel! {get set}
    weak var aboutLabel: UILabel! {get set}
    weak var priceLabel: UILabel! {get set}
    weak var eachLabel: UILabel! {get set}
    weak var listPriceLabel: UILabel! {get set}
    weak var offerPriceButton: UIButton! {get set}
    weak var detailLabel: UILabel! {get set}
    weak var cartQuantityLabel: UILabel! {get set}
    
    var product: Product! {get set}
    var quantityInCart: Int {get set}
    
    func configureProductView()
}

extension ProductView {
    
    func configureProductView() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        productNameLabel.text = product.name
        
        if product.soldBy == .weight, product.orderBy == .unit { //TODO: Refactor me: extract method.
            aboutLabel.isHidden = false
            eachLabel.isHidden = false
        } else {
            aboutLabel.isHidden = true
            eachLabel.isHidden = true
        }
        
        if let offerPrice = product.offerPrice {
            priceLabel.isHidden = true
            listPriceLabel.isHidden = false
            listPriceLabel.attributedText = NSAttributedString(string: formatter.string(from: NSNumber(value: product.listPrice!))!, attributes: [NSStrikethroughStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue])
            
            offerPriceButton.isHidden = false
            offerPriceButton.setTitle(formatter.string(from: NSNumber(value: offerPrice))!, for: .normal)
        } else {
            priceLabel.isHidden = false
            priceLabel.text = formatter.string(from: NSNumber(value: product.listPrice!))
            
            offerPriceButton.isHidden = true
            listPriceLabel.isHidden = true
        }
        
        detailLabel.text = product.detail
        
        updateCartQuantityLabel()
    }
    
    func updateCartQuantityLabel() {
        if quantityInCart == 0 {
            cartQuantityLabel.isHidden = true
        } else {
            cartQuantityLabel.isHidden = false
            cartQuantityLabel.text = "\(quantityInCart) in Cart"
        }
    }
    
}
