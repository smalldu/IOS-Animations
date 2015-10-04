//
//  MenuItem.swift
//  AnimationDemo8
//
//  Created by duzhe on 15/10/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit
let menuColors = [
    UIColor(red: 249/255, green: 84/255,  blue: 7/255,   alpha: 1.0),
    UIColor(red: 69/255,  green: 59/255,  blue: 55/255,  alpha: 1.0),
    UIColor(red: 249/255, green: 194/255, blue: 7/255,   alpha: 1.0),
    UIColor(red: 32/255,  green: 188/255, blue: 32/255,  alpha: 1.0),
    UIColor(red: 207/255, green: 34/255,  blue: 156/255, alpha: 1.0),
    UIColor(red: 14/255,  green: 88/255,  blue: 149/255, alpha: 1.0),
    UIColor(red: 15/255,  green: 193/255, blue: 231/255, alpha: 1.0)
]

class MenuItem {
    
    let title: String
    let symbol: String
    let color: UIColor
    
    init(symbol: String, color: UIColor, title: String) {
        self.symbol = symbol
        self.color  = color
        self.title  = title
    }

    static var sharedItems:[MenuItem] {
        var items = [MenuItem]()
        
        items.append(MenuItem(symbol: "☎︎", color: menuColors[0], title: "Phone book"))
        items.append(MenuItem(symbol: "✉︎", color: menuColors[1], title: "Email directory"))
        items.append(MenuItem(symbol: "♻︎", color: menuColors[2], title: "Company recycle policy"))
        items.append(MenuItem(symbol: "♞", color: menuColors[3], title: "Games and fun"))
        items.append(MenuItem(symbol: "✾", color: menuColors[4], title: "Training programs"))
        items.append(MenuItem(symbol: "✈︎", color: menuColors[5], title: "Travel"))
        items.append(MenuItem(symbol: "🃖", color: menuColors[6], title: "Etc."))
        
        return items
    }
    
}
