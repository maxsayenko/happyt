//
//  DashboardViewController.swift
//  happyt
//
//  Created by Max Saienko on 8/31/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit
import CoreData
import SCLAlertView

class HabitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var defaultColor: CGColor? = nil
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // Core Data - Convenience methods
    lazy var sharedContext: NSManagedObjectContext =  {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    var habits: [Habit] = []
    
    @IBOutlet var userProfImageView: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var table: UITableView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // CoreData - fetching habits
        let fetchRequest = NSFetchRequest(entityName: "Habit")
        do {
            habits = try sharedContext.executeFetchRequest(fetchRequest) as! [Habit]
        } catch let error as NSError {
            debugPrint("Habit Fetch failed: \(error.localizedDescription)")
        }
        
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        defaultColor = self.view.backgroundColor?.CGColor

        userProfImageView.layer.cornerRadius = 40
        userProfImageView.layer.borderColor = UIColor.grayColor().CGColor
        userProfImageView.layer.borderWidth = 0.5
        userProfImageView.clipsToBounds = true
        
        userNameLabel.text = appDelegate.userInfo?.name
        
        if let userInfo: UserInfo = appDelegate.userInfo {
            Service.LoadImage(url: userInfo.profilePicSource).then { image in
                dispatch_async(dispatch_get_main_queue(), {
                    self.userProfImageView.image = image
                })
                }.error { err in
                    debugPrint("Error while fetching Image from url: \(err)")
                    SCLAlertView().showError("Load Error", subTitle: "Failed to load profile image")
            }
        }
    }
    
    func plusButtonClicked(sender:UIButton) {
        saveEvent(true, row: sender.tag)
    }
    
    func minusButtonClicked(sender:UIButton) {
        saveEvent(false, row: sender.tag)
    }
    
    func saveEvent(isPositive: Bool, row: Int) {
        let habit = habits[row]
        let event = Event(isPositive: isPositive, context: sharedContext)
        event.habit = habit
        saveContext()
        
        let color = isPositive ? UIColor.greenColor().CGColor : UIColor.redColor().CGColor
        UIView.animateWithDuration(0, animations: {() -> Void in
            self.view.layer.backgroundColor = color
            }, completion: { isCompleted -> Void in
                UIView.animateWithDuration(1, animations: {() -> Void in
                    self.view.layer.backgroundColor = self.defaultColor
                })
        })
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCellWithIdentifier("habitCell")! as! HabitTableViewCell
        let habit: Habit = habits[indexPath.row]
        cell.nameLabel.text = habit.name
        
        cell.plusButton.hidden = !habit.hasPlusButton
        cell.plusButton.tag = indexPath.row
        cell.plusButton.addTarget(self, action: #selector(HabitsViewController.plusButtonClicked(_:)), forControlEvents: .TouchUpInside)
        
        cell.minusButton.hidden = !habit.hasMinusButton
        cell.minusButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(HabitsViewController.minusButtonClicked(_:)), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let habit = habits[indexPath.row]
            sharedContext.deleteObject(habit)
            
            habits.removeAtIndex(indexPath.row)
            table.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Bottom)

            saveContext()
        }
    }
}
