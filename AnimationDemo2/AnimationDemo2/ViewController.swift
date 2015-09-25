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
        fj.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        
       // yd1.alpha = 0
        yd1.center.x -= 100
        yd2.center.x += 100
        
        yd3.center.x -= 100
        yd4.center.x += 100
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let oriCenter = fj.center
        
        UIView.animateWithDuration(2, delay: 0.2, options: UIViewAnimationOptions(rawValue: UIViewAnimationOptions.Repeat.rawValue | UIViewAnimationOptions.Autoreverse.rawValue), animations: {
               // self.yd1.alpha = 1
                self.yd1.center.x += 100
                self.yd2.center.x -= 100
            
                self.yd3.center.x += 100
                self.yd4.center.x -= 100
            }, completion: nil)
        
        
        UIView.animateKeyframesWithDuration(3, delay: 0.1, options: UIViewKeyframeAnimationOptions.Repeat, animations: { () -> Void in
                //第一段
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.25, animations: {
                    self.fj.center.x += 60.0
                    self.fj.center.y -= 10.0
                })
            
                UIView.addKeyframeWithRelativeStartTime(0.1, relativeDuration: 0.4, animations: {
                    self.fj.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2 - M_PI_4*1/2 ))
                })
            
            UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.25, animations: {
                self.fj.center.x += 100.0
                self.fj.center.y -= 50.0
                self.fj.alpha = 0
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.01, animations: {
                self.fj.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                self.fj.center = CGPointMake(0, oriCenter.y);
            })
            UIView.addKeyframeWithRelativeStartTime(0.55, relativeDuration: 0.45, animations: {
                self.fj.alpha = 1.0
                self.fj.center = oriCenter
            })

            }) { _ in
            
        }
        
    }

}

