//
//  MainViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Public property
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
    }
    
    // MARK: - Private property

    private var statusBarStyle = UIStatusBarStyle.lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressShowSettings(_ sender: Any) {
        guard let settingsViewController = UIStoryboard.main.instantiateViewController(withIdentifier: SettingsViewController.identifier) as? SettingsViewController else { return }
        settingsViewController.transitioningDelegate = self
        settingsViewController.modalPresentationStyle = .fullScreen
        
        present(settingsViewController, animated: true)
    }
}


// MARK: - MainViewControllerTransitioningDelegate

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(presentationType: .present, offset: UIScreen.main.bounds.width * 0.2)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(presentationType: .dismiss, offset: UIScreen.main.bounds.width * 0.2)
    }
}
