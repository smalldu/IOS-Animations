//
//  ViewController.swift
//  AnimationDemo10
//
//  Created by duzhe on 15/10/5.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = CGRect(x: 0.0, y: -70.0, width: view.bounds.width,
            height: 50.0)
        let emitter = CAEmitterLayer()
        emitter.frame = rect
        view.layer.addSublayer(emitter)
        emitter.emitterShape = kCAEmitterLayerRectangle
        
        //kCAEmitterLayerPoint
        //kCAEmitterLayerLine
        //kCAEmitterLayerRectangle
        
        emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
        emitter.emitterSize = rect.size
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "xh")!.scaleImageToWidth(30).cgImage
        emitterCell.birthRate = 120  //每秒产生120个粒子
        emitterCell.lifetime = 3    //存活1秒
        emitterCell.lifetimeRange = 3.0
        
        emitter.emitterCells = [emitterCell]  //这里可以设置多种粒子 我们以一种为粒子
        emitterCell.yAcceleration = 70.0  //给Y方向一个加速度
        emitterCell.xAcceleration = 20.0 //x方向一个加速度
        emitterCell.velocity = 20.0 //初始速度
        emitterCell.emissionLongitude = CGFloat(-M_PI) //向左
        emitterCell.velocityRange = 200.0   //随机速度 -200+20 --- 200+20
        emitterCell.emissionRange = CGFloat(M_PI_2) //随机方向 -pi/2 --- pi/2
       //emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0,
         //   alpha: 1.0).CGColor //指定颜色
        emitterCell.redRange = 0.3
        emitterCell.greenRange = 0.3
        emitterCell.blueRange = 0.3  //三个随机颜色
        
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8  //0 - 1.6 
        emitterCell.scaleSpeed = -0.15  //逐渐变小
        
        emitterCell.alphaRange = 0.75   //随机透明度
        emitterCell.alphaSpeed = -0.15  //逐渐消失
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

