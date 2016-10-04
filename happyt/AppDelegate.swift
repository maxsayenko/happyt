//
//  AppDelegate.swift
//  happyt
//
//  Created by Max Saienko on 8/29/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var habits: [Habit] = []
    var userInfo: UserInfo?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var habit1 = Habit(name: "test1", hasPlusButton: true, hasMinusButton: true)
        for hour in [3, 7, 10, 17, 19, 23] {
            let c = NSDateComponents()
            c.year = 2016
            c.month = 10
            c.day = 3
            c.hour = hour
            c.minute = 15
            c.second = 37
            let date = NSCalendar.currentCalendar().dateFromComponents(c)
            
            var positive = true
            if (hour == 3 || hour == 11 || hour == 19) {
                positive = false
            }
            
            let event = Event(habitId: habit1.id, date: date!, isPositive: positive)
            habit1.events.append(event)
        }
        
        habits.append(habit1)
        habits.append(Habit(name: "new one", hasPlusButton: true, hasMinusButton: false))
        habits.append(Habit(name: "new one1", hasPlusButton: true, hasMinusButton: false))
            
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
//        debugPrint("checkOrientation")
//        debugPrint(viewController?.title)
        if (viewController == nil) {
            return UIInterfaceOrientationMask.Portrait
        } else if (viewController is StatsViewController) {
//            debugPrint("StatsViewController")
            return UIInterfaceOrientationMask.Portrait
        } else if(viewController?.title == "navigationController") {
//            debugPrint("is Navigation")
            
            
            if let tabBarController = viewController?.tabBarController{
//                debugPrint("=======")
//                debugPrint(tabBarController.title)
            }
        }
        return UIInterfaceOrientationMask.Portrait
//        } else if viewController is MyTabBarController {
//            if let tabBarController = viewController as? MyTabBarController,
//                navigationViewControllers = tabBarController.viewControllers as? [MyNavigationController] {
//                return checkOrientation(navigationViewControllers[tabBarController.selectedIndex].visibleViewController)
//            } else {
//                return UIInterfaceOrientationMask.Portrait
//            }
//            
//        } else {
//            return checkOrientation(viewController!.presentedViewController)
//        }
    }


}

