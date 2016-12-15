//
//  KeyboardHandler.swift
//  TapList
//
//  Created by Anthony Whitaker on 12/14/16.
//  Copyright © 2016 Anthony Whitaker. All rights reserved.
//

import Foundation
import UIKit

class KeyboardHandler {
    
    weak var contextView: UIView!
    weak var scrollView: UIScrollView?
    var onlyScrollForKeyboard: Bool
    private var dismissKeyboardRecognizer: UITapGestureRecognizer?
    private var previousInset: UIEdgeInsets = UIEdgeInsets.zero
    
    init(contextView: UIView, scrollView: UIScrollView? = nil, onlyScrollForKeyboard: Bool = false) {
        self.contextView = contextView
        self.scrollView = scrollView
        self.onlyScrollForKeyboard = onlyScrollForKeyboard
    }
    
    deinit {
        stopObservingKeyboardEvents()
    }
    
    @objc func dismissKeyboard() {
        contextView.endEditing(true)
    }
    
    func startDismissingKeyboardOnTap() {
        dismissKeyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardRecognizer!.cancelsTouchesInView = false
        contextView.addGestureRecognizer(dismissKeyboardRecognizer!)
    }
    
    func stopDismissingKeyboardOnTap(){
        guard let dismissKeyboardRecognizer = dismissKeyboardRecognizer else {
            return
        }
        
        contextView.removeGestureRecognizer(dismissKeyboardRecognizer)
    }
    
    func startObservingKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func stopObservingKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        if onlyScrollForKeyboard {
            scrollView?.isScrollEnabled = true
        }
        
        moveScrollViewUpForKeyboard(notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        moveScrollViewDownAfterHidingKeyboard(notification: notification)
        
        if onlyScrollForKeyboard {
            scrollView?.isScrollEnabled = false
        }
    }
    
    func moveScrollViewUpForKeyboard(notification:NSNotification) {
        guard let scrollView = scrollView else {
            return
        }
        
        // Give room at bottom of scroll view so it doesn't cover anything the user needs to tap.
        var userInfo = notification.userInfo!
        var keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = contextView.convert(keyboardFrame, from: nil)
        
        previousInset = scrollView.contentInset
        var contentInset = scrollView.contentInset
        contentInset.bottom += keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    func moveScrollViewDownAfterHidingKeyboard(notification:NSNotification) {
        guard let scrollView = scrollView else {
            return
        }
        
        let contentInset = previousInset
        scrollView.contentInset = contentInset
    }
}
