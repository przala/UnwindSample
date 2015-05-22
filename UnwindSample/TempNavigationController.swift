//
//  TempNavigationController.swift
//  Ratings
//
//  Created by Pushparaj Zala on 5/22/15.
//  Copyright (c) 2015 Pushparaj Zala. All rights reserved.
//

import UIKit

class TempNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        return UIStoryboardSegue(identifier: identifier, source: fromViewController, destination: toViewController) {
            let fromView = fromViewController.view
            let toView = toViewController.view
            if let containerView = fromView.superview {
                let initialFrame = fromView.frame
                var offscreenRect = initialFrame
                var offscreenRectFinal = initialFrame
                offscreenRect.origin.x += CGRectGetWidth(initialFrame)
                offscreenRectFinal.origin.x -= CGRectGetWidth(initialFrame)
                toView.frame = offscreenRect
                containerView.addSubview(toView)
                let duration: NSTimeInterval = 1.0
                let delay: NSTimeInterval = 0.0
                let options = UIViewAnimationOptions.CurveEaseInOut
                let damping: CGFloat = 0.9
                let velocity: CGFloat = 4.0
                UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: damping,
                    initialSpringVelocity: velocity, options: options, animations: {
                        toView.frame = initialFrame
                        fromView.frame = offscreenRectFinal
                        
                    }, completion: { finished in
                        fromView.removeFromSuperview()
                        if let navController = toViewController.navigationController {
                            navController.popToViewController(toViewController, animated: false)
                        }
                })
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
