//
//  ViewController.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 2/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class ViewController: UIViewController,SideMenuItemContent {

    @IBAction func openMenu(_ sender: UIButton) {
        showSideMenu()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

