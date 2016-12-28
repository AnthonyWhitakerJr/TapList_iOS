//
//  QuantityTextField.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/15/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import UIKit

class QuantityTextField: UITextField {

    /// Strong reference to custom delegate.
    private let _delegate = QuantityTextFieldDelegate()
    
    var actionDelegate: QuantityTextFieldActionDelegate? {
        get{
            if let delegate = delegate as? QuantityTextFieldDelegate {
                return delegate.actionDelegate
            }
            return nil
        }
        set {
            if let delegate = delegate as? QuantityTextFieldDelegate {
                delegate.actionDelegate = newValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = _delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = _delegate
    }
}

class QuantityTextFieldDelegate: NSObject, UITextFieldDelegate {

    var actionDelegate: QuantityTextFieldActionDelegate?
    
    /// Restricts input to 2 or less numbers (0 - 99).
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacters.isSuperset(of: characterSet) && newLength <= 2
    }
    
    /// Closes keyboard on return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /// Select contents before editing.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
    
    /// Defaults contents to '0' if left blank
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.isEmpty {
            textField.text = "0"
        }
        
        actionDelegate?.quantityTextFieldValueChanged()
    }
}

protocol QuantityTextFieldActionDelegate {
    func quantityTextFieldValueChanged()
}
