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
        frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        imageView = UIImageView(image: UIImage(named: "menu"))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MenuButton.didTap)))
        addSubview(imageView)
    }
    
    func didTap(){
        tapHandler?()
    }
 
    
    func rotate(_ fraction:CGFloat){
        imageView?.transform = CGAffineTransform(rotationAngle: fraction*CGFloat(M_PI_2))
    }
}
