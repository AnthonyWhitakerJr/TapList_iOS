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

        var offer = Offer(productSku: "0001111016222", endDate: "12/06/2016", offerType: .n, offerQuantity: 2, offerPriceTitle: "3", offerDescription: "Discounted yellow tag price.", offerShortDescription: "Buy 2 For $3")
        offers[offer.productSku] = offer
        offer = Offer(productSku: "0001111041600", endDate: nil, offerType: nil, offerQuantity: nil, offerPriceTitle: nil, offerDescription: "Great Deal! Look for more Yellow tag offers to save.", offerShortDescription: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let offer = offers[product.upc] else {
            print("Offer data unavailable.")
            return
        }
        
        if offer.offerType == nil {
            saleTitleLabel.text = "\(product.offerPrice!)"
            offerDescriptionLabel.text = offer.offerDescription
            offerShortDescriptionLabel.isHidden = true
            expirationDateLabel.isHidden = true
        } else if offer.offerType == .n {
            saleTitleLabel.text = "\(offer.offerQuantity)\(offer.stringDivider)\(offer.currency)\(offer.offerPriceTitle)"
            offerDescriptionLabel.text = offer.offerDescription
            
            offerShortDescriptionLabel.isHidden = false
            offerShortDescriptionLabel.text = offer.offerShortDescription
            
            expirationDateLabel.isHidden = false
            expirationDateLabel.text = "exp \(offer.endDate)"
        } else {
            print("Unexpected offer type")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
