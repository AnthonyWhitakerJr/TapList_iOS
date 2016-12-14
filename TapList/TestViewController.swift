//
//  TestViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/7/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var quantityButton: UIButton!
    
    var selectedQuantity: String?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quantityPopover" {
            guard let controller = segue.destination as? QuantityTableViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.popoverPresentationController?.delegate = self
            controller.delegate = self
            controller.preSelectedQuantity = quantityButton.currentTitle
            
            // Set bounds for arrow placement.
            if let sender = sender as? UIButton {
                controller.popoverPresentationController?.sourceView = sender
                controller.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: sender.frame.width, height: sender.frame.height)
            }
            
            controller.modalPresentationStyle = .popover
        }
    }
}

extension TestViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension TestViewController: QuantityTableViewControllerDelegate {
    func update(selectedQuantity: String) {
        self.selectedQuantity = selectedQuantity
        quantityButton.setTitle(selectedQuantity, for: .normal)
        print("Selected: \(selectedQuantity)")
    }
}
