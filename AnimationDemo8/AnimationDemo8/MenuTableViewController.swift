//
//  MenuTableViewController.swift
//  AnimationDemo8
//
//  Created by duzhe on 15/10/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var detailView:DetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = (tableView.bounds.size.height - 44 - 20) / 7
        navigationController?.navigationBar.clipsToBounds = true //不显示导航栏下面的小阴影
        (navigationController?.parent as! ContainerViewController).menuItem = MenuItem.sharedItems[0]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuItem.sharedItems.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let menuItem = MenuItem.sharedItems[indexPath.row]
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 36.0)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = menuItem.symbol
        
        cell.contentView.backgroundColor = menuItem.color

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        (navigationController?.parent as! ContainerViewController).menuItem = MenuItem.sharedItems[indexPath.row]
    }
    
}
