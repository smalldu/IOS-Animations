//
//  ViewController.swift
//  AnimationDemo2
//
//  Created by duzhe on 15/9/24.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  @IBOutlet weak var fj:UIImageView!
  @IBOutlet weak var yd1:UIImageView!
  @IBOutlet weak var yd2:UIImageView!
  @IBOutlet weak var yd3:UIImageView!
  @IBOutlet weak var yd4:UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    // yd1.alpha = 0
    yd1.center.x -= 100
    yd2.center.x += 100
    
    yd3.center.x -= 100
    yd4.center.x += 100
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    let oriCenter = fj.center
    
    UIView.animate(withDuration: 2, delay: 0.2, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.repeat.rawValue | UIViewAnimationOptions.autoreverse.rawValue), animations: {
      // self.yd1.alpha = 1
      self.yd1.center.x += 100
      self.yd2.center.x -= 100
      self.yd3.center.x += 100
      self.yd4.center.x -= 100
    }, completion: nil)
    
    // 关键帧动画
    UIView.animateKeyframes(withDuration: 3, delay: 0.1, options: UIViewKeyframeAnimationOptions.repeat, animations: { () -> Void in
      //第一段
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25, animations: {
        self.fj.center.x += 60.0
        self.fj.center.y -= 10.0
      })
      
      // 旋转
      UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.4, animations: {
        self.fj.transform = CGAffineTransform
          .identity
          .rotated(by: CGFloat(-Double.pi/4/2))
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
        self.fj.center.x += 100.0
        self.fj.center.y -= 50.0
        self.fj.alpha = 0
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.01, animations: {
        self.fj.transform = CGAffineTransform.identity
        self.fj.center = CGPoint(x: 0, y: oriCenter.y);
      })
      
      UIView.addKeyframe(withRelativeStartTime: 0.55, relativeDuration: 0.45, animations: {
        self.fj.alpha = 1.0
        self.fj.center = oriCenter
      })
      
    }) { _ in
      
    }
    
  }
  
}

