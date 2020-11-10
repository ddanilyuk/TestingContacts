//
//  SwipeInteractionController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

final class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Public property
    
    public var interactionInProgress = false
    
    // MARK: - Private property

    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        super.init()
        
        self.viewController = viewController
        prepareGestureRecognizer(in: viewController.view)
    }
    
    // MARK: - Private Functions
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: self.viewController.view)
        let progress = touchPoint.x / UIScreen.main.bounds.width

        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            _ = shouldCompleteTransition ? finish() : cancel()
        default:
            break
        }
    }
}
