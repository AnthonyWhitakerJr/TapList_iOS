//
//  SalePriceViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/5/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

/// Displays details for product offers.
/// Set product before segue to this controller.
class SalePriceViewController: UIViewController {

    var offers = Dictionary<String,Offer>()
    
    /// Set before segue to this controller.
    var product: Product!
    
    @IBOutlet weak var saleTitleLabel: UILabel!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    @IBOutlet weak var offerShortDescriptionLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load Offer data.
        var offer = Offer(productSku: "0001111016222", endDate: "12/06/2016", offerType: .n, offerQuantity: 2, offerPriceTitle: "3", offerDescription: "Discounted yellow tag price.", offerShortDescription: "Buy 2 For $3")
        offers[offer.productSku] = offer
        offer = Offer(productSku: "0001111041600", endDate: nil, offerType: nil, offerQuantity: nil, offerPriceTitle: nil, offerDescription: "Great Deal! Look for more Yellow tag offers to save.", offerShortDescription: nil)
        offers[offer.productSku] = offer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let offer = offers[product.upc] else {
            print("Offer data unavailable.")
            return
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if offer.offerType == nil {
            saleTitleLabel.text = formatter.string(from: NSNumber(value: product.offerPrice!))! // TODO: Determine best way to handle failure here.
            offerDescriptionLabel.text = offer.offerDescription
            offerShortDescriptionLabel.isHidden = true
            expirationDateLabel.isHidden = true
        } else if offer.offerType == .n {
            saleTitleLabel.text = "\(offer.offerQuantity!)\(offer.stringDivider!)\(offer.currency!)\(offer.offerPriceTitle!)" // TODO: Determine best way to handle failure here.
            offerDescriptionLabel.text = offer.offerDescription
            
            offerShortDescriptionLabel.isHidden = false
            offerShortDescriptionLabel.text = offer.offerShortDescription
            
            expirationDateLabel.isHidden = false
            expirationDateLabel.text = "exp \(offer.endDate!)"
        } else {
            print("Unexpected offer type")
        }
        

        // Set color of arrow pointing to popover anchor.
        let backgroundColor: UIColor
        if self.popoverPresentationController?.arrowDirection == .up {
            backgroundColor = UIColor(red: 241.0/255, green: 10.0/255, blue: 10.0/255, alpha: 1) // Red
        } else {
            backgroundColor = UIColor(red: 1, green: 227.0/255, blue: 0, alpha: 1) // Yellow
        }
        
        self.popoverPresentationController?.backgroundColor = backgroundColor
    }


}
