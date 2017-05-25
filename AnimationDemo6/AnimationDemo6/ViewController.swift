//
//  ViewController.swift
//  AnimationDemo6
//
//  Created by duzhe on 15/9/26.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slideView:AnimatedLabel!
    @IBOutlet weak var timeLabel:UILabel!
    
    @IBOutlet weak var constraintA:NSLayoutConstraint!
    @IBOutlet weak var constraintB:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.didSlide(_:)))
        swip.direction = .right
        slideView.addGestureRecognizer(swip)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func cgColorForRed(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> AnyObject {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor as AnyObject
    }
    
    
    func didSlide(_ gesture:UISwipeGestureRecognizer){
        let image = UIImageView(image: UIImage(named: "meme"))
        image.center = view.center
        image.center.x += view.bounds.size.width
        view.addSubview(image)

//        UIView.animateWithDuration(0.33, delay: 0.0, options: nil, animations: {
//            //self.time.center.y -= 200.0
//            self.slideView.center.y += 200.0
//            image.center.x -= self.view.bounds.size.width
//            }, completion: nil)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                self.timeLabel.center.y -= 200
                self.slideView.center.y += 200.0
                image.center.x -= self.view.bounds.size.width
            }){ _ in
                UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                    self.timeLabel.center.y += 200
                    self.slideView.center.y -= 200.0
                    image.center.x += self.view.bounds.size.width
                    }){ _ in
                        image.removeFromSuperview()
                }

        
            }
        
        
          }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

