//
//  ViewController.swift
//  AnimationDemo11
//
//  Created by duzhe on 15/10/5.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let he = Hero.all()
    @IBOutlet weak var listView:UIScrollView!
    @IBOutlet weak var bgImage:UIImageView!
    var selectedImage: UIImageView?
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if listView.subviews.count < he.count {
            setupList()
        }
    }
    
    func setupList() {
        for var i=0; i < he.count; i++ {
            
            //create image view
            let imageView  = UIImageView(image: UIImage(named: he[i].image))
            imageView.tag = i+1
            imageView.contentMode = .ScaleAspectFill
            imageView.userInteractionEnabled = true
            imageView.layer.cornerRadius = 20.0
            imageView.layer.masksToBounds = true
            listView.addSubview(imageView)
            
            //attach tap detector
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapImageView:")))
        }
        
        listView.backgroundColor = UIColor.clearColor()
        positionListItems()
    }

    func positionListItems() {
        
        let itemHeight: CGFloat = listView.frame.height * 1.33
        let aspectRatio = UIScreen.mainScreen().bounds.height / UIScreen.mainScreen().bounds.width
        let itemWidth: CGFloat = itemHeight / aspectRatio
        
        let horizontalPadding: CGFloat = 10.0
        
        for var i=1; i <= he.count; i++ {
            let imageView = listView.viewWithTag(i) as! UIImageView
            imageView.layer.borderWidth  = 1 
            imageView.frame = CGRect(
                x: CGFloat(i-1) * itemWidth + CGFloat(i) * horizontalPadding, y: 0.0,
                width: itemWidth, height: itemHeight)
        }
        
        listView.contentSize = CGSize(
            width: CGFloat(he.count) * (itemWidth + horizontalPadding) + horizontalPadding,
            height:  0)
    }
    
    
    func didTapImageView(tap: UITapGestureRecognizer) {
        selectedImage = tap.view as? UIImageView
        
        let index = tap.view!.tag
        let selectedHerb = he[index-1]
        //present details view controller
        let details = storyboard?.instantiateViewControllerWithIdentifier("detailViewController") as! DetailViewController
//        let de  = UIStoryboard(name: "Main", bundle:NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("detailViewController") as! DetailViewController
        print(details)
        details.he = selectedHerb
        details.transitioningDelegate = self //设置过渡代理
        presentViewController(details, animated: true, completion: nil)
    }
    
    override func viewWillTransitionToSize(size: CGSize,
        withTransitionCoordinator coordinator:
        UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size,
        withTransitionCoordinator: coordinator)
        
        
        coordinator.animateAlongsideTransition({context in
            self.bgImage.alpha = (size.width>size.height) ? 0.25 : 0.55
            }, completion: nil)
    }
    
}


extension ViewController:UIViewControllerTransitioningDelegate{
    
    
    //Present的时候 使用自定义的动画
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       
        transition.originFrame =
            selectedImage!.superview!.convertRect(selectedImage!.frame,
            toView: nil)
        transition.presenting = true
        selectedImage!.hidden = true
        
        return transition
    }
    
    //使用默认的动画
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        selectedImage!.hidden = false
        transition.presenting = false
        return transition
    }
    
}


