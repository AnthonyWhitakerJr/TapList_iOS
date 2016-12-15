//
//  KeyboardHandler.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/14/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol KeyboardHandler {
    weak var scrollView: UIScrollView! {get set}
    
    @objc func keyboardWillShow(notification:NSNotification) // Because swift protocol extensions cannot use *any* Objective-C
    @objc func keyboardWillHide(notification:NSNotification) // Because swift protocol extensions cannot use *any* Objective-C
}

extension KeyboardHandler where Self: UIViewController {
    func configureDismissKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func startObservingKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func stopObservingKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func moveScrollViewUpForKeyboard(notification:NSNotification) {
        guard let scrollView = scrollView else {
            return
        }
        
        // Give room at bottom of scroll view so it doesn't cover anything the user needs to tap.
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    func moveScrollViewDownAfterHidingKeyboard(notification:NSNotification) {
        guard let scrollView = scrollView else {
            return
        }
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
}
