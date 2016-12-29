//
//  OrderSummaryTableViewCell.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/16/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class OrderSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var itemsInOrderLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var serviceFeeLabel: UILabel!
    @IBOutlet weak var estimatedTotalLabel: UILabel!
    
    var dataService = DataService.instance
    
    func configureCell(completion: (() -> ())? = nil) {
        itemsInOrderLabel.text = "\(dataService.cart.quantityTotal)"
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        dataService.cart.subtotal { subtotal in
            self.subtotalLabel.text = formatter.string(from: NSNumber(value: subtotal))
            let estimatedTotal = subtotal + 4.95
            self.estimatedTotalLabel.text = formatter.string(from: NSNumber(value: estimatedTotal))
            
            completion!()
        }
    }

}
