//
//  ChatViewController.swift
//  ParseLab
//
//  Created by my mac on 12/5/17.
//  Copyright © 2017 ecproductions. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    


    
    
    
    var messages: [PFObject] = []
    
    
    @IBOutlet weak var chatMessageTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
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
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Not very safe code.
        let messageCell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        
        
        let message = self.messages[indexPath.row]
        
        let messageText = message["text"] as? String
        
        messageCell.textLabel?.text = messageText
        
        
        return messageCell
        
    }
    
    func onTimer(){
      // Add code to be run periodically
        let query = PFQuery(className: "Message")
        
        query.findObjectsInBackground { (messageObjects: [PFObject]?, error :Error?) in
            if let error = error {
                 print("There was trouble receving PFObjects")
            }else if let messages = messageObjects {
            
                self.messages = messages
                self.tableView.reloadData()
            }
        }
    
    }
    
    func initTimer(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer:Timer) in
            self.onTimer()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        initTimer()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
