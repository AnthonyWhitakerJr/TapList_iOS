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

    var offer: Offer?
    
    /// Set before segue to this controller.
    var product: Product!
    
    @IBOutlet weak var saleTitleLabel: UILabel!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    @IBOutlet weak var offerShortDescriptionLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.offer(for: product.sku, completion: { result in
            self.offer = result
            self.configureSalePrice()
        })
    }
    
    private func configureSalePrice() {
        guard let offer = offer else {
            print("Offer data unavailable.")
            return
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if offer.offerType == nil {
            saleTitleLabel.text = formatter.string(from: NSNumber(value: product.offerPrice!))! // TODO: Determine best way to handle failure here.
            offerDescriptionLabel.text = offer.offerDescription
            offerShortDescriptionLabel.isHidden = true
            
            if let endDate = offer.endDate {
                expirationDateLabel.isHidden = false
                expirationDateLabel.text = "exp \(endDate)"
            } else {
                expirationDateLabel.isHidden = true
            }
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
