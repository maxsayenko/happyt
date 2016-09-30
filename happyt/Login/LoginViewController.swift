//
//  ViewController.swift
//  happyt
//
//  Created by Max Saienko on 8/29/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            debugPrint("Logged In")
            returnUserData()

        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
            debugPrint("Error: loginButton")
        }
        else if result.isCancelled {
            // Handle cancellations
            debugPrint("Error: Handle cancellations")
        }
        else {
            // TODO: Simplify login flow
            debugPrint("segue1")
            returnUserData()
            //self.performSegueWithIdentifier("toDashboardSegue", sender: self)
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        debugPrint("returnUserData")
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            debugPrint("got FBSDKGraphRequest DONE")
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            }
            else {
                print("fetched user: \(result)")
                var userInfo = UserInfo()
                if let userName = result.valueForKey("name") as? String {
                    userInfo.name = userName
                }

                if let userEmail = result.valueForKey("email") as? String {
                    userInfo.email = userEmail
                }
                
                if let userId = result.valueForKey("id") as? String {
                    userInfo.id = userId
                }
                
                self.appDelegate.userInfo = userInfo
                debugPrint(self.appDelegate.userInfo)
                
                debugPrint("segue")
                self.performSegueWithIdentifier("toDashboardSegue", sender: self)
            }
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        debugPrint(segue.identifier)
        if(segue.identifier == "toDashboardSegue") {

        }
    }
}