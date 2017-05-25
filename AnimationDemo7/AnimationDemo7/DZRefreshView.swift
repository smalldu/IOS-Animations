//
//  DZRefreshView.swift
//  AnimationDemo7
//
//  Created by duzhe on 15/9/27.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
protocol RefreshViewDelegate {
    func refreshViewDidRefresh(_ refreshView: DZRefreshView)
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
        let imgView = UIImageView(image: UIImage(named: "bg"))
        imgView.frame = bounds
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        addSubview(imgView)
        scrollView?.delegate = self
        
        //添加圆形layer 
        shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.lineDashPattern = [2]
        let refreshRadius = frame.size.height/2 * 0.8
        shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: frame.size.width/2 - refreshRadius, y: frame.size.height/2 - refreshRadius , width: 2 * refreshRadius, height: 2 * refreshRadius)).cgPath
        self.layer.addSublayer(shapeLayer)
        
        //飞机层
        let airImage = UIImage(named: "air")
        airPlaneLayer.contents = airImage?.cgImage
        airPlaneLayer.bounds = CGRect(x: 0, y: 0, width: 40 , height: 40)
        airPlaneLayer.position = CGPoint(x: frame.size.width/2 + refreshRadius , y: frame.size.height / 2)
        airPlaneLayer.opacity = 0.0
        
        layer.addSublayer(airPlaneLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func beginRefreshing(){
        isRefreshing = true
        UIView.animate(withDuration: 0.3, animations: {
            var newInsets = self.scrollView!.contentInset
            newInsets.top += self.frame.size.height
            self.scrollView!.contentInset = newInsets
        }) 
        
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
        shapeLayer.add(strokeAnimationGroup, forKey: nil)
        
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
        airPlaneLayer.add(flightAnimationGroup, forKey: nil)
        
    }
    
    func endRefreshing() {
        isRefreshing = false
        UIView.animate(withDuration: 0.3, delay:0.0, options: .curveEaseOut ,animations: {
            var newInsets = self.scrollView!.contentInset
            newInsets.top -= self.frame.size.height
            self.scrollView!.contentInset = newInsets
            }, completion: {_ in
                //finished
        })
    }
    
    //滚动的时候
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       //print(scrollView.contentInset.top)
       let offSetY = CGFloat(max(-(scrollView.contentOffset.y + scrollView.contentInset.top),0))
       self.progress = min(offSetY / self.frame.size.height, 1.0)
       redrawFromProgress(progress)
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && self.progress >= 1.0 {
            delegate?.refreshViewDidRefresh(self) //执行刷新操作
            beginRefreshing()
            airPlaneLayer.opacity = 1
        }
         //shapeLayer.strokeEnd = 1
    }
    
    func redrawFromProgress(_ progress: CGFloat) {
        shapeLayer.strokeEnd = progress
        airPlaneLayer.opacity = Float(progress)
    }

}
