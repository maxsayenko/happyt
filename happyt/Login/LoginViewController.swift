//
//  ViewController.swift
//  happyt
//
//  Created by Max Saienko on 8/29/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import UIKit
import SCLAlertView

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
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
        debugPrint("User Logged In")
        
        if ((error) != nil)
        {
            SCLAlertView().showError("Login Error", subTitle: "Failed FaceBook login.")
        }
        else if result.isCancelled {
            // Handle cancellations
            SCLAlertView().showError("Access Error", subTitle: "Login was canceled.")
        }
        else {
            // TODO: Simplify login flow
            returnUserData()
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        // logout
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            debugPrint("got FBSDKGraphRequest DONE")
            if ((error) != nil) {
                // Process error
                SCLAlertView().showError("Data Error", subTitle: "Failed to get user information.")
            }
            else {
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
                self.performSegueWithIdentifier("toDashboardSegue", sender: self)
            }
        })
    }
}