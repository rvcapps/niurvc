//
//  CommunicateViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 8/3/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class CommunicateViewController: UIViewController {

    
    
    
    @IBOutlet weak var btnlive: UIButton!
    
    @IBOutlet weak var btnfaq: UIButton!
    
    @IBOutlet weak var btnadvisor: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnlive.setTitle("Live Chat",for: .normal)
        btnlive.alignImageAndTitleVertically(padding: 30)
        
        btnfaq.setTitle("FAQ",for: .normal)
        btnfaq.alignImageAndTitleVertically(padding: 30)
        
        btnadvisor.setTitle("Advisors",for: .normal)
        btnadvisor.alignImageAndTitleVertically(padding: 30)
       
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
