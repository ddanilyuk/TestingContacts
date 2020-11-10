//
//  Animator.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

final class SettingsAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        
    static let duration: TimeInterval = 0.7

    // MARK: - Public property
    
    public let presentationType: PresentationType
    public var offset: CGFloat = 0
    public var interactionController: SwipeInteractionController? = nil

    init(presentationType: PresentationType, offset: CGFloat = 0, interactionController: SwipeInteractionController? = nil) {
        
        self.presentationType = presentationType
        self.offset = offset
        self.interactionController = interactionController
    }
    
    // MARK: - Public Functions
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        var snapshotView = UIView()
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        switch presentationType {
        case .present:
            snapshotView = toViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView()
            toViewController.view.isHidden = true
            snapshotView.layer.transform = CATransform3DMakeTranslation(UIScreen.main.bounds.width - offset, 0, 0)
        case .dismiss:
            if let fromViewController = fromViewController as? PartOverlayViewController {
                snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView()
                
                // Remove background from viewController (with map)
                fromViewController.backgroundView.isHidden = true
            }
            snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView()
            fromViewController.view.isHidden = true
        }
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotView)
        
        // Change animation option to linear when user swipe back
        var options = UIView.AnimationOptions.curveEaseInOut
        if interactionController?.interactionInProgress ?? false {
            options = UIView.AnimationOptions.curveLinear
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: options) {
            switch self.presentationType {
            case .present:
                snapshotView.layer.transform = CATransform3DMakeTranslation(0, 0, 0)
            case .dismiss:
                snapshotView.layer.transform = CATransform3DMakeTranslation(UIScreen.main.bounds.width - self.offset, 0, 0)
            }
        } completion: { _ in
            switch self.presentationType {
            case .present:
                toViewController.view.isHidden = false
                
                if let toViewController = toViewController as? PartOverlayViewController {
                    toViewController.backgroundView.addSubview(fromViewController.view.snapshotView(afterScreenUpdates: true) ?? UIView())
                }
            case .dismiss:
                fromViewController.view.isHidden = false
            }
            
            if transitionContext.transitionWasCancelled {
                toViewController.view.removeFromSuperview()
            }
            
            snapshotView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}


// MARK: - SettingsAnimator + PresentationType

extension SettingsAnimator {
    
    enum PresentationType {
        case present
        case dismiss
    }
}
