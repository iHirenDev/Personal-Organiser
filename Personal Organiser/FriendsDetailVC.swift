//
//  FriendsDetailVC.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 11/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import CoreData
class FriendsDetailVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var friendsArray:NSMutableArray = []
    
    var array:NSArray = []
    
    
    @IBOutlet var lblFName:UILabel!
    @IBOutlet var lblLName:UILabel!
    @IBOutlet var lblGender:UILabel!
    @IBOutlet var lblAge:UILabel!
   
    @IBOutlet var lblAddress:UILabel!
    
    var friendString:NSString! = ""
    var index:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                   
                    friendsArray.add(friendA)
                }
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        array = friendsArray .object(at: index) as! NSArray
        
        lblFName.text = NSString(format:"Firstname: %@",array .object(at: 0) as! CVarArg) as String
        lblLName.text = NSString(format:"Lastname: %@",array .object(at: 1) as! CVarArg) as String
        lblGender.text = NSString(format:"Gender: %@",array .object(at: 2) as! CVarArg) as String
        lblAge.text = NSString(format:"Age: %@",array .object(at: 3) as! CVarArg) as String
        lblAddress.text = NSString(format:"Address: %@",array .object(at: 4) as! CVarArg) as String

}

    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editFriend(_ sender: UIButton) {
        appDelegate.addfriend = false
        appDelegate.friendFName = array.object(at: 0) as! String
        appDelegate.friendLName = array.object(at: 1) as! String
        appDelegate.friendGender = array.object(at: 2) as! String
        appDelegate.friendAge = array.object(at: 3) as! String
        appDelegate.friendAddress = array.object(at: 4) as! String
        self.dismiss(animated: true, completion: nil)
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func map(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FriendMapVC") as! FriendMapVC
        nextViewController.name = array.object(at: 0) as! String
        nextViewController.address = array.object(at: 4) as! String
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    @IBAction func deleteFriend(_ sender: UIButton) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Friends", in: appDelegate.getContext())
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        fetchRequest.predicate = NSPredicate(format: "firstname = %@",array.object(at: 0) as! CVarArg)
        let result = try! appDelegate.getContext().fetch(fetchRequest)
        for friend in result as! [NSManagedObject]{
            appDelegate.getContext().delete(friend)
        }
        do{
            try appDelegate.getContext().save()
            self.dismiss(animated: true, completion: nil)
        }catch {
            let fetchError = error as NSError
            print(fetchError)
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
