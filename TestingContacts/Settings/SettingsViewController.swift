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
    
    fileprivate var animator: SettingsAnimator?
    fileprivate var profileVC: ProfileViewController?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        contentView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20)
    }
    
    // MARK: - IBActions
    
    @IBAction func didPressMyProfile(_ sender: UIButton) {
        guard let profileVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: ProfileViewController.identifier) as? ProfileViewController else { return }
        self.profileVC = profileVC
        profileVC.transitioningDelegate = self
        profileVC.modalPresentationStyle = .fullScreen
        
        present(profileVC, animated: true)
    }
    
    @IBAction func didPressExit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - SettingsViewControllerTransitioningDelegate

extension SettingsViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let profileVC = profileVC else { return nil }
        animator = SettingsAnimator(presentationType: .present, interactionController: profileVC.swipeInteractionController)
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let profileVC = profileVC else { return nil }
        animator = SettingsAnimator(presentationType: .dismiss, interactionController: profileVC.swipeInteractionController)
        return animator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let animator = animator as? SettingsAnimator,
              let interactionController = animator.interactionController,
              interactionController.interactionInProgress else { return nil }
        return interactionController
    }
}
