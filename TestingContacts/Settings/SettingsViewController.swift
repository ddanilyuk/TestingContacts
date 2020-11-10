//
//  SettingsViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        backgroundView.isHidden = false

//        backgroundImageView.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

//        backgroundImageView.isHidden = true
    }
    
    deinit {
        print("deinited")
    }
    
    override func viewDidLayoutSubviews() {
        contentView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20)
    }
    
    @IBAction func didPressExit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

