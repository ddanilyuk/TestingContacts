//
//  ScrollViewController.swift
//  TestingContacts
//
//  Created by Денис Данилюк on 06.11.2020.
//

import UIKit

final class ScrollViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
        
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Private Actions
    
    @objc func keyboardWillShow(sender: NSNotification) {
//        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//
//            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
//            scrollView.contentInset = contentInsets
//            scrollView.scrollIndicatorInsets = contentInsets
//
//            var mainViewFrame = self.view.frame
//            mainViewFrame.size.height -= keyboardHeight
//
//            if (!mainViewFrame.contains(mainTextField.frame.origin) ) {
//                scrollView.scrollRectToVisible(mainTextField.frame, animated: true)
//            }
//        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
//        scrollView.contentInset = UIEdgeInsets.zero
//        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
