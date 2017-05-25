//
//  DetailViewController.swift
//  AnimationDemo8
//
//  Created by duzhe on 15/10/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var symbol:UILabel!
    let menuView:MenuButton = MenuButton()
    
    var menuItem:MenuItem?{
        didSet{
            view.backgroundColor = menuItem?.color
            symbol.text = menuItem?.symbol
            UIView.animate(withDuration: 0.4, animations: {
                self.menuView.transform = CGAffineTransform.identity
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.tapHandler = {
        let containerVc = self.navigationController?.parent as! ContainerViewController
            containerVc.isScroll = false
            if containerVc.scrollView.contentOffset.x == 0 {
                UIView.animate(withDuration: 0.5, animations: {
                    self.menuView.transform = CGAffineTransform.identity
                    }, completion: { _ in
                        containerVc.isScroll=true
                })
            }else{
                UIView.animate(withDuration: 0.5, animations: {
                    self.menuView.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
                    }, completion: {_ in
                
                        containerVc.isScroll=true
                })
            }
            
            containerVc.toggleMenu()
           
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuView)
        
    }

    
}
