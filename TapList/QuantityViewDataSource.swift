//
//  QuantityViewDelegate.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/14/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

protocol QuantityViewDataSource: QuantityTableViewControllerDelegate, UITextFieldDelegate {
    weak var quantityButton: UIButton! {get set}
    weak var quantityTextField: UITextField! {get set}
    
    func configureQuantityView(previousQuantity: Int)
}

extension QuantityViewDataSource {
    
    func configureQuantityView(previousQuantity: Int) {
        if previousQuantity < 10 {
            quantityButton.setTitle("\(previousQuantity)", for: .normal)
        } else {
            quantityButton.isHidden = true
            
            quantityTextField.isEnabled = true
            quantityTextField.text = "\(previousQuantity)"
        }
    }
    
    func update(selectedQuantity: String) {
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
    
    // Restricts input to 2 or less numbers (0 - 99).
    func textField(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacters.isSuperset(of: characterSet) && newLength <= 2
    }
}
