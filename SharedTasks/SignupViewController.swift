//
//  SignupViewController.swift
//  SharedTasks
//
//  Created by John Verrone on 5/16/15.
//  Copyright (c) 2015 John Verrone. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
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
    
    // MARK: Actions
    
    @IBAction func createUserAction(sender: AnyObject) {
        var username = self.usernameText.text
        var password = self.passwordText.text
        var email = self.emailText.text
        
        if (count(username.utf16) < 4 || count(password.utf16) < 5 || count(email.utf16) < 4) {
            var alert = UIAlertView(title: "Invalid", message: "enter correct shit please", delegate: self, cancelButtonTitle: "Click Me you little bitch")
            alert.show()
        } else {
            var newUser = PFUser()
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({(succeed, error) -> Void in
                if (error != nil) {
                    var alert = UIAlertView(title: "Invalid", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                } else {
                    var alert = UIAlertView(title: "Success", message: "User created", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
