//
//  StatsController.swift
//  happyt
//
//  Created by Max Saienko on 9/17/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit
import SwiftCharts

class StatsViewController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var charts: [Chart] = []

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let habits = appDelegate.habits
        debugPrint(scrollView.contentSize)
        debugPrint(contentView.frame)
        
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
        
        // Setting content Height for scroll view
        let heightConstraint = NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: contentHeight)
        NSLayoutConstraint.activateConstraints([heightConstraint])
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
