//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Ratnakala53 on 1/13/16.
//  Copyright © 2016 ratnakala. All rights reserved.
//

import UIKit
import CoreData

enum SignUpFormField {
    case FirstName(String)
    case LastName(String)
    case EmailAddress(String)
    case DOB(NSDate)
}

enum jj
{
    case red
    case black
    case white
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let taylorSwiftsBday: NSDate = {
        let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let dateComponents = NSDateComponents()
        dateComponents.day = 13
        dateComponents.month = 12
        dateComponents.year = 1989
        return gregorianCalendar?.dateFromComponents(dateComponents) ?? NSDate()
    }()
    
    var str = "Patel"
    
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bornBeforeTaylorSwift(SignUpFormField.DOB(NSDate()))
        bornBeforeTaylorSwift(SignUpFormField.FirstName("Patel"))
    }
    
    func bornBeforeTaylorSwift(signUpFormField: SignUpFormField) {
        
        if case .DOB(let otherBday) = signUpFormField
            where taylorSwiftsBday.compare(otherBday) == .OrderedAscending
        {
            print("Fun fact: You were born before Taylor Swift!")
        }
        
        
        if case .FirstName(let fnm) = signUpFormField where 5 == fnm.characters.count
        {
            print("true")
        }
        
        let x = jj.red
        if case .red = x
        {
            print("---")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btn_Add(sender: AnyObject) {
        
        let entityDescription =
        NSEntityDescription.entityForName("Contact",
            inManagedObjectContext: managedObjectContext)
        
        let contact = Contact(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)
        
        contact.name = txt_name.text
        contact.city = txt_city.text
        contact.number = txt_contact.text
        
        do{
            try  managedObjectContext.save()
            
        }catch
        {
            fatalError("Failed to fetch person: \(error)")
        }
        
    }
    
    @IBAction func btn_showAll(sender: AnyObject) {
        let entityDescription =
        NSEntityDescription.entityForName("Contact",
            inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        
        request.entity = entityDescription
        do{
            let objects = try managedObjectContext.executeFetchRequest(request)
            print(objects)
            
            if objects.count != 0  {
                q_arr = objects as! [NSManagedObject]
                j_arr.removeAllObjects()
                for i in 0..<objects.count
                {
                    let match = objects[i] as! NSManagedObject
                    print("name:",(match.valueForKey("name")! as! String) + " contact:" + (match.valueForKey("city")! as! String))
                    let d = NSMutableDictionary()
                    d.setObject(match.valueForKey("name")!, forKey: "name")
                    d.setObject(match.valueForKey("number")!, forKey: "number")
                    d.setObject(match.valueForKey("city")!, forKey: "city")
                    j_arr.addObject(d)
                }
                tbl_dataTable.reloadData()
                
            }else {
                txt_sts.text = "Not FOund"
            }
            
            
        }catch
        {
            fatalError("Failed to fetch person: \(error)")
        }
        
        
        
    }
    
    
    @IBAction func btn_Search(sender: AnyObject) {
        let entityDescription =
        NSEntityDescription.entityForName("Contact",
            inManagedObjectContext: managedObjectContext)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        //let pred = NSPredicate(format: "(name,city = %@)", txt_search.text!)
        let pred1 = NSPredicate(format: "(name = %@)", txt_search.text!)
        let pred2 = NSPredicate(format: "(city = %@)", txt_search.text!)
        
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType, subpredicates: [pred1,pred2])
        request.predicate = predicate
        
        
        do{
            let objects = try managedObjectContext.executeFetchRequest(request)
            
            if objects.count != 0  {
                
                
                for i in 0..<objects.count
                {
                    let match = objects[i] as! NSManagedObject
                    print("name:",(match.valueForKey("name")! as! String) + " contact:" + (match.valueForKey("city")! as! String))
                }
                
                
            }else {
                txt_sts.text = "Not FOund"
            }
            
            
        }catch
        {
            fatalError("Failed to fetch person: \(error)")
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : jCell = tableView.dequeueReusableCellWithIdentifier("jcell") as! jCell
        let match = q_arr[indexPath.row]
        //let d = j_arr[indexPath.row] as! NSMutableDictionary
        cell.lbl_city.text = match.valueForKey("city")! as? String
        cell.lbl_contact.text = match.valueForKey("number")! as? String
        cell.lbl_name.text = match.valueForKey("name")! as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return q_arr.count
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (UITableViewRowAction, NSIndexPath) -> Void in
            
            let context:NSManagedObjectContext = self.managedObjectContext
            context.deleteObject(self.q_arr[indexPath.row])
            do{
                try  self.managedObjectContext.save()
            }catch
            {
                fatalError("Failed to fetch person: \(error)")
            }
        }
        return [delete]
    }
    
    var j_arr = NSMutableArray()
    var q_arr:[NSManagedObject]! = []
    
    @IBOutlet weak var txt_city: UITextField!
    @IBOutlet weak var txt_contact: UITextField!
    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_sts: UILabel!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tbl_dataTable: UITableView!
}

