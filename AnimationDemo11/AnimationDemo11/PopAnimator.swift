//
//  PopAnimator.swift
//  AnimationDemo11
//
//  Created by duzhe on 15/10/5.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class PopAnimator: NSObject,UIViewControllerAnimatedTransitioning {

    let duration = 1.0
    var presenting = true  //是否正在presenting
    var originFrame = CGRect.zero
    var hideImage:(()->())?
    
    //动画持续时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    
    //动画执行的方法
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let detailView = presenting ? toView :
            transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : detailView!.frame
        let finalFrame = presenting ? detailView!.frame : originFrame
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
                initialFrame.height / finalFrame.height :
                finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor,
            yScaleFactor)
        if presenting {
            detailView!.transform = scaleTransform
            detailView!.center = CGPoint(
            x: CGRectGetMidX(initialFrame),
            y: CGRectGetMidY(initialFrame))
            detailView!.clipsToBounds = true
        }
        
        
        containerView!.addSubview(toView!)
        containerView!.bringSubviewToFront(detailView!)
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
                detailView!.transform = self.presenting ?
                CGAffineTransformIdentity : scaleTransform
                detailView!.center = CGPoint(x: CGRectGetMidX(finalFrame),
                y: CGRectGetMidY(finalFrame))
                
            }) { (_) -> Void in
                
                if !self.presenting{
                    self.hidIt()
                }
                transitionContext.completeTransition(true)
        }
       
//        
//        containerView!.addSubview(toView!)
//        toView!.alpha = 0.0
//        UIView.animateWithDuration(duration,
//            animations: {
//                toView!.alpha = 1.0
//            }, completion: { _ in
//                transitionContext.completeTransition(true)
//        })
    }
    
    func hidIt(){
        hideImage?()
    }
    
}
