//
//  ViewController.swift
//  AnimationDemo7
//
//  Created by duzhe on 15/9/27.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource , RefreshViewDelegate {

    let kRefreshViewHeight: CGFloat = 110.0
    @IBOutlet weak var tbView:UITableView!
    
    var refreshView: DZRefreshView!
    var datas = ["第一行","第二行","第三行","第四行","第五行"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tbView.backgroundColor = UIColor.clearColor()
        tbView.tableFooterView = UIView(frame: CGRect.zero)
        self.tbView.backgroundColor = UIColor(red: 0.0, green: 154.0/255.0, blue: 222.0/255.0, alpha: 1.0)
        //self.tbView.rowHeight = 64.0
        let refreshRect = CGRect(x: 0.0, y: -kRefreshViewHeight, width: view.frame.size.width, height: kRefreshViewHeight)
        refreshView = DZRefreshView(frame: refreshRect, inScrollView: tbView)
        refreshView.delegate = self
        tbView.addSubview(refreshView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func refreshViewDidRefresh(_ refreshView: DZRefreshView) {
        delay(4) {
            refreshView.endRefreshing()
        }
    }
    
    func delay(_ seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
}

