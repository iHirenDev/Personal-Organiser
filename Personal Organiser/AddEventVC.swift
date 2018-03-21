//
//  AddEventVC.swift
//  Personal Organiser
//
//  Created by Hiren Patel on 3/10/17.
//  Copyright © 2017 wsu. All rights reserved.
//

import UIKit
import InteractiveSideMenu
import CoreData

class AddEventVC: UIViewController,SideMenuItemContent {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var tmPicker: UIDatePicker!
    
    @IBOutlet var txtEName:UITextField!
    @IBOutlet var txtTime:UITextField!
    @IBOutlet var txtDate:UITextField!
    @IBOutlet var txtLocation:UITextField!
    @IBOutlet var btn:UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if !appDelegate.addevent {
            txtEName.text = appDelegate.eventName
            txtTime.text = appDelegate.eventTime
            txtDate.text = appDelegate.eventDate
            txtLocation.text = appDelegate.eventLocation
            btn.setTitle("Update Event", for: UIControlState.normal)
        }
        else{
            txtEName.text = ""
            txtTime.text = ""
            txtDate.text = ""
            txtLocation.text = ""
            btn.setTitle("Add Event", for: UIControlState.normal)
        }
    }
    

    @IBAction func sideMenu(_ sender: UIButton) {
        
        if let menuItemViewController = self.tabBarController as? SideMenuItemContent {
            menuItemViewController.showSideMenu()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        
        let nowBtn = UIBarButtonItem(title: "Now", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddEventVC.tappedToolBarBtn))
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(AddEventVC.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Select event time"
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([nowBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        txtTime.inputAccessoryView = toolBar
        // Do any additional setup after loading the view.
        
       
        let tBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        tBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        tBar.barStyle = UIBarStyle.blackTranslucent
        tBar.tintColor = UIColor.white
        tBar.backgroundColor = UIColor.black
        
        
        let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddEventVC.tToolBarBtn))
        let doneBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(AddEventVC.dPressed))
        let fSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        lbl.font = UIFont(name: "Helvetica", size: 12)
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = UIColor.white
        lbl.text = "Select event date"
        lbl.textAlignment = NSTextAlignment.center
        
        let txtBtn = UIBarButtonItem(customView: lbl)
        tBar.setItems([todayBtn,fSpace,txtBtn,fSpace,doneBarBtn], animated: true)
        txtDate.inputAccessoryView = tBar
    }
    
    @IBAction func eventTime(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.time
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(timeEntered), for: UIControlEvents.valueChanged)
        
    }
    
    func timeEntered(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        //dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        txtTime.text = dateFormatter.string(from: sender.date)
    }
    
    func donePressed(_ sender: UIBarButtonItem){
        txtTime.resignFirstResponder()
    }
    
    func tappedToolBarBtn(_ sender: UIBarButtonItem) {
        
        let dateformatter = DateFormatter()
        dateformatter.timeStyle = DateFormatter.Style.short
        
        txtTime.text = dateformatter.string(from: Date())
        
        txtTime.resignFirstResponder()
    }
    
    
    @IBAction func eventDate(_ sender: UITextField) {
    
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(dateEntered), for: UIControlEvents.valueChanged)
    }
    
    func dateEntered(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateStyle = DateFormatter.Style.long
        
        txtDate.text = dateFormatter.string(from: sender.date)
    }
    
    func dPressed(_ sender: UIBarButtonItem){
        txtDate.resignFirstResponder()
    }
    
    func tToolBarBtn(_ sender: UIBarButtonItem) {
        
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.long
        
        txtDate.text = dateformatter.string(from: Date())
        
        txtDate.resignFirstResponder()
    }

    
    @IBAction func addEvent(_ sender: UIButton) {
        
        var str:NSString
        
        str = (txtEName.text?.isEmpty)! ? "Please enter event's name." :
            (txtTime.text?.isEmpty)! ? "Please enter event's time." :
            (txtDate.text?.isEmpty)! ? "Please enter event's date." :
            (txtLocation.text?.isEmpty)! ? "Please enter event's location." : "";
        
        if str.isEqual(to: "") {
            if !appDelegate.addevent {
                updateEventInfo(name: txtEName.text!, time: txtTime.text!, date: txtDate.text!, location: txtLocation.text!)
            }
            else{
                storeEventInfo(name: txtEName.text!, time: txtTime.text!, date: txtDate.text!, location: txtLocation.text!)
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
    
    func storeEventInfo (name: String, time: String, date:
        String, location: String){
        let context = appDelegate.getContext()
        //retrieve the entity that we just created
        let entity = NSEntityDescription.entity(forEntityName: "Event", in:
            context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        //set the entity values
        transc.setValue(name, forKey: "name")
        transc.setValue(time, forKey: "time")
        transc.setValue(date, forKey: "date")
        transc.setValue(location, forKey: "location")
        //save the object
        do {
            try context.save()
            appDelegate.addevent = true
            tabBarController?.selectedIndex = 3
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        } catch { }
    }
    
    func updateEventInfo(name: String, time: String, date:
        String, location: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "Event", in: appDelegate.getContext())
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        fetchRequest.predicate = NSPredicate(format: "name = %@",appDelegate.eventName)
        let result = try! appDelegate.getContext().fetch(fetchRequest)
        for event in result as! [NSManagedObject]{
            event.setValue(name, forKey: "name")
            event.setValue(time
                , forKey: "time")
            event.setValue(date, forKey: "date")
            event.setValue(location, forKey: "location")
        }
        do{
            try appDelegate.getContext().save()
            appDelegate.addevent = true
            tabBarController?.selectedIndex = 3
            
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
