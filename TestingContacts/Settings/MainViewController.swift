//
//  MainViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    var animator: SettingsAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressShowSettings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let settingsVC = storyboard.instantiateViewController(withIdentifier: SettingsViewController.identifier) as? SettingsViewController else { return }

        settingsVC.transitioningDelegate = self
        settingsVC.modalPresentationStyle = .fullScreen
        present(settingsVC, animated: true)
    }
}


extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SettingsAnimator(presentationType: .present)
    }
    
    // 3
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SettingsAnimator(presentationType: .dismiss)
    }
}
