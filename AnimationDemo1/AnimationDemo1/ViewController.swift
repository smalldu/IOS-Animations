//
//  ViewController.swift
//  AnimationDemo1
//
//  Created by duzhe on 15/9/23.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var v1:UIView!
  @IBOutlet weak var v2:UIView!
  @IBOutlet weak var v3:UIView!
  @IBOutlet weak var v4:UIView!
  @IBOutlet weak var v5:UIView!
  @IBOutlet weak var v6:UIView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    v2.alpha = 0
  }
  override func viewDidAppear(_ animated: Bool) {
 
    // 普通的动画 v1
    UIView.animate(withDuration: 1, delay: 0.2, options: [.repeat,.autoreverse,.curveEaseIn] , animations: {
      self.v1.center.x += self.view.bounds.width
    }, completion: nil)
    
    // 弹簧动画
    UIView.animate(withDuration: 1.2, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.repeat,.autoreverse,.curveEaseIn] , animations: { () -> Void in
      self.v2.center.x -= 100
      self.v2.alpha = 1
    }, completion: nil)
    
    // transform
    UIView.animate(withDuration: 1.3, delay: 0.1 , usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.repeat,.autoreverse] , animations: { () -> Void in
      self.v3.transform = CGAffineTransform
        .identity
        .translatedBy(x: 0, y: 5)
        .scaledBy(x: 1.5, y: 1.5)
      self.v3.backgroundColor = UIColor.yellow
    }) { _  in
      UIView.animate(withDuration: 0.8, animations: {
        self.v3.transform = CGAffineTransform
          .identity
          .rotated(by: CGFloat(Double.pi))
      })
    }
    
    let newView = UIView(frame: v4.bounds)
    newView.backgroundColor = UIColor.red
    // 过渡 transition 动画 可以修改属性 看看不同效果
    UIView.transition(with: self.v4, duration: 2 , options: [.repeat,.transitionFlipFromBottom,.curveEaseIn] , animations: { () -> Void in
      self.v4.addSubview(newView)  // 新增view会有过渡效果
    }, completion: nil)
    
    
    let newView1 = UIView(frame: v5.bounds)
    newView1.backgroundColor = UIColor.red
    // 另一个过渡动画
    UIView.transition(with: self.v5, duration: 2, options: [.repeat,.transitionCurlDown ,.curveEaseIn] , animations: { () -> Void in
      self.v5.addSubview(newView1)
    }, completion: nil)
    
    let newView2 = UIView(frame: v6.bounds)
    newView2.backgroundColor = UIColor.red
    newView2.center = self.v6.center
    // 过渡动画
    UIView.transition(with: self.v6 , duration: 2, options: [.repeat,.transitionFlipFromTop ,.curveEaseIn] , animations: { () -> Void in
      self.v6.addSubview(newView2)
    }, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
