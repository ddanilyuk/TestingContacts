//
//  TestViewController.swift
//  TestingContacts
//
//  Created by Denys Danyliuk on 22.11.2020.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var tabIndicatorViewLeading: NSLayoutConstraint!
    //    let viewControllers: [UIViewController] = [VC1, VC2, VC3] // view controllers swiped between
    let startIndex: CGFloat = 0  // which viewController to begin at (0 means first)
    
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .lightGray
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.clear
        return scrollView
    }()
    
    private func addViewControllers(_ vc: UIViewController, viewControllers: [UIViewController], startIndex: CGFloat = 0) {
        view.addSubview(mainScrollView)
        addViewControllersToContainer(viewControllers: viewControllers, container: mainScrollView, heightDecrease: 100, startIndex: startIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollView.delegate = self

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewControllers: [UIViewController] = []
        
        viewControllers.append(storyboard.instantiateViewController(withIdentifier: "Tab1ViewController") as! Tab1ViewController)
        viewControllers.append(storyboard.instantiateViewController(withIdentifier: "Tab2ViewController") as! Tab2ViewController)

        addViewControllers(self, viewControllers: viewControllers, startIndex: startIndex)
    }
}

extension TestViewController:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabIndicatorViewLeading.constant = scrollView.contentOffset.x / (scrollView.bounds.width / (UIScreen.main.bounds.width / 2))
    }
}

extension UIViewController {
    public func addViewControllerToContainer(viewController: UIViewController, count: CGFloat = 0, container: UIScrollView, heightDecrease: CGFloat = 0, startIndex: CGFloat = 0) {
        
        let multiplier: CGFloat = count
        
        addChild(viewController)
        container.addSubview(viewController.view)
        container.contentSize.width += viewController.view.frame.width
        container.contentSize.height = viewController.view.frame.height - heightDecrease
        
        container.frame = CGRect(x: viewController.view.frame.origin.x,
                                 y: viewController.view.frame.origin.y,
                                 width: viewController.view.frame.width,
                                 height: viewController.view.frame.height - heightDecrease)
        container.frame.origin.y += heightDecrease
        
        container.contentOffset.x = container.frame.width * startIndex
        
        viewController.view.frame.size.width = container.frame.width
        viewController.view.frame.size.height = container.frame.height
        viewController.view.frame.origin.x = container.frame.width * multiplier
        
    }
    
    public func addViewControllersToContainer(viewControllers: [UIViewController], container: UIScrollView, heightDecrease: CGFloat = 0, startIndex: CGFloat) {
        var count: CGFloat = 0
        for viewController in viewControllers {
            addViewControllerToContainer(viewController: viewController, count: count, container: container, heightDecrease: heightDecrease, startIndex: startIndex)
            count += 1
        }
    }
}
