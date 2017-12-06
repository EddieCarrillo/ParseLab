//
//  ChatViewController.swift
//  ParseLab
//
//  Created by my mac on 12/5/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var chatMessageTextField: UITextField!
    
    @IBAction func onSendTapped(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["text"] = chatMessageTextField.text ?? ""
        
        
        chatMessage.saveInBackground { (success: Bool, error: Error?) in
            if (success){
                print("Message was saved")
                //Clear the chat message fiels
                self.chatMessageTextField.text = ""
            }else if let error = error {
                print("Problem saving the message: \(error.localizedDescription)")
            }
        }
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
