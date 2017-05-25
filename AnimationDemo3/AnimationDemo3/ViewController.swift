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
  
  var tb = ["icon1","icon2","icon3","icon5"]
  var wz = ["图标一","图标二","图标三","图标四"]
  var imgs = ["icon1","icon2","icon3","icon4","icon5","icon6","icon7"]
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = wz[indexPath.row]
    cell.imageView?.image = UIImage(named: tb[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return wz.count;
  }
  
  @IBAction func toggleMenu(_ sender: UIButton){
    isMenuOpen = !isMenuOpen
    for constraint in titleLabel.superview!.constraints{
      if constraint.secondItem as? NSObject == titleLabel &&
        constraint.secondAttribute == .centerX {
        constraint.constant = isMenuOpen ? 100.0 : 0.0
        continue
      }
      
      if constraint.firstItem as? NSObject == titleLabel &&
        constraint.firstAttribute == .centerY {
        titleLabel.superview!.removeConstraint(constraint)
        //添加新的约束
        let newConstraint = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: titleLabel.superview!, attribute: .centerY, multiplier: isMenuOpen ? 0.6:1, constant: 5)
        newConstraint.isActive = true
        continue
      }
      if constraint.firstItem as? NSObject == btnMenu &&
        constraint.firstAttribute == .centerY {
        
        btnMenu.superview!.removeConstraint(constraint)
        //添加新的约束
        let newConstraint = NSLayoutConstraint(item: btnMenu, attribute: .centerY, relatedBy: .equal, toItem: btnMenu.superview!, attribute: .centerY, multiplier: isMenuOpen ? 0.6:1, constant: 5)
        newConstraint.isActive = true
        continue
      }
    }
    
    menuHeightConstraint.constant = isMenuOpen ? 200.0 : 60
    titleLabel.text = isMenuOpen ? "选择元素" : "测试列表"
    let angel = isMenuOpen ? CGFloat(M_PI_4) : 0.0
    
    self.btnMenu.transform = CGAffineTransform(rotationAngle: angel)
    
    //在这种情况下，你已经更新了限制值，但iOS的一直没有一个机会真正更新的布局呢。调用layoutIfNeeded()方法 让这个view参与到布局
    UIView.animate(withDuration: 1, delay:0, usingSpringWithDamping: 0.4, initialSpringVelocity: 8.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
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
  
  func showItem(_ index:Int){
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
    imageView1.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action:#selector(ViewController.viewTap(_:)))
    imageView1.addGestureRecognizer(tap)
    
    //创建约束
    let conX = NSLayoutConstraint(item: imageView1, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
    conX.isActive = true
    
    let conY = NSLayoutConstraint(item: imageView1, attribute: .bottom,
                                  relatedBy: .equal, toItem: view, attribute: .bottom,multiplier: 1.0,
                                  constant: imageView1.frame.size.height)
    conY.isActive = true
    
    let conWidth = NSLayoutConstraint(item: imageView1, attribute: .width,
                                      relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.33,
                                      constant: -50.0)
    conWidth.isActive = true
    
    let conHeight = NSLayoutConstraint(item: imageView1, attribute: .height,
                                       relatedBy: .equal, toItem: imageView1, attribute: .width, multiplier:
      1.0, constant: 0.0)
    conHeight.isActive = true
    
    //让约束起作用 上面的约束不要出动画
    self.view.layoutIfNeeded()
    
    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
      conY.constant = -self.imageView1.frame.size.height/2
      conWidth.constant = 0
      self.view.layoutIfNeeded()
    }, completion: nil)
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    showItem(indexPath.row)
  }
  
  func viewTap(_ ges:UITapGestureRecognizer){
    
    print("----------")
    
    UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
      self.imageView1.center.y += self.imageView1.frame.size.height+30
      self.imageView1.alpha = 0
    }, completion: { _ in
      self.imageView1.removeFromSuperview()
    })
  }
  
}

