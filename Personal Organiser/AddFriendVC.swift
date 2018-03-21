//
//  AddFriendVC.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 3/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import CoreData

class AddFriendVC: UIViewController,SideMenuItemContent {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var txtFName: UITextField!
    @IBOutlet var txtLName: UITextField!
    @IBOutlet var txtAge: UITextField!
    @IBOutlet var txtAddress: UITextField!
    @IBOutlet var gender: UISegmentedControl!
    @IBOutlet var btn:UIButton!

    var friendGender:NSString = "Male"
    

    @IBAction func sideMenu(_ sender: UIButton) {
        
        if let menuItemViewController = self.tabBarController as? SideMenuItemContent {
            menuItemViewController.showSideMenu()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !appDelegate.addfriend {
            txtFName.text = appDelegate.friendFName
            txtLName.text = appDelegate.friendLName
            txtAge.text = appDelegate.friendAge
            txtAddress.text = appDelegate.friendAddress
            btn.setTitle("Update Friend", for: UIControlState.normal)
            
        }
        else{
            txtFName.text = ""
            txtLName.text = ""
            txtAge.text = ""
            txtAddress.text = ""
            btn.setTitle("Add Friend", for: UIControlState.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gender.selectedSegmentIndex = 0
    }
    
    @IBAction func addFriend(_ sender: UIButton) {
        switch gender.selectedSegmentIndex {
        case 0:
            friendGender = "Male"
        case 1:
            friendGender = "Female"
        default:
            break
        }
        
        var str:NSString
        
        str = (txtFName.text?.isEmpty)! ? "Please enter first name." :
            (txtLName.text?.isEmpty)! ? "Please enter last name." :
            (txtAge.text?.isEmpty)! ? "Please enter your friend's age." :
            (txtAddress.text?.isEmpty)! ? "Please enter your friend's address." : "";
        
        if str.isEqual(to: "") {
            
            if !appDelegate.addfriend {
                updateInfo(firstName: txtFName.text!, lastName: txtLName.text!,gender: friendGender as String, age: txtAge.text!, address: txtAddress.text!)
            }
            else{
                storeFriendInfo(firstName: txtFName.text!, lastName: txtLName.text!,gender: friendGender as String, age: txtAge.text!, address: txtAddress.text!)
            }
            
        }
        else{
            let alertView = UIAlertController(title: "Personal Organiser", message: str as String, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
        }
        
    }
    
    func storeFriendInfo (firstName: String, lastName: String,gender: String, age:
        String, address: String){
        let context = appDelegate.getContext()
        //retrieve the entity that we just created
        let entity = NSEntityDescription.entity(forEntityName: "Friends", in:
            context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        //set the entity values
        transc.setValue(firstName, forKey: "firstname")
        transc.setValue(lastName, forKey: "lastname")
        transc.setValue(gender, forKey: "gender")
        transc.setValue(age, forKey: "age")
        transc.setValue(address, forKey: "address")
        //save the object
        do {
            try context.save()
            appDelegate.addfriend = true
            tabBarController?.selectedIndex = 1
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        } catch { }
    }
    
    
    func updateInfo(firstName: String, lastName: String,gender: String, age:
        String, address: String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Friends", in: appDelegate.getContext())
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        fetchRequest.predicate = NSPredicate(format: "firstname = %@",appDelegate.friendFName)
        let result = try! appDelegate.getContext().fetch(fetchRequest)
        for friend in result as! [NSManagedObject]{
            //appDelegate.getContext().delete(friend)
            friend.setValue(firstName, forKey: "firstname")
            friend.setValue(lastName, forKey: "lastname")
            friend.setValue(gender, forKey: "gender")
            friend.setValue(age, forKey: "age")
            friend.setValue(address, forKey: "address")
        }
        do{
            try appDelegate.getContext().save()
            appDelegate.addfriend = true
            tabBarController?.selectedIndex = 1

        }catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
