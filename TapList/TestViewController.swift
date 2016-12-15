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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDismissKeyboardOnTap()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
        
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureQuantityView(previousQuantity: 4)
    }
    
    func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
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
    
    //FIXME: Swift bug - This should not be necessary.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return fitsTwoDigitMax(textField: textField, shouldChangeCharactersIn: range, replacementString: string)
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
