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
    @IBOutlet weak var quantityTextField: UITextField!
    
    var selectedQuantity: String?

    override func viewWillAppear(_ animated: Bool) {
        quantityTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quantityPopover" {
            guard let controller = segue.destination as? QuantityTableViewController else {
                print("improper controller for this segue")
                return
            }
            
            controller.popoverPresentationController?.delegate = self
            controller.delegate = self
            controller.previousQuantity = quantityTextField.text!.isEmpty ? quantityButton.currentTitle : quantityTextField.text
            
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
        if selectedQuantity == "10+" {
            quantityButton.isHidden = true
            
            quantityTextField.isEnabled = true
            quantityTextField.text = "10"
            quantityTextField.becomeFirstResponder()
            quantityTextField.selectedTextRange = quantityTextField.textRange(from: quantityTextField.beginningOfDocument, to: quantityTextField.endOfDocument)
        } else {
            quantityButton.setTitle(selectedQuantity, for: .normal)
        }
        print("Selected: \(selectedQuantity)")
    }
}

extension TestViewController: UITextFieldDelegate {
    // Restricts input to 2 or less numbers.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacters.isSuperset(of: characterSet) && newLength <= 2
    }
}
