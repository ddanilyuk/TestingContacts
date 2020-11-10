//
//  SwipeInteractionController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 10.11.2020.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    
    var interactionInProgress = false
    
    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!
    
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        
        prepareGestureRecognizer(in: viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        let newTouch = gestureRecognizer.location(in: self.viewController.view)
        var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)

//        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
//        var progress = (translation.x / UIScreen.main.bounds.width)
        var progress = (newTouch.x / UIScreen.main.bounds.width)
//        var progress = initialTouchPoint.x

        print("----------")
        print("translation", newTouch)
        print("UIScreen.main.bounds.width", UIScreen.main.bounds.width)
        print()

        print("progress 1", progress)
        
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        print("progress 2", progress)

        print(gestureRecognizer.state.rawValue)
        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            initialTouchPoint = newTouch
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}
