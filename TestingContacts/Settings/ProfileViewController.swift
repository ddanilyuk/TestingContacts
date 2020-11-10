//
//  ProfileViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Public property
    
    public var swipeInteractionController: SwipeInteractionController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeInteractionController = SwipeInteractionController(viewController: self)
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressDismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
