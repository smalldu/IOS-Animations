//
//  AvatarView.swift
//  AnimationDemo5
//
//  Created by duzhe on 15/9/26.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

@IBDesignable
class AvatarView: UIView {
    let lineWidth: CGFloat = 6.0
    let animationDuration = 1.0
    
    var isSuqare = false
    
    //ui
    let photoLayer = CALayer()
    let circleLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
        }()
    
    var shouldTransitionToFinishedState = false
    @IBInspectable
    var image: UIImage! {
        didSet {
          photoLayer.contents = image.cgImage
        }
    }
    
    @IBInspectable
    var name: String? {
        didSet {
            label.text = name
        }
    }
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.clear
        //Size the avatar image to fit
        photoLayer.frame = CGRect(
            x: 0,
            y: -10,
            width: 81,
            height: 91)
        
        //Draw the circle
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        
        //Size the layer
        maskLayer.path = circleLayer.path
        maskLayer.position = CGPoint(x: 0.0, y: 10)
//        maskLayer.strokeColor = UIColor.redColor().CGColor
        
        //Size the label
        label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
    }
    
    override func didMoveToSuperview() {
        self.layer.addSublayer(photoLayer)
        photoLayer.mask = maskLayer
        layer.addSublayer(circleLayer)
        addSubview(label)
    }
    
    func reInit(){
        isSuqare = false
        shouldTransitionToFinishedState = false
        self.backgroundColor = UIColor.clear
        //Size the avatar image to fit
        photoLayer.frame = CGRect(
            x: 0,
            y: -10,
            width: 81,
            height: 91)
        
        //Draw the circle
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        
        //Size the layer
        maskLayer.path = circleLayer.path
        maskLayer.position = CGPoint(x: 0.0, y: 10)
        //        maskLayer.strokeColor = UIColor.redColor().CGColor
        
        //Size the label
        label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
    }
    
    //两个参数 一个是移动的地点  一个是变形方式
    func bounceOffPoint(_ bouncePoint: CGPoint, morphSize: CGSize) {
        
        let originalCenter = self.center
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            
                self.center = bouncePoint
            
            }) { (_) -> Void in
                if self.shouldTransitionToFinishedState {
                    self.isSuqare = true
                    let squareBezier = UIBezierPath(rect: self.bounds)
                    let animate = CABasicAnimation(keyPath: "path")
                    animate.duration = 0.25
                    animate.fromValue = self.circleLayer.path
                    animate.toValue = squareBezier.cgPath
                    self.circleLayer.add(animate, forKey: nil)
                    self.circleLayer.path = squareBezier.cgPath
                    self.maskLayer.add(animate, forKey: nil)
                    self.maskLayer.path = squareBezier.cgPath
                    
                }
                if !self.isSuqare {
                    self.bounceOffPoint(originalCenter, morphSize: morphSize)
                }
        }
        let morphedFrame = (originalCenter.x > bouncePoint.x) ?
            CGRect(x: 0.0, y: bounds.height - morphSize.height,
            width: morphSize.width, height: morphSize.height):
            CGRect(x: bounds.width - morphSize.width,
            y: bounds.height - morphSize.height,
            width: morphSize.width, height: morphSize.height)
        
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = animationDuration
        morphAnimation.toValue = UIBezierPath(ovalIn: morphedFrame).cgPath
        morphAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        circleLayer.add(morphAnimation, forKey: nil)
        maskLayer.add(morphAnimation, forKey: nil)
    }
    
    
    
    
    
    
}
