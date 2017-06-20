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
        panDown.delegate = self
        view.addGestureRecognizer(panDown)
    }
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    // pan down transitions to next view controller
    
    @objc func handleGesture(_ gesture: UIPanGestureRecognizer) {
        let translate = gesture.translation(in: gesture.view)
        let percent   = translate.y / gesture.view!.bounds.size.height
        
        if gesture.state == .possible {
            if translate != .zero {
                let angle = atan2(translate.y, translate.x)
                print(angle)
            }
        } else if gesture.state == .began {
            let controller = storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
            interactionController = UIPercentDrivenInteractiveTransition()
            controller.customTransitionDelegate.interactionController = interactionController
            
            present(controller, animated: true)
        } else if gesture.state == .changed {
            interactionController?.update(percent)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            let velocity = gesture.velocity(in: gesture.view)
            interactionController?.completionSpeed = 0.999  // https://stackoverflow.com/a/42972283/1271826
            if (percent > 0.5 && velocity.y == 0) || velocity.y > 0 {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil
        }
    }

}

extension ViewController: UIGestureRecognizerDelegate {
    
    // make sure it only recognizes downward gestures
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pan = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = pan.translation(in: pan.view)
            let angle = atan2(translation.y, translation.x)
            return abs(angle - .pi / 2.0) < (.pi / 8.0)
        }
        return false
    }

}
