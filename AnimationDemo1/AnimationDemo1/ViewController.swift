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

    override func viewWillAppear(animated: Bool) {
       v2.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
       
        //普通动画
        UIView.animateWithDuration(1, delay: 0.2, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.Repeat.rawValue | UIViewAnimationOptions.Autoreverse.rawValue | UIViewAnimationOptions.CurveEaseIn.rawValue) , animations: {
            
            self.v1.center.x += self.view.bounds.width
            
        }, completion: nil)
        
        UIView.animateWithDuration(1.2, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.Repeat.rawValue | UIViewAnimationOptions.Autoreverse.rawValue), animations: { () -> Void in
                self.v2.center.x -= 100
                self.v2.alpha = 1
            
            }, completion: nil)
        
        UIView.animateWithDuration(1.3, delay: 8, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.AllowAnimatedContent.rawValue ), animations: { () -> Void in
            
                 self.v3.transform = CGAffineTransformMakeTranslation(0, 100)
            
                 self.v3.transform = CGAffineTransformMakeScale(1.5, 1.5)
                self.v3.backgroundColor = UIColor.yellowColor()
            }) { _  in
                
              UIView.animateWithDuration(0.8, animations: {
                 self.v3.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                
              })
        }
        
        let newView = UIView(frame: v4.bounds)
        newView.backgroundColor = UIColor.redColor()
        //过渡
        UIView.transitionWithView(self.v4, duration: 2, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.Repeat.rawValue | UIViewAnimationOptions.TransitionFlipFromBottom.rawValue | UIViewAnimationOptions.CurveEaseIn.rawValue ), animations: { () -> Void in
            self.v4.addSubview(newView);
            }, completion: nil)
        
        
        let newView1 = UIView(frame: v5.bounds)
        newView1.backgroundColor = UIColor.redColor()
        UIView.transitionWithView(self.v5, duration: 2, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.Repeat.rawValue | UIViewAnimationOptions.TransitionCurlDown.rawValue | UIViewAnimationOptions.CurveEaseIn.rawValue ), animations: { () -> Void in
            self.v5.addSubview(newView1);
            }, completion: nil)
        
        let newView2 = UIView(frame: v6.bounds)
        newView2.backgroundColor = UIColor.redColor()
        newView2.center = self.v6.center
        
        //这个感觉没啥效果呀。。
//        UIView.transitionWithView(v6, duration: 2, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.Repeat.rawValue | UIViewAnimationOptions.TransitionFlipFromBottom.rawValue | UIViewAnimationOptions.CurveEaseOut.rawValue ), animations: { () -> Void in
//                newView2.removeFromSuperview()
//            }, completion: nil)
      
//        UIView.transitionFromView(self.v6, toView: newView2, duration:2, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.Repeat.rawValue | UIViewAnimationOptions.TransitionFlipFromTop.rawValue  ), completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
