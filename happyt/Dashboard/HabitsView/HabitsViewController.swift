//
//  DashboardViewController.swift
//  happyt
//
//  Created by Max Saienko on 8/31/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit

class HabitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var userProfImageView: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var table: UITableView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Habits")
        debugPrint(appDelegate.habits)
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.habits.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCellWithIdentifier("habitCell")! as! HabitTableViewCell
        cell.nameLabel.text = appDelegate.habits[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedHabit = appDelegate.habits[indexPath.row]
        debugPrint("cell touched at index: \(indexPath.row) with name: \(selectedHabit.name)")
    }
}
