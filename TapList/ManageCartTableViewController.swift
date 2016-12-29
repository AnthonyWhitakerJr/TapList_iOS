//
//  ManageCartTableViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/16/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class ManageCartTableViewController: UITableViewController {

    var keyboardHandler: KeyboardHandler!
    var productForSegue: Product? // Certainly there is a better way of doing this...
    var quantityEntryViewForSegue: QuantityEntryView?
    
    var dataService = DataService.instance
    
    var cart: Cart {
        return dataService.cart
    }
    
    var cartItems: Array<CartItem> {
        return Array(dataService.cart.cartItems.values)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        keyboardHandler = KeyboardHandler(contextView: self.view)
        keyboardHandler.startDismissingKeyboardOnTap()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == cartItems.count { // Last cell in table.
            if let cell = tableView.dequeueReusableCell(withIdentifier: "orderSummary", for: indexPath) as? OrderSummaryTableViewCell {
                cell.configureCell()
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartItemTableViewCell {
                let cartItem = cartItems[indexPath.row]
                cell.delegate = self
                cell.configureCell(cartItem: cartItem)
                
                return cell
            }
        }
        return UITableViewCell()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "offerPopover" {
            guard let productForSegue = productForSegue else {
                print("product not set before segue to sale price controller.")
                return
            }
            guard let controller = segue.destination as? SalePriceViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.product = productForSegue
            self.productForSegue = nil
            preparePopover(for: controller, sender: sender)
        } else if segue.identifier == "productDetail" {
            guard let productForSegue = productForSegue else {
                print("product not set before segue to sale price controller.")
                return
            }
            guard let controller = segue.destination as? ProductDetailViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.product = productForSegue
            self.productForSegue = nil
        } else if segue.identifier == "quantityPopover" {
            guard let quantityEntryViewForSegue = quantityEntryViewForSegue else {
                print("quantityEntryView not set before segue to QuantityTableViewController.")
                return
            }
            guard let controller = segue.destination as? QuantityTableViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.delegate = quantityEntryViewForSegue
            controller.previousQuantity = "\(quantityEntryViewForSegue.quantity)"
            self.quantityEntryViewForSegue = nil
            preparePopover(for: controller, sender: sender)
        }
    }
    
    func preparePopover(for controller: UIViewController, sender: Any?) {
        controller.popoverPresentationController?.delegate = self
        
        // Set bounds for arrow placement.
        if let sender = sender as? UIButton {
            controller.popoverPresentationController?.sourceView = sender
            controller.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: sender.frame.width, height: sender.frame.height)
        }
        
        controller.modalPresentationStyle = .popover
    }

}

extension ManageCartTableViewController: CartCellDelegate {
    func handleOfferButtonTapped(product: Product, sender: UIButton) {
        productForSegue = product
        performSegue(withIdentifier: "offerPopover", sender: sender)
    }
    
    func handleProductImageButtonTapped(product: Product, sender: UIButton) {
        productForSegue = product
        performSegue(withIdentifier: "productDetail", sender: sender)
    }
    
    func handleSegueToQuantityPopover(quantityEntryView: QuantityEntryView, sender: UIButton) {
        quantityEntryViewForSegue = quantityEntryView
        performSegue(withIdentifier: "quantityPopover", sender: sender)
    }
    
    func handleQuantityUpdate(cell: CartItemTableViewCell, newQuantity: Int) {
        let cartItem = CartItem(sku: cell.cartItem.sku, quantity: newQuantity, specialInstructions: cell.cartItem.specialInstructions)
        dataService.update(cartItem: cartItem) {
            // Reload only the updated cell & order summary
            if newQuantity != 0, let indexpath = self.tableView.indexPath(for: cell) {
                let orderSummaryIndexPath = IndexPath(row: self.tableView.numberOfRows(inSection: indexpath.section) - 1, section: indexpath.section)
                self.tableView.reloadRows(at: [indexpath, orderSummaryIndexPath], with: .fade)
            } else { // Item has been removed; easier to reload entire table.
                self.tableView.reloadData()
            }
        }
    }
}

extension ManageCartTableViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
