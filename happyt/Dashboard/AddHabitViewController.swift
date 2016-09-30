//
//  AddHabitViewController.swift
//  happyt
//
//  Created by Max Saienko on 9/17/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit

class AddHabitViewController: UITableViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var nameText: UITextField!
    
    @IBOutlet var positiveActionSwitch: UISwitch!
    
    @IBOutlet var negativeActionSwitch: UISwitch!
    
    @IBAction func CancelClick(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func SaveClick(sender: UIBarButtonItem) {
        // TODO: null checks
        let newHabit = Habit(name: nameText.text!, hasPlusButton: positiveActionSwitch.on, hasMinusButton: negativeActionSwitch.on)
        
        debugPrint(positiveActionSwitch.on)
        debugPrint(negativeActionSwitch.on)
        appDelegate.habits.append(newHabit)
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
