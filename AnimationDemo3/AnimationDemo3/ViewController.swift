//
//  ViewController.swift
//  AnimationDemo3
//
//  Created by duzhe on 15/9/24.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var btnMenu:UIButton!
    
    //定义一些约束
    @IBOutlet var menuHeightConstraint:NSLayoutConstraint!
    
    var isMenuOpen = false
    var iconList:IConListView!
    var imageView1:UIImageView!
    
    var tb = ["ic_beenhere_48pt","ic_directions_48pt","ic_directions_bike_48pt","ic_directions_boat_48pt"]
    var wz = ["图标一","图标二","图标三","图标四"]
    var imgs = ["ic_directions_bus_48pt","ic_directions_run_48pt","ic_directions_subway_48pt","ic_flight_48pt","ic_hotel_48pt","ic_layers_48pt","ic_layers_clear_48pt"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = wz[indexPath.row]
        cell.imageView?.image = UIImage(named: tb[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wz.count;
    }
    
    @IBAction func toggleMenu(sender: UIButton){
     
       
        isMenuOpen = !isMenuOpen
        for constraint in titleLabel.superview!.constraints{
            if constraint.secondItem as? NSObject == titleLabel &&
            constraint.secondAttribute == .CenterX {
                constraint.constant = isMenuOpen ? 100.0 : 0.0
                continue
            }
            
            if constraint.firstItem as? NSObject == titleLabel &&
                constraint.firstAttribute == .CenterY {
                titleLabel.superview!.removeConstraint(constraint)
                //添加新的约束
                let newConstraint = NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: titleLabel.superview!, attribute: .CenterY, multiplier: isMenuOpen ? 0.6:1, constant: 5)
                newConstraint.active = true
                continue
            }
            if constraint.firstItem as? NSObject == btnMenu &&
                constraint.firstAttribute == .CenterY {
                
                btnMenu.superview!.removeConstraint(constraint)
                //添加新的约束
                let newConstraint = NSLayoutConstraint(item: btnMenu, attribute: .CenterY, relatedBy: .Equal, toItem: btnMenu.superview!, attribute: .CenterY, multiplier: isMenuOpen ? 0.6:1, constant: 5)
                newConstraint.active = true
                continue
            }
        }
        
        menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60
        titleLabel.text = isMenuOpen ? "选择元素" : "测试列表"
        let angel = isMenuOpen ? CGFloat(M_PI_4) : 0.0
        
        self.btnMenu.transform = CGAffineTransformMakeRotation(angel)
        
        //在这种情况下，你已经更新了限制值，但iOS的一直没有一个机会真正更新的布局呢。调用layoutIfNeeded()方法 让这个view参与到布局
        UIView.animateWithDuration(1, delay:0, usingSpringWithDamping: 0.4, initialSpringVelocity: 8.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.view.layoutIfNeeded()  //强制布局的更新 , 很炫
            }, completion: nil)
        
        if isMenuOpen {
            iconList = IConListView(inView: view)
            iconList.didSelectItem = {index in
                print("add \(index)")
                self.wz.append("图标\(4+index)")
                self.tb.append(self.imgs[index])
                self.tableView.reloadData()
            }
            print(iconList)
            self.titleLabel.superview!.addSubview(iconList)
        } else {
            iconList.removeFromSuperview()
        }
    }
    
    func showItem(index:Int){
        if imageView1 != nil{
            imageView1.removeFromSuperview()
            imageView1 = nil
        }
        imageView1 = UIImageView(image:
        UIImage(named:self.tb[index]))
        imageView1.backgroundColor = UIColor(red: 0.0, green: 0.0,
        blue: 0.0, alpha: 0.5)
        imageView1.layer.cornerRadius = 5.0
        imageView1.layer.masksToBounds = true
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView1)
        imageView1.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:"viewTap:")
        imageView1.addGestureRecognizer(tap)
        
        //创建约束
        let conX = NSLayoutConstraint(item: imageView1, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        conX.active = true
    
        let conY = NSLayoutConstraint(item: imageView1, attribute: .Bottom,
        relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0,
        constant: imageView1.frame.size.height)
        conY.active = true
            
        let conWidth = NSLayoutConstraint(item: imageView1, attribute: .Width,
        relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 0.33,
        constant: -50.0)
        conWidth.active = true
                    
        let conHeight = NSLayoutConstraint(item: imageView1, attribute: .Height,
        relatedBy: .Equal, toItem: imageView1, attribute: .Width, multiplier:
        1.0, constant: 0.0)
        conHeight.active = true
        
        //让约束起作用 上面的约束不要出动画
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
                conY.constant = -self.imageView1.frame.size.height/2
                conWidth.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                showItem(indexPath.row)
    }
    
    func viewTap(ges:UITapGestureRecognizer){
        
        print("----------")
       
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: {
                self.imageView1.center.y += self.imageView1.frame.size.height+30
                self.imageView1.alpha = 0
            }, completion: { _ in
                 self.imageView1.removeFromSuperview()
        })
    }
    
}

