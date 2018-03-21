//
//  EventsListVC.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 3/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import CoreData

class EventsListVC: UIViewController,SideMenuItemContent,UITableViewDataSource,UITableViewDelegate {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewWillAppear(_ animated: Bool) {
        getEventInfo()
        
        if !appDelegate.addevent {
            tabBarController?.selectedIndex = 2
        }
    }
    
    @IBOutlet var tblEvents:UITableView!
    var eventsArray:NSMutableArray = []
    var timeArray:NSMutableArray = []
    var deleteArray:NSMutableArray = []
    var eventName:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func getEventInfo() {
        
        timeArray.removeAllObjects()
        eventsArray.removeAllObjects()
        eventName.removeAllObjects()
        deleteArray.removeAllObjects()
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
                    // let friendA = [fn!,ln!,age!,address!]
                    let name = ename!+" at "+location!+" on "+date!
                    let eTime = date!+" "+time!
                    eventsArray.add(name)
                    eventName.add(ename!)
                    
                    let dateFormatterD = DateFormatter()
                    dateFormatterD.dateFormat = "MMMM d, yyyy HH:mm a"
                    let d = dateFormatterD.date(from: eTime)

                    timeArray.add(d!)
                    print(eventsArray)
                    tblEvents.reloadData()
                }
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    
    @IBAction func sideMenu(_ sender: UIButton) {
        
        if let menuItemViewController = self.tabBarController as? SideMenuItemContent {
            menuItemViewController.showSideMenu()
        }
    }
    
    @IBAction func addEvent(_ sender: UIButton) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Event", in: appDelegate.getContext())
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        for i in (0..<deleteArray.count){
            fetchRequest.predicate = NSPredicate(format: "name = %@",deleteArray.object(at: i) as! CVarArg)
            let result = try! appDelegate.getContext().fetch(fetchRequest)
            for event in result as! [NSManagedObject]{
                appDelegate.getContext().delete(event)
            }
            do{
                try appDelegate.getContext().save()
            }catch {
                let fetchError = error as NSError
                print(fetchError)
            }
        }
        getEventInfo()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        
    
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        let date = dateFormatter.string(from: Date())
        let eDate = dateFormatter.string(from: timeArray[indexPath.row] as! Date)
        
                // set the text from the data model
        cell.textLabel?.text = eventsArray[indexPath.row] as? String
        if date > eDate {
            cell.backgroundColor = UIColor.purple
        }
        else{
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        let date = dateFormatter.string(from: Date())
        let eDate = dateFormatter.string(from: timeArray[indexPath.row] as! Date)
        
        if date > eDate {
            let alertView = UIAlertController(title: "Personal Organiser", message: "Sorry\n This event has been passed." as String, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)

        }
        else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EventsDetailVC") as! EventsDetailVC
            nextViewController.index = indexPath.row
            self.present(nextViewController, animated:true, completion:nil)
        }
        
    }
    
    @IBAction func checked(_ sender: UIButton) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:tblEvents)
        let indexPath = tblEvents.indexPathForRow(at: buttonPosition)
        
        if sender.isSelected {
            sender.isSelected = false
            deleteArray.remove(eventName .object(at: (indexPath?.row)!))

        }
        else{
            sender.isSelected = true
            deleteArray.add(eventName .object(at: (indexPath?.row)!))
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
