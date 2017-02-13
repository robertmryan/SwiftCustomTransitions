//
//  SecondViewController.swift
//  CustomTransitionDemo
//
//  Created by Robert Ryan on 2/13/17.
//  Copyright © 2017 Robert Ryan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let customTransitionDelegate = TransitioningDelegate()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        modalPresentationStyle = .custom
        transitioningDelegate = customTransitionDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panUp = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        panUp.delegate = self
        view.addGestureRecognizer(panUp)
    }
    
    // pan down transitions to next view controller
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    func handleGesture(_ gesture: UIPanGestureRecognizer) {
        let translate = gesture.translation(in: gesture.view)
        let percent   = -translate.y / gesture.view!.bounds.size.height
        
        if gesture.state == .began {
            interactionController = UIPercentDrivenInteractiveTransition()
            customTransitionDelegate.interactionController = interactionController
            
            dismiss(animated: true)
        } else if gesture.state == .changed {
            interactionController?.update(percent)
        } else if gesture.state == .ended {
            let velocity = gesture.velocity(in: gesture.view)
            if (percent > 0.5 && velocity.y == 0) || velocity.y < 0 {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil
        }
        
    }
    
    @IBAction func didTapButton(_ sender: UIButton) {
        dismiss(animated: true)
    }

}

extension SecondViewController: UIGestureRecognizerDelegate {
    
    // make sure it only recognizes upward gestures
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = pan.translation(in: pan.view)
            let angle = atan2(translation.y, translation.x)
            return abs(angle + .pi / 2.0) < (.pi / 8.0)
        }
        return false
    }
}
