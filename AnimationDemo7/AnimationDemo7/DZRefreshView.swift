//
//  DZRefreshView.swift
//  AnimationDemo7
//
//  Created by duzhe on 15/9/27.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
protocol RefreshViewDelegate {
    func refreshViewDidRefresh(refreshView: DZRefreshView)
}

class DZRefreshView: UIView,UIScrollViewDelegate {

    var scrollView: UIScrollView?
    var delegate: RefreshViewDelegate?
    var isRefreshing = false
    var progress: CGFloat = 0.0
    
    var shapeLayer:CAShapeLayer!
    let airPlaneLayer:CALayer = CALayer()
    
    init(frame:CGRect , inScrollView:UIScrollView){
        super.init(frame: frame);
        
        self.scrollView = inScrollView
        
        //添加背景图
        let imgView = UIImageView(image: UIImage(named: "refresh-view-bg.png"))
        imgView.frame = bounds
        imgView.contentMode = .ScaleAspectFill
        imgView.clipsToBounds = true
        addSubview(imgView)
        scrollView?.delegate = self
        
        //添加圆形layer 
        shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 4
        shapeLayer.lineDashPattern = [2]
        let refreshRadius = frame.size.height/2 * 0.8
        shapeLayer.path = UIBezierPath(ovalInRect: CGRectMake(frame.size.width/2 - refreshRadius, frame.size.height/2 - refreshRadius , 2 * refreshRadius, 2 * refreshRadius)).CGPath
        self.layer.addSublayer(shapeLayer)
        
        //飞机层
        let airImage = UIImage(named: "airplane")
        airPlaneLayer.contents = airImage?.CGImage
        airPlaneLayer.bounds = CGRectMake(0, 0, airImage!.size.width , airImage!.size.height)
        airPlaneLayer.position = CGPoint(x: frame.size.width/2 + refreshRadius , y: frame.size.height / 2)
        airPlaneLayer.opacity = 0.0
        
        layer.addSublayer(airPlaneLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func beginRefreshing(){
        isRefreshing = true
        UIView.animateWithDuration(0.3) {
            var newInsets = self.scrollView!.contentInset
            newInsets.top += self.frame.size.height
            self.scrollView!.contentInset = newInsets
        }
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeBegin")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation  = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.5
        strokeAnimationGroup.repeatDuration = 5
        strokeAnimationGroup.animations = [strokeStartAnimation,strokeEndAnimation]
        shapeLayer.addAnimation(strokeAnimationGroup, forKey: nil)
        
        //飞机的动画
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = shapeLayer.path
        flightAnimation.calculationMode = kCAAnimationPaced //使动画光滑的进行 
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue =  CGFloat(2 * M_PI)
        
        let flightAnimationGroup = CAAnimationGroup()
        flightAnimationGroup.duration = 1.5
        flightAnimationGroup.repeatDuration = 5.0
        flightAnimationGroup.animations = [flightAnimation,rotateAnimation]
        airPlaneLayer.addAnimation(flightAnimationGroup, forKey: nil)
        
    }
    
    func endRefreshing() {
        isRefreshing = false
        UIView.animateWithDuration(0.3, delay:0.0, options: .CurveEaseOut ,animations: {
            var newInsets = self.scrollView!.contentInset
            newInsets.top -= self.frame.size.height
            self.scrollView!.contentInset = newInsets
            }, completion: {_ in
                //finished
        })
    }
    
    //滚动的时候
    func scrollViewDidScroll(scrollView: UIScrollView) {
       //print(scrollView.contentInset.top)
       let offSetY = CGFloat(max(-(scrollView.contentOffset.y + scrollView.contentInset.top),0))
       self.progress = min(offSetY / self.frame.size.height, 1.0)
       redrawFromProgress(progress)
        
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && self.progress >= 1.0 {
            delegate?.refreshViewDidRefresh(self) //执行刷新操作
            beginRefreshing()
            airPlaneLayer.opacity = 1
        }
         //shapeLayer.strokeEnd = 1
    }
    
    func redrawFromProgress(progress: CGFloat) {
        shapeLayer.strokeEnd = progress
        airPlaneLayer.opacity = Float(progress)
    }

}
