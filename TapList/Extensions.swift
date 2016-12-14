//
//  Extensions.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/14/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func configureDismissKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
