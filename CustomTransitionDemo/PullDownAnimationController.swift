//
//  PullDownAnimationController.swift
//  CustomTransitionDemo
//
//  Created by Robert Ryan on 2/13/17.
//  Copyright © 2017 Robert Ryan. All rights reserved.
//

import UIKit

class PullDownAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum TransitionType {
        case presenting
        case dismissing
    }
    
    let transitionType: TransitionType
    
    init(transitionType: TransitionType) {
        self.transitionType = transitionType
        
        super.init()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let inView   = transitionContext.containerView
        let toView   = transitionContext.viewController(forKey: .to)!.view!
        let fromView = transitionContext.viewController(forKey: .from)!.view!
        
        var frame = inView.bounds
        
        switch transitionType {
        case .presenting:
            frame.origin.y = -frame.size.height
            toView.frame = frame
            
            inView.addSubview(toView)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView.frame = inView.bounds
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        case .dismissing:
            toView.frame = frame
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                frame.origin.y = -frame.size.height
                fromView.frame = frame
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}

