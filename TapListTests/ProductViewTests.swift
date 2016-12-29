//
//  ProductViewTests.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/28/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import XCTest
@testable import TapList
import UIKit

class ProductViewTests: XCTestCase {

    func testConfigureProductView1() {
        let productName = "Test Bagel"
        let listPrice = 2.99
        let detail = "20 oz"
        let product = Product(sku: "0001234567890", name: productName, listPrice: listPrice, detail: detail)
        let productView = TestProductView(product: product)
        let quantityInCart = 3
        productView.quantityInCart = quantityInCart
        productView.configureProductView()
        
        XCTAssertEqual(productName, productView.productNameLabel.text)
        
        XCTAssertTrue(productView.aboutLabel.isHidden)
        XCTAssertTrue(productView.eachLabel.isHidden)
        
        XCTAssertFalse(productView.priceLabel.isHidden)
        XCTAssertEqual("$\(listPrice)", productView.priceLabel.text)
        
        XCTAssertTrue(productView.offerPriceButton.isHidden)
        XCTAssertTrue(productView.listPriceLabel.isHidden)
        
        XCTAssertEqual(detail, productView.detailLabel.text)
        
        XCTAssertFalse(productView.cartQuantityLabel.isHidden)
        XCTAssertEqual("\(quantityInCart) in Cart", productView.cartQuantityLabel.text)
    }
    
    func testConfigureProductView2() {
        let productName = "Test Bagel"
        let listPrice = 2.99
        let offerPrice = 1.99
        let detail = "20 oz"
        let product = Product(sku: "0001234567890", name: productName, listPrice: listPrice, offerPrice: offerPrice, detail: detail)
        let productView = TestProductView(product: product)
        
        productView.configureProductView()
        
        XCTAssertEqual(productName, productView.productNameLabel.text)
        
        XCTAssertTrue(productView.aboutLabel.isHidden)
        XCTAssertTrue(productView.eachLabel.isHidden)
        
        XCTAssertTrue(productView.priceLabel.isHidden)
        
        XCTAssertFalse(productView.listPriceLabel.isHidden)
        XCTAssertEqual("$\(listPrice)", productView.listPriceLabel.text)
        
        XCTAssertFalse(productView.offerPriceButton.isHidden)
        XCTAssertEqual("$\(offerPrice)", productView.offerPriceButton.currentTitle)
        
        XCTAssertEqual(detail, productView.detailLabel.text)
        
        XCTAssertTrue(productView.cartQuantityLabel.isHidden)
    }
    
    func testConfigureProductView3() {
        let productName = "Test Fruit"
        let listPrice = 0.99
        let detail = "$0.99 per lb"
        let product = Product(sku: "0001234567890", name: productName, listPrice: listPrice, detail: detail, soldBy: .weight, orderBy: .unit)
        let productView = TestProductView(product: product)
        
        productView.configureProductView()
        
        XCTAssertEqual(productName, productView.productNameLabel.text)
        
        XCTAssertFalse(productView.aboutLabel.isHidden)
        XCTAssertFalse(productView.eachLabel.isHidden)
        
        XCTAssertFalse(productView.priceLabel.isHidden)
        XCTAssertEqual("$\(listPrice)", productView.priceLabel.text)
        
        XCTAssertTrue(productView.offerPriceButton.isHidden)
        XCTAssertTrue(productView.listPriceLabel.isHidden)
        
        XCTAssertEqual(detail, productView.detailLabel.text)
        
        XCTAssertTrue(productView.cartQuantityLabel.isHidden)
    }
    
    class TestProductView: ProductView {
        var productNameLabel:  UILabel! = UILabel()
        var aboutLabel:        UILabel! = UILabel()
        var priceLabel:        UILabel! = UILabel()
        var eachLabel:         UILabel! = UILabel()
        var listPriceLabel:    UILabel! = UILabel()
        var offerPriceButton:  UIButton! = UIButton()
        var detailLabel:       UILabel! = UILabel()
        var cartQuantityLabel: UILabel! = UILabel()

        var product:           Product!
        var quantityInCart:    Int  = 0

        init(product: Product) {
            self.product = product
        }
    }
}
