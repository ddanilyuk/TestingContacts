//
//  ProfileViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var swipeInteractionController: SwipeInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeInteractionController = SwipeInteractionController(viewController: self)
    }
    
    @IBAction func didPressBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }    
}
