//
//  SecondViewController.swift
//  AnimationDemo7
//
//  Created by duzhe on 15/10/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource,UITableViewDelegate , RefreshDelegate{

    @IBOutlet weak var tableView:UITableView!
    
    var datas = ["第一行","第二行","第三行","第四行","第五行"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshView = DZRefreshViewTwo(scrollView: tableView)
        refreshView.delegate = self
        self.tableView.addSubview(refreshView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath);
        cell.textLabel?.text = datas[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count;
    }


    func doRefresh(_ refreshView: DZRefreshViewTwo) {
        delay(4) {
            refreshView.endRefresh()
        }
    }
    
    func delay(_ seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
