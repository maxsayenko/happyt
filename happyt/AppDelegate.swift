//
//  AppDelegate.swift
//  happyt
//
//  Created by Max Saienko on 8/29/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var userInfo: UserInfo?
    
    // Core Data - Convenience methods
    lazy var sharedContext: NSManagedObjectContext =  {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Dear, Udacity reviewer feel free to use this stub data to generate some dummy events.
        // It makes graphs review easier and pretier. 
        // Comment scratchpadContext out and uncomment sharedContext to use.
        let context = CoreDataStackManager.sharedInstance().scratchpadContext
        //let context = sharedContext
        
        let today = NSDate()
        
        func getEvents(eventHoursPerDay: [(day: Int, hours: [Int])]) -> [Event] {
            var events: [Event] = []
            for daySettings in eventHoursPerDay {
                for hour in daySettings.hours {
                    var positive = true
                    if (hour == 7 || hour == 19) {
                        positive = false
                    }
                    
                    let eventDate = today.startOfDay.addDays(daySettings.day).addHours(hour)
                    
                    let event = Event(date: eventDate, isPositive: positive, context: context)
                    events.append(event)
                }
            }
            
            return events
        }
        
        // First Habit
        let habit1 = Habit(name: "Drink Water", hasPlusButton: true, hasMinusButton: true, context: context)
        habit1.events = NSOrderedSet(array: getEvents(
            [
                // If some hours are in the future they will be ignored by the app. 
                // This time is in hours local to the phone
                // Negative days - to fill in older events, from previous days
                (0, [1, 3, 7, 11, 19, 21]),
                (-1, [3, 8, 15, 19]),
                (-2, [1, 3, 9, 12, 15, 17, 21, 23])
            ]
            ))
        
        // Second Habit
        let habit2 = Habit(name: "Stretch", hasPlusButton: true, hasMinusButton: true, context: context)
        habit2.events = NSOrderedSet(array: getEvents(
            [
                (0, [8, 10, 13, 15, 19, 21]),
                (-1, [1, 7, 15, 19, 22]),
            ]
            ))

        saveContext()
        
        // Override point for customization after application launch.
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application (application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return checkOrientation(self.window?.rootViewController)
    }
    
    // The “OpenURL” method allows your app to open again after the user has validated their login credentials.
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // The FBSDKAppEvents.activateApp() method allows Facebook to capture events within your application including Ads clicked on from Facebook to track downloads from Facebook and events like how many times your app was opened.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    func checkOrientation(viewController: UIViewController?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }


}

