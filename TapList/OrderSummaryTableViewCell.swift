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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell() {
        itemsInOrderLabel.text = "\(DataService.instance.cart.quantityTotal)"
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        DataService.instance.cart.subtotal { subtotal in
            print("SUBTOTAL: \(subtotal)")
            self.subtotalLabel.text = formatter.string(from: NSNumber(value: subtotal))
            let estimatedTotal = subtotal + 4.95
            self.estimatedTotalLabel.text = formatter.string(from: NSNumber(value: estimatedTotal))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
