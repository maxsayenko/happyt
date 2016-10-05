//
//  StatsController.swift
//  happyt
//
//  Created by Max Saienko on 9/17/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit
import SwiftCharts
import CoreData

class StatsViewController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // Core Data - Convenience methods
    lazy var sharedContext: NSManagedObjectContext =  {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    var heightConstraint:  NSLayoutConstraint!
    
    var habits: [Habit] = []
    var charts: [Chart] = []

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBAction func todayButtonTouch(sender: UIButton) {
        debugPrint("today")
    }
    @IBAction func weekButtonTouch(sender: UIButton) {
        debugPrint("week")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // CoreData - fetching habits
        let fetchRequest = NSFetchRequest(entityName: "Habit")
        do {
            habits = try sharedContext.executeFetchRequest(fetchRequest) as! [Habit]
        } catch let error as NSError {
            debugPrint("Habit Fetch failed: \(error.localizedDescription)")
        }
        
        contentView.subviews.forEach({ $0.removeFromSuperview() })
        getGraphs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightConstraint = NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0)
        contentView.addConstraint(heightConstraint)
    }
    
    func getGraphs() {
        var offsetY: CGFloat = 10
        var contentHeight: CGFloat = 0
        let containerWidth = view.frame.width - 22
        let containerHeight: CGFloat = 300
        for habit in habits {
            let container = HabitContainer(frame: CGRectMake(10, offsetY, containerWidth, containerHeight), habit: habit)
            
            contentView.addSubview(container.view)
            charts.append(container.chart)
            
            offsetY = 10 + container.view.frame.maxY
            contentHeight = container.view.frame.maxY
        }
        
        heightConstraint.constant = contentHeight
    }
}
