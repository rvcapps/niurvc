//
//  VideoViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 8/3/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController,UIWebViewDelegate {
    
    
    @IBOutlet weak var webview: UIWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        //
        webview.delegate = self
        if let url = URL(string: "https://sites.google.com/site/niurvc/video") {
            let request = URLRequest(url: url)
            webview.loadRequest(request)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
