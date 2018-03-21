//
//  POSTabController.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 6/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class POSTabController: UITabBarController,SideMenuItemContent {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewWillAppear(_ animated: Bool) {
        if !appDelegate.addevent {
            appDelegate.addevent = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class AddFriendVC: UIViewController {
        
        /*
         Show menu on click if connected tab bar controller adopts proper protocol.
         */
        @IBAction func sideMenu(_ sender:UIButton){
            
        }
        @IBAction func openMenu(_ sender: UIButton) {
            
            if let menuItemViewController = self.tabBarController as? SideMenuItemContent {
                menuItemViewController.showSideMenu()
            }
        }
    }
    
    /*
     The second controller of tab bar.
     */
    class FriendsListVC: UIViewController {
        
        /*
         Show menu on click if connected tab bar controller adopts proper protocol.
         */
        @IBAction func openMenu(_ sender: UIButton) {
            
            if let menuItemViewController = self.tabBarController as? SideMenuItemContent {
                menuItemViewController.showSideMenu()
            }
        }
        
    }
    
    class AddEventVC: UIViewController {
        
        /*
         Show menu on click if connected tab bar controller adopts proper protocol.
         */
        @IBAction func openMenu(_ sender: UIButton) {
            
            if let menuItemViewController = self.tabBarController as? SideMenuItemContent {
                menuItemViewController.showSideMenu()
            }
        }
        
    }
    
    class EventsListVC: UIViewController {
        
        /*
         Show menu on click if connected tab bar controller adopts proper protocol.
         */
        @IBAction func openMenu(_ sender: UIButton) {
            
            if let menuItemViewController = self.tabBarController as? SideMenuItemContent {
                menuItemViewController.showSideMenu()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
