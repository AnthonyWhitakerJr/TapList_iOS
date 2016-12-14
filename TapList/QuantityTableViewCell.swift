//
//  QuantityTableViewCell.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class QuantityTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityLabel: UILabel!
    
    func configureCell(label: String, wasSelected: Bool = false) {
        quantityLabel.text = label
        if wasSelected {
            self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
    }

}
