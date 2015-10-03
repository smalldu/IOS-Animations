//
//  DZRefreshViewTwo.swift
//  AnimationDemo7
//
//  Created by duzhe on 15/10/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

protocol RefreshDelegate{
    func doRefresh(refreshView: DZRefreshViewTwo)
}

class DZRefreshViewTwo: UIView,UIScrollViewDelegate {

    var scrollView:UIScrollView!
    var viewHeight = 100.0
    var isRefreshing = false
    var delegate:RefreshDelegate?
    var originTop:CGFloat = 0.0
    var isAnimating = false
    
    var shapeLayer = CAShapeLayer()
    
    var progress:CGFloat = 0.0
    
    init(frame: CGRect , scrollView:UIScrollView) {
        super.init(frame: frame)
        self.scrollView = scrollView
        scrollView.delegate = self
        
        //绘图
        shapeLayer.strokeColor = UIColor.grayColor().CGColor
        layer.addSublayer(shapeLayer)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(scrollView:UIScrollView){
        if let sv = scrollView.superview {
            self.init(frame:CGRectMake(0,-80, sv.frame.size.width ,80),scrollView:scrollView)
        }else{
            self.init(frame:CGRectMake(0,-80, scrollView.frame.size.width ,80),scrollView:scrollView)
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && progress >= 1{
            self.originTop = self.scrollView.contentInset.top
            //执行刷新任务
            delegate?.doRefresh(self)
            beginRefresh()
        }
    }
    
    //计算进度
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offY = max(-1*(scrollView.contentOffset.y+scrollView.contentInset.top),0)
        progress = min(offY / self.frame.size.height , 1.0)
        reDraw(offY)
    }
    
    func beginRefresh(){
        isRefreshing = true
        isAnimating = true
        UIView.animateWithDuration(0.3) {
            var inSet = self.scrollView.contentInset;
            inSet.top += self.frame.size.height
            self.scrollView.contentInset = inSet
        }
        //动画
        let keyAnimation = CAKeyframeAnimation(keyPath: "path")
        keyAnimation.duration = 0.8
        keyAnimation.values = [UIBezierPath(ovalInRect: CGRectMake((self.frame.size.width/2) - 20 , self.frame.size.height/2 - 15 , 10 , 10 )).CGPath ,
            UIBezierPath(ovalInRect: CGRectMake((self.frame.size.width/2) - 8, self.frame.size.height/2 - 2 , 30 , 30 )).CGPath,
            UIBezierPath(ovalInRect: CGRectMake((self.frame.size.width/2) - 18 , self.frame.size.height/2 - 18 , 20 , 20 )).CGPath,
            UIBezierPath(ovalInRect: CGRectMake((self.frame.size.width/2) - 12 , self.frame.size.height/2 - 7 , 35 , 35 )).CGPath,
            UIBezierPath(ovalInRect: CGRectMake((self.frame.size.width/2) - 17 , self.frame.size.height/2 - 17 , 28 , 28 )).CGPath,
            UIBezierPath(ovalInRect: CGRectMake((self.frame.size.width/2) - 15 , self.frame.size.height/2 - 13 , 33 , 33 )).CGPath,
            UIBezierPath(ovalInRect: CGRectMake((self.frame.size.width/2) - 15 , self.frame.size.height/2 - 15 , 30 , 30 )).CGPath
        ]
       
        self.shapeLayer.addAnimation(keyAnimation, forKey: nil)
        
        self.shapeLayer.path = UIBezierPath(ovalInRect: CGRectMake((self.frame.size.width/2) - 15 , self.frame.size.height/2 - 15 , 30 , 30 )).CGPath
        
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 4
        shapeLayer.lineDashPattern = [2]
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.duration = 2
        baseAnimation.fromValue = 0
        baseAnimation.toValue = 1
        baseAnimation.repeatDuration = 5
        shapeLayer.addAnimation(baseAnimation, forKey: nil)
    }
    
    
    func endRefresh(){
        isRefreshing = false
        isAnimating = false
        UIView.animateWithDuration(0.3) {
            var inSet = self.scrollView.contentInset;
            inSet.top -= self.frame.size.height
            self.scrollView.contentInset = inSet
        }
    }
    
    //绘制
    func reDraw(offY:CGFloat){
        if !isAnimating {
        shapeLayer.lineWidth = 0
        shapeLayer.lineDashPattern = []
        shapeLayer.fillColor = UIColor.grayColor().CGColor
        let  y = originTop == 0.0 ? frame.size.height - offY + 1 :  frame.size.height - offY + 1 - (scrollView.contentInset.top - originTop)
        let width = frame.size.width * progress * 0.8 > 15 ? 15:frame.size.width * progress * 0.8
            shapeLayer.path = UIBezierPath(ovalInRect: CGRectMake((frame.size.width/2) - 7.5 , y , width , frame.size.height * progress * 0.8)).CGPath
        
        }
    }
    
}
