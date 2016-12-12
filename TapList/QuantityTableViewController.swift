//
//  QuantityTableViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/12/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class QuantityTableViewController: UITableViewController {
    
    var cartItem: CartItem!
    var selectedQuantity: String = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
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
            if num == 9 {
                label = "10+"
            } else {
                label = "\(num + 1)"
            }
            
            cell.configureCell(label: label)
            
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuantityTableViewCell
        selectedQuantity = cell.quantityLabel.text!
        
        dismiss(animated: true)
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
