//
//  SettingsViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

final class SettingsViewController: UIViewController, PartOverlayViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    // MARK: - Private property
    
    fileprivate var animator: TransitionAnimator?
    fileprivate var profileViewController: ProfileViewController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        contentView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20)
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressMyProfile(_ sender: UIButton) {
        guard let profileViewController = UIStoryboard.main.instantiateViewController(withIdentifier: ProfileViewController.identifier) as? ProfileViewController else { return }
        self.profileViewController = profileViewController
        profileViewController.transitioningDelegate = self
        profileViewController.modalPresentationStyle = .fullScreen
        
        present(profileViewController, animated: true)
    }
    
    @IBAction func didPressDismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - SettingsViewControllerTransitioningDelegate

extension SettingsViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let profileViewController = profileViewController else { return nil }
        animator = TransitionAnimator(presentationType: .present, interactionController: profileViewController.swipeInteractionController)
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let profileViewController = profileViewController else { return nil }
        animator = TransitionAnimator(presentationType: .dismiss, interactionController: profileViewController.swipeInteractionController)
        return animator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? TransitionAnimator,
              let interactionController = animator.interactionController,
              interactionController.interactionInProgress else { return nil }
        return interactionController
    }
}
