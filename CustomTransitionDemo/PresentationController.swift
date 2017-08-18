//
//  PresentationController.swift
//  CustomTransitionDemo
//
//  Created by Robert Ryan on 2/13/17.
//  Copyright © 2017 Robert Ryan. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    override var shouldRemovePresentersView: Bool { return false }
    
    var dimmingView: UIView!
    
    override func presentationTransitionWillBegin() {
        dimmingView = UIView(frame: containerView!.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        containerView?.addSubview(dimmingView)
        let transitionCoordinator = presentingViewController.transitionCoordinator!
        
        dimmingView.alpha = 0
        transitionCoordinator.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 1
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
            dimmingView = nil
        }
    }

    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentingViewController.transitionCoordinator!
        
        transitionCoordinator.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
            dimmingView = nil
        }
    }
}
