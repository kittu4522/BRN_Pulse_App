//
//  TabBarDataViewController.swift
//  Pulse_Project
//
//  Created by RAM on 13/04/20.
//  Copyright © 2020 RAM. All rights reserved.
//

import UIKit

class TabBarDataViewController: UITabBarController
{

    @IBOutlet weak var dataTabBar: UITabBar!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func change(tag:Int)
    {
        self.tabBarController?.selectedIndex = tag
    }
    

}
