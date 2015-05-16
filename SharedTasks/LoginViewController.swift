//
//  LoginViewController.swift
//  SharedTasks
//
//  Created by John Verrone on 5/15/15.
//  Copyright (c) 2015 John Verrone. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 100, 100)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(actInd)
        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "splash.jpg")?.drawInRect(self.view.bounds)
//        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        self.view.backgroundColor = UIColor(patternImage: image)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
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

    // MARK: Actions
    
    @IBAction func loginAction(sender: AnyObject) {
        
        var username = self.usernameText.text
        var password = self.passwordText.text
        
        if (count(username.utf16) < 4 || count(password.utf16) < 5) {
            var alert = UIAlertView(title: "Invalid", message: "Username/password not found.", delegate: self, cancelButtonTitle: "OK")
            
            alert.show()
        
        } else {
            
            self.actInd.startAnimating()
            
            PFUser.logInWithUsernameInBackground(username, password: password, block: { (user, error) -> Void in
                self.actInd.stopAnimating()
                
                if (user != nil) {
                    var alert = UIAlertView(title: "Success", message: "Logged in.", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                } else {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
    }
    
    @IBAction func signupAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier("signupSegue", sender: self)
    }
}
