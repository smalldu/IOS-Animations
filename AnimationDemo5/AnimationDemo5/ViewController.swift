//
//  ViewController.swift
//  AnimationDemo5
//
//  Created by duzhe on 15/9/26.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myAvatar: AvatarView!
    @IBOutlet var opponentAvatar: AvatarView!
    
    @IBOutlet var status: UILabel!
    @IBOutlet var vs: UILabel!
    @IBOutlet var searchAgain: UIButton!
    
    var opponents = ["tx1","tx2","tx3","tx1","tx2"]
    var names = ["小明","大狗","小王","八神","李四"]
    
    var original1:CGPoint!
    var original2:CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchAgain.alpha = 0.0
        original1 = myAvatar.center
        original2 = opponentAvatar.center
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        searchOpponent()
        
    }
    
    func searchOpponent(){
     
        let avatarSize = myAvatar.bounds.size
        
        let bounXOffSet:CGFloat = avatarSize.width/2
        let morphSize = CGSize(width: avatarSize.width*0.85, height: avatarSize.height*1.1)
        print(bounXOffSet)
        
        let rightBouncePoint = CGPoint(x: view.frame.size.width/2 + bounXOffSet, y: myAvatar.center.y)
        let leftBouncePoint = CGPoint(x: view.frame.size.width/2 - bounXOffSet, y: myAvatar.center.y)
        print(rightBouncePoint)
        
        myAvatar.bounceOffPoint(rightBouncePoint, morphSize: morphSize)
        opponentAvatar.bounceOffPoint(leftBouncePoint, morphSize: morphSize)
        delay(4, complete: foundOpponent);
    }
    
    //找到对手了
    func foundOpponent(){
        status.text = "找到了。。。"
        let a = arc4random_uniform(5)
        print(a)
        opponentAvatar.image = UIImage(named: opponents[Int(a)])
        opponentAvatar.name = names[Int(a)]
        //searchOpponent()
        
        delay(2, complete: connectedToOpponent)
    }
    
    func connectedToOpponent(){
        myAvatar.shouldTransitionToFinishedState = true
        opponentAvatar.shouldTransitionToFinishedState = true
        
        delay(1, complete: completed)
    }
    
    func completed(){
        status.text = "准备战斗吧"
        UIView.animate(withDuration: 0.2, animations: {
            self.vs.alpha = 0.0
            self.searchAgain.alpha = 1.0
        }) 
    }
    
    @IBAction func reFind(_ sender:UIButton){
        myAvatar.reInit()
        opponentAvatar.reInit()
        opponentAvatar.image = UIImage(named: "empty")
        opponentAvatar.name = "对手"
                
        print(original1)
        print(original2)
         
//        self.myAvatar.center = original1;//CGPoint(x: 228.0, y: 125.5)
//        self.opponentAvatar.center = CGPoint(x: 228.0, y: 125.5)
        UIView.animate(withDuration: 0.2, animations: {
            self.vs.alpha = 1.0
            self.searchAgain.alpha = 0.0
        
        }) 
        status.text = "正在寻找对手。。。"
        delay(1, complete: searchOpponent)
       // searchOpponent()
    }
    
    func delay(_ seconds:Double,complete:@escaping ()->()){
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) { () -> Void in
            complete()
        }
    }
    
    
}

