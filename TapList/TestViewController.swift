//
//  TestViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/7/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popover1" || segue.identifier == "popover2" {
            let popoverViewController = segue.destination as! SalePriceViewController
            popoverViewController.modalPresentationStyle = .popover
            popoverViewController.popoverPresentationController!.delegate = self
            
            switch segue.identifier! {
            case "popover1":
                let product = Product(upc: "0001111016222", name: "Kroger Glazed Sour Cream Cake Donut Holes", listPrice: 2.49, offerPrice: 1.50, detail: "14 oz")
                popoverViewController.product = product
            case "popover2":
                let product = Product(upc: "0001111041600", name: "Kroger 2% Reduced Fat Milk", listPrice: 1.69, offerPrice: 1.49, detail: "1/2 gal")

                popoverViewController.product = product
            default: break
            }
        }
        
        
    }

}

extension TestViewController: UIPopoverPresentationControllerDelegate {
 
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
