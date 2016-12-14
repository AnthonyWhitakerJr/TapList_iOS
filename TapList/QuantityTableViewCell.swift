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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(label: String, isSelected: Bool = false) {
        quantityLabel.text = label
        if isSelected {
            self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
