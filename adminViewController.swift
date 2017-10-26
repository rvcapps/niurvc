//
//  adminViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 10/25/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit
import Parse

class adminViewController: UIViewController {

    @IBOutlet weak var txtoutput: UITextField!
    
    @IBOutlet weak var btnsend: UIButton!
    
    @IBAction func btnsend(_ sender: UIButton) {
        // Create our Installation query
         txtoutput.resignFirstResponder()
        let data = [
            "alert" : txtoutput.text,
            "sounds" : "cheering.caf"
            ] as [String : Any]
        let push = PFPush()
        push.setChannels(["niurvc"])
        push.setData(data)
        push.sendInBackground()
       btnsend.setTitle("Message Sent", for: .normal)
         _ = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.reset), userInfo: nil, repeats: false)
    }
    
    func reset(){
          btnsend.setTitle("Send", for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        txtoutput.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
