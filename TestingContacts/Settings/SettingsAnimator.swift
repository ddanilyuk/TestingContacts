//
//  Animator.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

final class SettingsAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        
    static let duration: TimeInterval = 0.6
    
    enum PresentationType {
        case present
        case dismiss
    }
    
    var presentationType: PresentationType
    
    init(presentationType: PresentationType) {
        self.presentationType = presentationType
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        var snapshotView = UIView()
        let containerView = transitionContext.containerView
        
        
        switch presentationType {
        case .present:
            snapshotView = toViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView()
            toViewController.view.isHidden = true
            snapshotView.layer.transform = CATransform3DMakeTranslation(UIScreen.main.bounds.width * 0.8, 0, 0)
        case .dismiss:
            if let fromViewController = fromViewController as? SettingsViewController {
                snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView()
                fromViewController.backgroundView.isHidden = true
                snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView()
                fromViewController.view.isHidden = true
            }
        }
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotView)
        let duration = transitionDuration(using: transitionContext)

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                if let fromViewController = fromViewController as? SettingsViewController {
                    fromViewController.backgroundView.isHidden = true
                }
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                    switch self.presentationType {
                    case .present:
                        snapshotView.layer.transform = CATransform3DMakeTranslation(0, 0, 0)
                    case .dismiss:
                        snapshotView.layer.transform = CATransform3DMakeTranslation(UIScreen.main.bounds.width * 0.8, 0, 0)
                    }
                }
            },
            completion: { _ in

                switch self.presentationType {
                case .present:
                    toViewController.view.isHidden = false
                    
                    if let toViewController = toViewController as? SettingsViewController {
                        toViewController.backgroundView.addSubview(fromViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView())
                    }
                case .dismiss:
                    fromViewController.view.isHidden = false
                }
                snapshotView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
