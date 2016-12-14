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
    var preSelectedQuantity: String?
    var delegate: QuantityTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableView.contentSize.height)
        tableView.sizeToFit()
//            CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, tableView.contentSize.height);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            let isSelected = label == preSelectedQuantity
            
            cell.configureCell(label: label, isSelected: isSelected)
            
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
