//
//  ManageCartTableViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/16/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class ManageCartTableViewController: UITableViewController {

    var productForSegue: Product? // Certainly there is a better way of doing this...
    
    var cart: Cart {
        return DataService.instance.cart
    }
    
    var cartItems: Array<CartItem> {
        return Array(DataService.instance.cart.cartItems.values)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartItemTableViewCell {
            let cartItem = cartItems[indexPath.row]
            cell.delegate = self
            cell.configureCell(cartItem: cartItem)

            return cell
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
        } else if segue.identifier == "quantityPopover" {
            guard let controller = segue.destination as? QuantityTableViewController else {
                print("improper controller for this segue")
                return
            }
            
//            controller.delegate = self
//            controller.previousQuantity = quantityButton.currentTitle
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
    
    func handleQuantityButtonTapped(_ sender: UIButton) {
//        performSegue(withIdentifier: "quantityPopover", sender: sender)
    }
}

extension ManageCartTableViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
