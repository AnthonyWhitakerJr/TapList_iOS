//
//  TestViewController.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/7/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, QuantityViewDataSource {

    @IBOutlet weak var quantityButton: UIButton!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var keyboardHandler: KeyboardHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardHandler = KeyboardHandler(contextView: self.view, scrollView: scrollView, onlyScrollForKeyboard: true)
        keyboardHandler.startDismissingKeyboardOnTap()
        keyboardHandler.startObservingKeyboardEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureQuantityView(previousQuantity: 4)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quantityPopover" {
            guard let controller = segue.destination as? QuantityTableViewController else {
                print("improper controller for this segue")
                return
            }
            
            preparePopover(for: controller, sender: sender)
            
            controller.delegate = self
            controller.previousQuantity = quantityButton.currentTitle
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return matchesTwoDigitMax(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TestViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
