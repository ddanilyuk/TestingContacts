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
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else { return }
        
        var snapshot = UIView()
        switch presentationType {
        case .present:
            snapshot = toVC.view.snapshotView(afterScreenUpdates: true) ?? UIView()
        case .dismiss:
            if let fromVC = fromVC as? SettingsViewController {
                fromVC.backgroundView.subviews.forEach{ $0.isHidden = true }
            }
            snapshot = fromVC.view.snapshotView(afterScreenUpdates: true) ?? UIView()
        }
        print(snapshot)
        snapshot.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        let duration = transitionDuration(using: transitionContext)
        containerView.addSubview(snapshot)

        switch presentationType {
        case .present:
            toVC.view.isHidden = true
            snapshot.layer.transform = CATransform3DMakeTranslation(UIScreen.main.bounds.width * 0.8, 0, 0)
        case .dismiss:
            fromVC.view.isHidden = true
            snapshot.layer.transform = CATransform3DMakeTranslation(0, 0, 0)
        }
        

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeLinear,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                    switch self.presentationType {
                    case .present:
                        snapshot.layer.transform = CATransform3DMakeTranslation(0, 0, 0)
                    case .dismiss:
                        snapshot.layer.transform = CATransform3DMakeTranslation(UIScreen.main.bounds.width * 0.8, 0, 0)
                    }
                }
            },
            completion: { _ in

                switch self.presentationType {
                case .present:
                    toVC.view.isHidden = false
                    
                    if let toVC = toVC as? SettingsViewController {
                        toVC.backgroundView.addSubview(fromVC.view.snapshotView(afterScreenUpdates: true) ?? UIView())
                    }
                case .dismiss:
                    fromVC.view.isHidden = false
                }
                snapshot.removeFromSuperview()

                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
