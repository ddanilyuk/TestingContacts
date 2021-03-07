//
//  CustomViewWithTextField.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 11.11.2020.
//

import UIKit

@IBDesignable
class CustomViewWithTextField: UIView {

    let className = String(describing: CustomViewWithTextField.self)

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var validationLabel: UILabel!
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.view.frame = self.bounds
//    }
    
    func setup() {
        guard let nib = loadNib() else { return }
        nib.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nib)
        NSLayoutConstraint.activate([
            nib.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nib.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nib.topAnchor.constraint(equalTo: self.topAnchor),
            nib.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textFieldEditingEnded(textField:)), for: .editingDidEnd)
        usernameTextField.addTarget(self, action: #selector(textFieldEditingBegin(textField:)), for: .editingDidBegin)


        
        validationLabel.textColor = UIColor.green
        validationLabel.text = "Validation passed"
        
        validationLabel.isHidden = true
    }
    
    
    @objc
    func textFieldEditingEnded(textField: UITextField) {
        validationLabel.isHidden = true
    }
    
    @objc
    func textFieldEditingBegin(textField: UITextField) {
        validationLabel.isHidden = false
    }
    
    @objc
    func textFieldDidChange(textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        validationLabel.isHidden = false

        
        var isValid = false
        if text.count > 4 {
            isValid = true
        }
        
        if isValid {
            validationLabel.textColor = UIColor.green
            validationLabel.text = "Validation passed"
        } else {
            validationLabel.textColor = UIColor.red
            validationLabel.text = "Validation error"
        }
    }
    
    func loadNib() -> UIView? {
        let bundle = Bundle(for: Self.self)
        return bundle.loadNibNamed(String(describing: Self.self), owner: self, options: nil)?.first as? UIView
    }
}
