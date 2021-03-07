//
//  BaseTextField.swift
//  homeSafe
//
//  Created by Dima Hapich on 23.10.2020.
//

import UIKit

class BaseTextField: UITextField {
    
    enum Images {
        static let showEye = UIImage(named: "eyeHideIcon")!
        static let hideEye = UIImage(named: "eyeShowIcon")!
    }
    
    
    // MARK: - IBInspectable
    
    @IBInspectable var leftIcon: UIImage? = nil {
        didSet {
            leftImageView.image = leftIcon?.withRenderingMode(.alwaysTemplate)
            setNeedsLayout()
        }
    }
    
    @IBInspectable var rightIcon: UIImage? = nil {
        didSet {
            updateRightView()
        }
    }
    
    @IBInspectable var isShowingEye: Bool = false {
        didSet {
            updateRightView()
        }
    }
    
    var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    // MARK: - Private Properties
    
    private var iconInset = UIEdgeInsets(top: 12, left: 25, bottom: 12, right: 0)
    private var buttonAction: ((UIButton) -> Void)?
    
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - UI Setups
    
    func setup() {
        
        leftView = leftImageView as UIImageView
        updateRightView()
        
        layer.masksToBounds = true
//        font = R.font.spaceMonoRegular(size: 20)
//        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
//                                                   attributes: [.foregroundColor: R.color.lavenderGray()!,
//                                                                .font: font as Any])
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        
        return CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        return CGRect(x: bounds.width - bounds.height, y: 0, width: bounds.height, height: bounds.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let padding: CGFloat = 15 + (leftView?.frame.width ?? 0.0)
        return CGRect(x: bounds.origin.x + padding + (rightView?.frame.width ?? 0) / 2,
                      y: bounds.origin.y,
                      width: bounds.width - padding - (rightView?.frame.width ?? 0),
                      height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let padding: CGFloat = 15 + (leftView?.frame.width ?? 0.0)
        return CGRect(x: bounds.origin.x + padding + (rightView?.frame.width ?? 0) / 2,
                      y: bounds.origin.y,
                      width: bounds.width - padding - (rightView?.frame.width ?? 0),
                      height: bounds.height)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if leftIcon != nil {
            leftViewMode = .always
            updateIconFrame()
        } else {
            leftViewMode = .never
        }
    }
    
    private func updateIconFrame() {
        
        let newFrame = CGRect(x: leftImageView.frame.origin.x + iconInset.left,
                              y: leftImageView.frame.origin.y + iconInset.top,
                              width: leftImageView.frame.width - iconInset.left - iconInset.right,
                              height: leftImageView.frame.height - iconInset.top - iconInset.bottom)
        leftImageView.frame = newFrame
    }
    
    private func updateRightView() {
        
        if rightIcon == nil, !isShowingEye {
            rightViewMode = .never
            isSecureTextEntry = false
            return
        }
        rightViewMode = .always
        
        let button = UIButton(type: .custom)
        
        let image = isShowingEye ? Images.showEye : rightIcon
        button.setImage(image, for: .normal)
        button.imageEdgeInsets.right = 15
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .clear
        
        if isShowingEye {
            isSecureTextEntry = true
            button.addTarget(self, action: #selector(didTapEyeButton), for: .touchUpInside)
        } else {
            button.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        }
        
        rightView = button as UIButton
    }
    
    // MARK: - Public Methods
    
    func addRightButtonAction(action: ((UIButton) -> Void)?) {
        
        buttonAction = action
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapEyeButton(_ button: UIButton) {
        
        isSecureTextEntry.toggle()
        let image = isSecureTextEntry ? Images.showEye : Images.hideEye
        button.setImage(image, for: .normal)
    }
    
    @objc
    private func didTapRightButton(_ sender: UIButton) {
        
        buttonAction?(sender)
    }
}
