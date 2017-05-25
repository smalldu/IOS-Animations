//
//  DZRefreshViewTwo.swift
//  AnimationDemo7
//
//  Created by duzhe on 15/10/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

protocol RefreshDelegate{
    func doRefresh(_ refreshView: DZRefreshViewTwo)
}

class DZRefreshViewTwo: UIView,UIScrollViewDelegate {

    var scrollView:UIScrollView!
    var viewHeight = 100.0
    var isRefreshing = false
    var delegate:RefreshDelegate?
    var isAnimating = false
    
    var shapeLayer = CAShapeLayer()
    
    var progress:CGFloat = 0.0
    
    init(frame: CGRect , scrollView:UIScrollView) {
        super.init(frame: frame)
        self.scrollView = scrollView
        scrollView.delegate = self
        
        //绘图
        shapeLayer.strokeColor = UIColor.gray.cgColor
        layer.addSublayer(shapeLayer)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(scrollView:UIScrollView){
        if let sv = scrollView.superview {
            self.init(frame:CGRect(x: 0,y: -80, width: sv.frame.size.width ,height: 80),scrollView:scrollView)
        }else{
            self.init(frame:CGRect(x: 0,y: -80, width: scrollView.frame.size.width ,height: 80),scrollView:scrollView)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isRefreshing && progress >= 1{
            //执行刷新任务
            delegate?.doRefresh(self)
            beginRefresh()
        }
    }
    
    //计算进度
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offY = max(-1*(scrollView.contentOffset.y+scrollView.contentInset.top),0)
        progress = min(offY / self.frame.size.height , 1.0)
        reDraw(offY)
    }
    
    func beginRefresh(){
        isRefreshing = true
        isAnimating = true
        UIView.animate(withDuration: 0.3, animations: {
            var inSet = self.scrollView.contentInset;
            inSet.top += self.frame.size.height
            self.scrollView.contentInset = inSet
        }) 
        //动画
        let keyAnimation = CAKeyframeAnimation(keyPath: "path")
        keyAnimation.duration = 0.8
        keyAnimation.values = [UIBezierPath(ovalIn: CGRect(x: (self.frame.size.width/2) - 20 , y: self.frame.size.height/2 - 15 , width: 10 , height: 10 )).cgPath ,
            UIBezierPath(ovalIn: CGRect(x: (self.frame.size.width/2) - 8, y: self.frame.size.height/2 - 2 , width: 30 , height: 30 )).cgPath,
            UIBezierPath(ovalIn: CGRect(x: (self.frame.size.width/2) - 18 , y: self.frame.size.height/2 - 18 , width: 20 , height: 20 )).cgPath,
            UIBezierPath(ovalIn: CGRect(x: (self.frame.size.width/2) - 12 , y: self.frame.size.height/2 - 7 , width: 35 , height: 35 )).cgPath,
            UIBezierPath(ovalIn: CGRect(x: (self.frame.size.width/2) - 17 , y: self.frame.size.height/2 - 17 , width: 28 , height: 28 )).cgPath,
            UIBezierPath(ovalIn: CGRect(x: (self.frame.size.width/2) - 15 , y: self.frame.size.height/2 - 13 , width: 33 , height: 33 )).cgPath,
            UIBezierPath(ovalIn: CGRect(x: (self.frame.size.width/2) - 15 , y: self.frame.size.height/2 - 15 , width: 30 , height: 30 )).cgPath
        ]
       
        self.shapeLayer.add(keyAnimation, forKey: nil)
        
        self.shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: (self.frame.size.width/2) - 15 , y: self.frame.size.height/2 - 15 , width: 30 , height: 30 )).cgPath
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.lineDashPattern = [2]
        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.duration = 2
        baseAnimation.fromValue = 0
        baseAnimation.toValue = 1
        baseAnimation.repeatDuration = 5
        shapeLayer.add(baseAnimation, forKey: nil)
    }
    
    
    func endRefresh(){
        isRefreshing = false
        isAnimating = false
        UIView.animate(withDuration: 0.3, animations: {
            var inSet = self.scrollView.contentInset;
            inSet.top -= self.frame.size.height
            self.scrollView.contentInset = inSet
        }) 
    }
    
    //绘制
    func reDraw(_ offY:CGFloat){
        if !isAnimating {
        shapeLayer.lineWidth = 0
        shapeLayer.lineDashPattern = []
        shapeLayer.fillColor = UIColor.gray.cgColor
        let  y = frame.size.height - offY + 1
        let width = frame.size.width * progress * 0.8 > 15 ? 15:frame.size.width * progress * 0.8
        shapeLayer.path = UIBezierPath(ovalIn: CGRect(x: (frame.size.width/2) - 7.5 , y: y , width: width , height: frame.size.height * progress * 0.8)).cgPath
        
        }
    }
    
}
