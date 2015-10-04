//
//  ViewController.swift
//  3DTransformDemo
//
//  Created by duzhe on 15/10/4.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerV:UIView!
    @IBOutlet weak var v1:UIView!
    @IBOutlet weak var v2:UIView!
    @IBOutlet weak var v3:UIView!
    @IBOutlet weak var v4:UIView!
    @IBOutlet weak var v5:UIView!
    @IBOutlet weak var v6:UIView!
    
    var angel = CGFloat(-M_PI/4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var trans = CATransform3DIdentity
        trans.m34 = -1 / 1000
   
        
        var trans2 = CATransform3DTranslate(trans, 0, 0, 50)
        v1.layer.transform = trans2
        
        trans2 = CATransform3DTranslate(trans, 50, 0, 0)
        trans2 = CATransform3DRotate(trans2, CGFloat(M_PI_2) , 0 , 1 , 0);
        v2.layer.transform = trans2
        
        trans2 = CATransform3DTranslate(trans, 0, -50, 0)
        trans2 = CATransform3DRotate(trans2, CGFloat(M_PI_2) , 1 , 0 , 0);
        v3.layer.transform = trans2
        
        trans2 = CATransform3DTranslate(trans, 0, 50, 0)
        trans2 = CATransform3DRotate(trans2, CGFloat(-M_PI_2) , -1 , 0 , 0);
        v4.layer.transform = trans2
        
        trans2 = CATransform3DTranslate(trans, -50, 0, 0)
        trans2 = CATransform3DRotate(trans2, CGFloat(-M_PI_2) , 0 , 1 , 0);
        v5.layer.transform = trans2
        
        trans2 = CATransform3DTranslate(trans, 0, 0, -50)
        trans2 = CATransform3DRotate(trans2, CGFloat(M_PI) , 0 , 1 , 0);
        v6.layer.transform = trans2
        
        
        trans = CATransform3DRotate(trans, angel , 0, 1 , 0);
        trans = CATransform3DRotate(trans, angel , 1, 0 , 0);
        containerV.layer.sublayerTransform = trans
        
        let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
        containerV.addGestureRecognizer(pan)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func handlePan(sender:UIPanGestureRecognizer){
        let p = sender.translationInView(containerV)
        let angel1 = angel+(p.x/30)
        let angel2 = angel-(p.y/30)
        
        var trans = CATransform3DIdentity
        trans.m34 = -1 / 500
        trans = CATransform3DRotate(trans, angel1 , 0, 1 , 0);
        trans = CATransform3DRotate(trans, angel2 , 1, 0 , 0);
        containerV.layer.sublayerTransform = trans
        
        print("拖动\(p)")
    }

}

