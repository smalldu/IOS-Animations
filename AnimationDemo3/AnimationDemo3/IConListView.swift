//
//  IConListView.swift
//  AnimationDemo3
//
//  Created by duzhe on 15/9/25.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class IConListView: UIScrollView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  var didSelectItem: ((_ index: Int)->())?
  
  let buttonWidth: CGFloat = 60.0
  let padding: CGFloat = 10.0
  
  var imgs = ["icon1","icon2","icon3","icon4","icon5","icon1","icon2"]
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(inView: UIView) {
    let rect = CGRect(x: inView.bounds.width, y: 120.0, width: inView.frame.width, height: 80.0)
    self.init(frame: rect)
    self.alpha = 0.0
    
    for i in 0 ..< imgs.count {
      let image = UIImage(named: imgs[i])
      let imageView  = UIImageView(image: image)
      imageView.center = CGPoint(x: CGFloat(i) * buttonWidth + buttonWidth/2, y: buttonWidth/2)
      imageView.tag = i
      imageView.isUserInteractionEnabled = true
      addSubview(imageView)
      
      let tap = UITapGestureRecognizer(target: self, action: #selector(IConListView.didTapImage(_:)))
      imageView.addGestureRecognizer(tap)
    }
    
    contentSize = CGSize(width: padding * buttonWidth, height:  buttonWidth + 2*padding)
    //backgroundColor = UIColor.redColor()
  }
  
  func  didTapImage(_ gesture:UITapGestureRecognizer){
    didSelectItem?(gesture.view!.tag)
  }
  
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    UIView.animate(withDuration: 1.0, delay: 0.01, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
      self.alpha = 1.0
      self.center.x -= self.frame.size.width
    }, completion: nil)
  }
  
}
