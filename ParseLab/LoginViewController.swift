//
//  LoginViewController.swift
//  ParseLab
//
//  Created by my mac on 12/4/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    let loginSegue = "LoginSegue"
    
    
    
    
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        
        
        guard let username = self.usernameTextField.text else {
            print("The username text field box is empty")
            let alertController = UIAlertController(title: "Empty Field", message: "Username field is empty.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okActon = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
                 //Don't really have to do anything but notify the user.
            })
            
            return
        }
        
        guard let password = self.passwordTextField.text else {
            print("The password text field box is empty")
           return
        }
    
        
        self.registerUser(with: username, and: password)
        
      
        
    }
    
    
    @IBAction func onLoginTapped(_ sender: Any) {
        
        guard let username = self.usernameTextField.text else {
            print("The username text field box is empty")
            let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action:UIAlertAction) in
                
                //Handle cancel response here.
                
            })
            
            //Add the cancel action to the alert controller
            
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
                //Handle response here.
            })
            
            alertController.addAction(OKAction)
            
            present(alertController, animated: true){
                //Optional code for what happens after the alert controller has finished presenting
            }
            return
        }
        
        guard let password = self.passwordTextField.text else {
            print("The password text field box is empty")
            return
        }
        
        self.loginUser(with: username, and: password)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerUser(with username: String, and password: String){
        //Create a new user object.
        let newUser = PFUser()
        
        newUser.username = username
        newUser.password = password
    
        
        //Call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                //Do some error handling ... .
                print("[ERROR] \(error.localizedDescription)")
            }else {
                
                //React appropriately to successful register.
               print("User Registered successfully")
            }
        }
    
    }
    
    func loginUser(with username: String, and password: String){
    
        let user = PFUser()
        user.username = username
        user.password  = password
      
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("[ERROR] \(error.localizedDescription)")
            }else {
               print("The user logged in successfully!")
                //Deal with succesfully login here. (Next view controller)
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
