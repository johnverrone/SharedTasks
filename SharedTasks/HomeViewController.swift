//
//  HomeViewController.swift
//  SharedTasks
//
//  Created by John Verrone on 5/17/15.
//  Copyright (c) 2015 John Verrone. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    let storyBoard = UIStoryboard(name: "Main", bundle:nil)
    
    lazy var login: LoginViewController = {
        return self.storyBoard.instantiateViewControllerWithIdentifier("login") as! LoginViewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if let user = PFUser.currentUser() {
            println("Loged is as: \(PFUser.currentUser()!.username!)")
        } else {
            self.presentViewController(login, animated: true, completion: nil)
        }
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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

    @IBAction func listsAction(sender: AnyObject) {
        self.performSegueWithIdentifier("listsSegue", sender: self)
    }
    
    @IBAction func groupsAction(sender: AnyObject) {
        self.performSegueWithIdentifier("groupsSegue", sender: self)
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        PFUser.logOut()
        self.presentViewController(login, animated: true, completion: nil)
    }
}
