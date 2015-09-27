//
//  AnimatedLabel.swift
//  AnimationDemo6
//
//  Created by duzhe on 15/9/26.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

@IBDesignable
class AnimatedLabel: UIView {

    let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        //配置gradientLayer
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        let colors = [UIColor.purpleColor().CGColor , UIColor.greenColor().CGColor , UIColor.blackColor().CGColor,UIColor.redColor().CGColor,UIColor.whiteColor().CGColor]
        gradientLayer.colors = colors
        
        let locations = [
            0.25,
            0.5,
            0.75
        ]
        gradientLayer.locations = locations
        
        return gradientLayer
        }()

    @IBInspectable var text: String! {
            didSet {
                setNeedsDisplay()
                UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
                //let context = UIGraphicsGetCurrentContext()
                text.drawInRect(bounds, withAttributes: textAttr)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                let maskLayer = CALayer()
                maskLayer.backgroundColor = UIColor.clearColor().CGColor
                maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
                maskLayer.contents = image.CGImage
                gradientLayer.mask = maskLayer
            }
    }
    
    let textAttr:[String:AnyObject]? = {
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        return [
            NSFontAttributeName:UIFont(name: "HelveticaNeue-Thin",
            size: 28.0)!,
            NSParagraphStyleAttributeName: style
        ]
    }()
    
    override func drawRect(rect: CGRect) {
//        layer.borderColor = UIColor.whiteColor().CGColor
//        layer.borderWidth = 1.0
//        layer.backgroundColor = UIColor(white: 1, alpha: 0.1).CGColor
//        let style = NSMutableParagraphStyle()
//        style.alignment = .Center
//        let font = UIFont(name: "HelveticaNeue-Thin", size: bounds.size.height/2)
//        
//        var attrs:[String : AnyObject]? = [String : AnyObject]?()
//    
//        if var a = attrs {
//            a[NSFontAttributeName] = font
//            a[NSParagraphStyleAttributeName] = style
//            a[NSForegroundColorAttributeName] = UIColor.whiteColor()
//            NSString(string: text).drawInRect(bounds, withAttributes: a)
//        }
       // attrs[NSFontAttributeName] = font
//        attrs[NSParagraphStyleAttributeName] = style
//        attrs[NSForegroundColorAttributeName] = UIColor.whiteColor()
    }
    
    override func layoutSubviews() {
//        gradientLayer.frame = bounds
        gradientLayer.frame = CGRect(
        x: -bounds.size.width,
        y: bounds.origin.y,
        width: 3 * bounds.size.width,
        height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        layer.addSublayer(gradientLayer)
       
        //添加动画
        let gradientAnimate = CABasicAnimation(keyPath: "locations")
        gradientAnimate.fromValue = [0.0, 0.0,0.0,0.0,0.25]
        gradientAnimate.toValue = [0.5, 0.6, 0.7,0.8,0.9,1.0]
        gradientAnimate.duration = 3.0
        gradientAnimate.repeatCount = Float.infinity
        
        gradientLayer.addAnimation(gradientAnimate, forKey: nil)
        
    }
    
}
