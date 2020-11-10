//
//  MainViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressShowSettings(_ sender: Any) {
        guard let settingsViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: SettingsViewController.identifier) as? SettingsViewController else { return }
        settingsViewController.transitioningDelegate = self
        settingsViewController.modalPresentationStyle = .fullScreen
        
        present(settingsViewController, animated: true)
    }
}


// MARK: - MainViewControllerTransitioningDelegate

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SettingsAnimator(presentationType: .present, offset: UIScreen.main.bounds.width * 0.2)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SettingsAnimator(presentationType: .dismiss, offset: UIScreen.main.bounds.width * 0.2)
    }
}
