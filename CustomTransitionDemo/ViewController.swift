//
//  ViewController.swift
//  CustomTransitionDemo
//
//  Created by Robert Ryan on 2/13/17.
//  Copyright © 2017 Robert Ryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panDown = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(panDown)
    }
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    // pan down transitions to next view controller
    
    func handleGesture(_ gesture: UIPanGestureRecognizer) {
        let translate = gesture.translation(in: gesture.view)
        let percent   = translate.y / gesture.view!.bounds.size.height
        
        if gesture.state == .began {
            let controller = storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
            interactionController = UIPercentDrivenInteractiveTransition()
            controller.customTransitionDelegate.interactionController = interactionController
            
            show(controller, sender: self)
        } else if gesture.state == .changed {
            interactionController?.update(percent)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            let velocity = gesture.velocity(in: gesture.view)
            if (percent > 0.5 && velocity.y == 0) || velocity.y > 0 {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil
        }
    }

}

