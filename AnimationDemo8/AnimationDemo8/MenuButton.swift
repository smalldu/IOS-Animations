//
//  MenuButton.swift
//  AnimationDemo8
//
//  Created by duzhe on 15/10/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class MenuButton: UIView {

    var imageView: UIImageView!
    var tapHandler:(()->())?

    override func didMoveToSuperview() {
        frame = CGRectMake(0, 0, 20, 20)
        
        imageView = UIImageView(image: UIImage(named: "menu"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didTap"))
        addSubview(imageView)
    }
    
    func didTap(){
        tapHandler?()
    }
 
    
    func rotate(fraction:CGFloat){
        imageView?.transform = CGAffineTransformMakeRotation(fraction*CGFloat(M_PI_2))
    }
}
