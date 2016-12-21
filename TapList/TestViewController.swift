//
//  TestViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/7/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var quantityEntryView: QuantityEntryView!
    
    var keyboardHandler: KeyboardHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardHandler = KeyboardHandler(contextView: self.view, onlyScrollForKeyboard: true)
        keyboardHandler.startDismissingKeyboardOnTap()
        keyboardHandler.startObservingKeyboardEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quantityEntryView.configureQuantityView(previousQuantity: 2)
        quantityEntryView.quantityButton.addTarget(self, action: #selector(quantityButtonTouched(_:)), for: .touchUpInside)
    }
    
    @IBAction func quantityButtonTouched(_ sender: UIButton) {
        performSegue(withIdentifier: "quantityPopover", sender: sender)
    }
    
    @IBAction func quantityUpdated(_ sender: QuantityEntryView) {
        print("Quantity: \(sender.quantity)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quantityPopover" {
            guard let controller = segue.destination as? QuantityTableViewController else {
                print("improper controller for this segue")
                return
            }
            
            preparePopover(for: controller, sender: sender)
            
            controller.delegate = quantityEntryView
            controller.previousQuantity = "\(quantityEntryView.quantity)"
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

extension TestViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

