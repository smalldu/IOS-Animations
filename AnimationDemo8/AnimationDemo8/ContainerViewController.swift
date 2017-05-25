//
//  ContainerViewController.swift
//  AnimationDemo8
//
//  Created by duzhe on 15/10/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit


class ContainerViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var menuContainerView:UIView!
    
    var progress:CGFloat?
    var isFirst = true
    var isScroll = true
    
    fileprivate var menuViewController:MenuTableViewController?
    fileprivate var detailViewController:DetailViewController?
    var menuItem:MenuItem?{
        didSet{
            if let detail = detailViewController{
                hideShowMenu(false, animate: !isFirst)
                detail.menuItem = menuItem
            }
        }
    }
    
    
    func hideShowMenu(_ show:Bool,animate:Bool){
        let menuOff = menuContainerView.bounds.width
        scrollView.setContentOffset(show ? CGPoint.zero:CGPoint(x: menuOff, y: 0), animated: animate)
    }
    func toggleMenu(){
       
        let menuOff = menuContainerView.bounds.width
        scrollView.setContentOffset(scrollView.contentOffset.x != 0 ? CGPoint.zero:CGPoint(x: menuOff, y: 0), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        //消除锯齿
//        menuViewController?.tableView.layer.shouldRasterize = false
//        menuViewController?.tableView.layer.rasterizationScale =
//            UIScreen.mainScreen().scale
//         menuContainerView.layer.position.x = -1*menuContainerView.bounds.size.width
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue"{
            let navigation = segue.destination as! UINavigationController
            detailViewController = navigation.topViewController as? DetailViewController
        }else if segue.identifier == "MenuViewController"{
            let navigation = segue.destination as! UINavigationController
            menuViewController = navigation.topViewController as? MenuTableViewController
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let multipier = 1/menuContainerView.bounds.width
        progress = 1-((scrollView.contentOffset.x) * multipier)
        if isScroll{
            if let detail = detailViewController{
                let menuView = detail.menuView
                menuView.rotate(progress!)
            }
        }
        menuContainerView.layer.transform = menuTransformForPercent(progress!)
        menuContainerView.alpha = progress!
        scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.width)
        isFirst = false
    }
    
    
    func menuTransformForPercent(_ percent: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000   //1 / [camera distance]
        let remainingPercent = 1.0 - percent
        let angle = remainingPercent * CGFloat(-M_PI_2)
        let rotationTransform = CATransform3DRotate(identity, angle,
            0.0, 1.0, 0.0)
        let translationTransform =
        CATransform3DMakeTranslation(menuContainerView.bounds.width/2 , 0, 0)
        
        return CATransform3DConcat(rotationTransform,
            translationTransform)
        
    }
    

    
}
