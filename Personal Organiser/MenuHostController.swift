//
//  MenuHostController.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 3/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import InteractiveSideMenu

class MenuHostController: MenuContainerViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.main.bounds
        self.transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: screenSize.width / 6)
        menuViewController = self.storyboard!.instantiateViewController(withIdentifier: "Sidemenu") as! MenuViewController
        
        
        self.contentViewControllers = contentControllers()
        
        // Select initial content controller. It's needed even if the first view controller should be selected.
        self.selectContentViewController(contentViewControllers.first!)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        /*
         Options to customize menu transition animation.
         */
        var options = TransitionOptions()
        
        // Animation duration
        options.duration = size.width < size.height ? 0.4 : 0.6
        
        // Part of item content remaining visible on right when menu is shown
        options.visibleContentWidth = size.width / 6
        self.transitionOptions = options
    }
    
    private func contentControllers() -> [UIViewController] {
        let controllersIdentifiers = ["ViewController","Tabbar"]
        var contentList = [UIViewController]()
        
        /*
         Instantiate items controllers from storyboard.
         */
        for identifier in controllersIdentifiers {
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) {
                contentList.append(viewController)
            }
        }
        
        return contentList
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
