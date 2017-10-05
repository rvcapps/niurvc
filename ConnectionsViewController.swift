//
//  ConnectionsViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 8/3/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class ConnectionsViewController: UIViewController {

    @IBOutlet weak var btnEvents: UIButton!
    
    @IBOutlet weak var btnPartners: UIButton!
    
    @IBOutlet weak var btnSocial: UIButton!
    
    @IBOutlet weak var btnInterns: UIButton!
    
    @IBOutlet weak var btnLinks: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      btnEvents.setTitle("Happenings",for: .normal)
       btnEvents.alignImageAndTitleVertically(padding: -30)
        
        btnPartners.setTitle("Partners",for: .normal)
        btnPartners.alignImageAndTitleVertically(padding: -30)
        
        btnSocial.setTitle("Social",for: .normal)
        btnSocial.alignImageAndTitleVertically(padding: -30)
        
        btnInterns.setTitle("Internships",for: .normal)
        btnInterns.alignImageAndTitleVertically(padding: -30)
        
     
        btnLinks.setTitle("Links",for: .normal)
        btnLinks.alignImageAndTitleVertically(padding: -30)
        
        
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "Happenings"
        {
            if let destinationVC = segue.destination as? SubTabBarController {
                destinationVC.pagetodisplay = 0
            }
        }
        if segue.identifier == "Partners"
        {
            if let destinationVC = segue.destination as? SubTabBarController {
                destinationVC.pagetodisplay = 1
            }
        }
        if segue.identifier == "SocialMedia"
        {
            if let destinationVC = segue.destination as? SubTabBarController {
                destinationVC.pagetodisplay = 5
            }
        }
        if segue.identifier == "JobInternship"
        {
            if let destinationVC = segue.destination as? SubTabBarController {
                destinationVC.pagetodisplay = 2
            }
        }
        if segue.identifier == "Scholarships"
        {
            if let destinationVC = segue.destination as? SubTabBarController {
                destinationVC.pagetodisplay = 3
            }
        }
        if segue.identifier == "ImportantLinks"
        {
            if let destinationVC = segue.destination as? SubTabBarController {
                destinationVC.pagetodisplay = 4
            }
        }
    }
    
    
}
extension UIButton {
    
    func alignImageAndTitleVertically(padding: CGFloat = 0.0) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
    
}

