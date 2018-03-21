//
//  EventsDetailVC.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 11/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import CoreData

class EventsDetailVC: UIViewController {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var eventsArray:NSMutableArray = []
    
    var array:NSArray = []
    
    @IBOutlet var lblEName:UILabel!
    @IBOutlet var lblTime:UILabel!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet var lblLocation:UILabel!
    
    var friendString:NSString! = ""
    var index:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEventInfo()
        // Do any additional setup after loading the view.
        
        array = eventsArray .object(at: index) as! NSArray
        
        lblEName.text = NSString(format:"Eventname: %@",array .object(at: 0) as! CVarArg) as String
        lblTime.text = NSString(format:"Time: %@",array .object(at: 1) as! CVarArg) as String
        lblDate.text = NSString(format:"Date: %@",array .object(at: 2) as! CVarArg) as String
        lblLocation.text = NSString(format:"Location: %@",array .object(at: 3) as! CVarArg) as String
    }
    
    func getEventInfo(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Event", in: appDelegate.getContext())
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try appDelegate.getContext().fetch(fetchRequest)
            
            for friend in result as! [NSManagedObject]{
                let ename = String(friend.value(forKey: "name") as! String)
                let time = String(friend.value(forKey: "time") as! String)
                let date = String(friend.value(forKey: "date") as! String)
                let location = String(friend.value(forKey: "location") as! String)
                //print(fn,ln,age,address)
                if (ename != nil && time != nil && date != nil && location != nil) {
                    let event = [ename!,time!,date!,location!]
                    
                    eventsArray.add(event)
                    }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func editEvent(_ sender: UIButton) {
        appDelegate.addevent = false
        appDelegate.eventName = array.object(at: 0) as! String
        appDelegate.eventTime = array.object(at: 1) as! String
        appDelegate.eventDate = array.object(at: 2) as! String
        appDelegate.eventLocation = array.object(at: 3) as! String
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteEvent(_ sender: UIButton) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Event", in: appDelegate.getContext())
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        fetchRequest.predicate = NSPredicate(format: "name = %@",array.object(at: 0) as! CVarArg)
        let result = try! appDelegate.getContext().fetch(fetchRequest)
        for event in result as! [NSManagedObject]{
            appDelegate.getContext().delete(event)
        }
        do{
            try appDelegate.getContext().save()
            self.dismiss(animated: true, completion: nil)
        }catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    @IBAction func map(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FriendMapVC") as! FriendMapVC
        nextViewController.name = array.object(at: 0) as! String
        nextViewController.address = array.object(at: 3) as! String
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
