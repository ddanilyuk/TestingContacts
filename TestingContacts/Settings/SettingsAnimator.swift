//
//  Animator.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

final class SettingsAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        
    enum PresentationType {
        case present
        case dismiss
    }
    
    static let duration: TimeInterval = 0.6
    
    var type: PresentationType
    
    init(type: PresentationType) {
        self.type = type
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let snapshotFromVC = fromVC.view.snapshotView(afterScreenUpdates: true),
              let snapshotToVC = toVC.view.snapshotView(afterScreenUpdates: true)
        else { return }
    
        let containerView = transitionContext.containerView

        snapshotToVC.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        snapshotFromVC.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        containerView.addSubview(toVC.view)

        let duration = transitionDuration(using: transitionContext)
        
        switch type {
        case .present:
            toVC.view.isHidden = true
            snapshotToVC.layer.transform = CATransform3DMakeTranslation(UIScreen.main.bounds.width, 0, 0)
            containerView.addSubview(snapshotToVC)
        case .dismiss:
            fromVC.view.isHidden = true
            snapshotFromVC.layer.transform = CATransform3DMakeTranslation(0, 0, 0)
            containerView.addSubview(snapshotFromVC)
        }
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                    switch self.type {
                    case .present:
                        snapshotToVC.layer.transform = CATransform3DMakeTranslation(0, 0, 0)
                    case .dismiss:
                        snapshotFromVC.layer.transform = CATransform3DMakeTranslation(UIScreen.main.bounds.width, 0, 0)
                    }
                }
            },
            completion: { _ in
                switch self.type {
                case .present:
                    toVC.view.isHidden = false
                    snapshotToVC.removeFromSuperview()
                case .dismiss:
                    fromVC.view.isHidden = false
                    snapshotFromVC.removeFromSuperview()
                }
                if transitionContext.transitionWasCancelled {
                    toVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
