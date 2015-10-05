//
//  DetailViewController.swift
//  AnimationDemo11
//
//  Created by duzhe on 15/10/5.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var titleView: UILabel!
    @IBOutlet var descriptionView: UITextView!
    var he:Hero!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgImage.image = UIImage(named: he.image)
        titleView.text = he.name
        descriptionView.text = he.description
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("actionClose:")))
    }
    
    
    func actionClose(tap: UITapGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
//        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
