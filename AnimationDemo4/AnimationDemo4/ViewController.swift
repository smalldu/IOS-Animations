//
//  ViewController.swift
//  AnimationDemo4
//
//  Created by duzhe on 15/9/26.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate , CAAnimationDelegate{
  
  
  @IBOutlet weak var titleLable:UILabel!
  @IBOutlet weak var userName:UITextField!
  @IBOutlet weak var password:UITextField!
  @IBOutlet weak var login:UIButton!
  
  let info = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    info.frame = CGRect(x: 0.0, y: login.center.y + 60.0,
                        width: view.frame.size.width, height: 30)
    info.backgroundColor = UIColor.clear
    info.font = UIFont(name: "HelveticaNeue", size: 12.0)
    info.textAlignment = .center
    info.textColor = UIColor.white
    info.text = "Tap on a field and enter username and password"
    view.insertSubview(info, belowSubview: login)
    
    userName.delegate = self
    password.delegate = self
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    // view.layer.speed = 2
    let basic = CABasicAnimation(keyPath: "position.x");
    basic.duration = 0.7
    basic.fromValue = -view.bounds.size.width/2
    basic.toValue = view.bounds.width/2
    basic.fillMode = kCAFillModeBoth
    basic.delegate = self
    //basic.removedOnCompletion = false  //停留在动画最后的位置 而不是其实放得位置
    
    basic.setValue(titleLable.layer, forKey: "layer")
    titleLable.layer.add(basic, forKey: nil)
    
    basic.beginTime = CACurrentMediaTime()+0.5
    basic.setValue(userName.layer, forKey: "layer")
    userName.layer.add(basic, forKey: nil)
    
    basic.beginTime = CACurrentMediaTime()+0.6
    basic.setValue(password.layer, forKey: "layer")
    password.layer.add(basic, forKey: nil)
    
    
    //添加说明字符的动画
    let flyLeft = CABasicAnimation(keyPath: "position.x")
    flyLeft.repeatCount = 2.5
    flyLeft.speed = 2
    flyLeft.autoreverses = true
    flyLeft.duration = 4
    flyLeft.fromValue = info.layer.position.x +
      view.frame.size.width
    flyLeft.toValue = info.layer.position.x
    info.layer.add(flyLeft, forKey: "infoAppear")
    
    let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
    fadeLabelIn.repeatCount = 2.5
    fadeLabelIn.autoreverses = true
    fadeLabelIn.speed = 2
    fadeLabelIn.fromValue = 0.2
    fadeLabelIn.toValue = 1.0
    fadeLabelIn.duration = 4
    info.layer.add(fadeLabelIn, forKey: "fadein")
    
    //处理登录按钮
    let groupAnimatiom = CAAnimationGroup()
    groupAnimatiom.beginTime = CACurrentMediaTime() + 0.5
    groupAnimatiom.duration = 0.5
    groupAnimatiom.fillMode = kCAFillModeForwards
    groupAnimatiom.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    
    let scaleDown = CABasicAnimation(keyPath:"transform.scale")
    scaleDown.fromValue = 3.5
    scaleDown.toValue = 1
    
    let rotate = CABasicAnimation(keyPath: "transform.rotation")
    rotate.fromValue = CGFloat(M_PI_4)
    rotate.toValue = 0
    
    let fade = CABasicAnimation(keyPath: "opacity")
    fade.fromValue = 0
    fade.toValue = 1
    
    groupAnimatiom.animations = [scaleDown,rotate,fade]
    login.layer.add(groupAnimatiom, forKey: nil)
    
  }
  
  @IBAction func login(_ sender:UIButton){
    view.endEditing(true)
    let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
    wobble.duration = 0.25
    wobble.repeatCount = 4
    wobble.values = [0.0, -M_PI_4/4, 0.0, M_PI_4/4, 0.0]
    wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
    titleLable.layer.add(wobble, forKey: nil)
    
    //添加一个气球
    let balloon = CALayer()
    balloon.contents = UIImage(named: "balloon")!.cgImage
    balloon.frame = CGRect(x: -50.0, y: 0.0,
                           width: 65.0, height: 70.0)
    view.layer.insertSublayer(balloon, below: userName.layer)
    
    //气球动画
    let flight = CAKeyframeAnimation(keyPath: "position")
    flight.duration = 3.5
    flight.values = [
      CGPoint(x: -50.0, y: 0.0),
      CGPoint(x: view.frame.width + 50.0, y: 160.0),
      CGPoint(x: -50.0, y: login.center.y)
      ].map{
        NSValue(cgPoint:$0)
    }
    flight.keyTimes = [0.0,0.5,1.0]
    balloon.add(flight, forKey: nil)
    balloon.position = CGPoint(x: -50.0, y: login.center.y)
  }

  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    let layer = anim.value(forKey: "layer")
    let puase = CABasicAnimation(keyPath: "transform.scale")
    puase.fromValue = 1.5
    puase.toValue = 1.0
    puase.duration = 0.25
    (layer as AnyObject).add(puase, forKey: nil)
  }
  
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    info.layer.removeAnimation(forKey: "infoAppear")
  }
}

