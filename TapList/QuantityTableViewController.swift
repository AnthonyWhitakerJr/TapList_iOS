//
//  QuantityTableViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class QuantityTableViewController: UITableViewController {
    
    /// Set before segue to this controller to mark user's previous selection.
    var previousQuantity: String?
    var delegate: QuantityTableViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        tableView.sizeToFit()
        self.popoverPresentationController?.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "quantityCell", for: indexPath) as? QuantityTableViewCell {
            let num = indexPath.row
            
            let label: String
            switch num {
            case 9:
                label = "10+"
            default:
                label = "\(num + 1)"
            }
            
            let wasSelected = label == previousQuantity
            
            cell.configureCell(label: label, wasSelected: wasSelected)
            
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuantityTableViewCell
        delegate?.update(selectedQuantity: cell.quantityLabel.text!)
        
        dismiss(animated: true)
    }

}

protocol QuantityTableViewControllerDelegate {
    func update(selectedQuantity: String)
}
