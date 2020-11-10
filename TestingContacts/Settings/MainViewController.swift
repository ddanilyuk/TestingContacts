//
//  MainViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    var animator: SettingsAnimator?
    var settingsVC: SettingsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didPressShowSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let settingsViewController = storyboard.instantiateViewController(withIdentifier: SettingsViewController.identifier) as? SettingsViewController else { return }
        settingsVC = settingsViewController
        settingsViewController.transitioningDelegate = self
        settingsViewController.modalPresentationStyle = .fullScreen
        present(settingsViewController, animated: true)
    }
}


extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SettingsAnimator(presentationType: .present, scale: 0.8)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        guard let settingsVC = settingsVC else { return nil }

        return SettingsAnimator(presentationType: .dismiss, scale: 0.8)
    }
}
