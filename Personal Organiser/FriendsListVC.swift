//
//  FriendsListVC.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 3/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import CoreData

class FriendsListVC: UIViewController,SideMenuItemContent,UITableViewDelegate,UITableViewDataSource {
    
    var friendsArray:NSMutableArray = []
    var nameArray:NSMutableArray = []
    var dictFriend:NSMutableDictionary = [:]
    var dictData:NSDictionary = [:]
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if !appDelegate.addfriend {
            tabBarController?.selectedIndex = 0
        }
        
        getFriendInfo()
    }
    
    @IBOutlet var tblFriends:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //nspredicate
    //fetchreq.pred = nspredi[format:"== %@,"lbl.text]
    
    func getFriendInfo(){
        
        nameArray.removeAllObjects()
        friendsArray.removeAllObjects()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Friends", in: appDelegate.getContext())
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try appDelegate.getContext().fetch(fetchRequest)
            
            for friend in result as! [NSManagedObject]{
                let fn = String(friend.value(forKey: "firstname") as! String)
                let ln = String(friend.value(forKey: "lastname") as! String)
                let gender = String(friend.value(forKey: "gender") as! String)
                let age = String(friend.value(forKey: "age") as! String)
                let address = String(friend.value(forKey: "address") as! String)
                //print(fn,ln,age,address)
                if (fn != nil && ln != nil && age != nil && address != nil) {
                    let friendA = [fn!,ln!,gender!,age!,address!]
                    let name = fn!+" "+ln!
                    dictFriend["fName"] = fn!
                    dictFriend["lName"] = ln!
                    dictFriend["gender"] = gender!
                    dictFriend["age"] = age!
                    dictFriend["address"] = address!
                    
                    friendsArray.add(friendA)
                    nameArray.add(name)
                    tblFriends.reloadData()
                }
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    
   /* func getFriendinfo() -> NSArray {
        
        var arr:NSArray!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Friends", in: getContext())
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try getContext().fetch(fetchRequest)
            
            for friend in result as! [NSManagedObject]{
                let fn = String(friend.value(forKey: "firstname") as! String)
                let ln = String(friend.value(forKey: "lastname") as! String)
                let age = String(friend.value(forKey: "age") as! String)
                let address = String(friend.value(forKey: "address") as! String)
                //print(fn,ln,age,address)
//                friendsArray.add(ln! as String)
//                friendsArray.add(age! as String)
//                friendsArray.add(address! as String)
//                print(friendsArray .object(at: 0))
                
            }
            //print(result)
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return arr
    }*/

//    
//    func getContext () -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate
//            as! AppDelegate
//        return
//            appDelegate.persistentContainer.viewContext
//    }
    
    @IBAction func sideMenu(_ sender: UIButton) {
        
        if let menuItemViewController = self.tabBarController as? SideMenuItemContent {
            menuItemViewController.showSideMenu()
        }
    }
    
    @IBAction func addFriend(_ sender: UIButton) {
        
        
//        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFriendVC") as UIViewController
//        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
//        
//        self.present(viewController, animated: false, completion: nil)
        
        tabBarController?.selectedIndex = 0

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return nameArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = nameArray[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FriendsDetailVC") as! FriendsDetailVC
        nextViewController.index = indexPath.row
//        let keys = ["keys"]
//
//        print(friendsArray .object(at: indexPath.row))
//        
//        nextViewController.dictFriend = NSDictionary.init(objects: [friendsArray .object(at: indexPath.row)], forKeys: keys as [NSCopying])
        self.present(nextViewController, animated:true, completion:nil)
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
