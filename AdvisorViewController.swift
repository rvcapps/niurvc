//
//  AdvisorViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 10/1/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit
import WebKit

class AdvisorViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate {
 var countweb:integer_t!
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var nav: UINavigationBar!
    
    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
         addPullToRefreshToWebView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        webview.delegate = self
        countweb=0;
        loadwb()
   }
    func loadwb()
    {
        if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/getting-started.cfm") {
              webview.isHidden = true
            let request = URLRequest(url: url)
            webview.loadRequest(request)
          // webview.reload()
        }
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
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.delegate = self
        //after code when webview finishes
        let ls = "$(document).ready(function() { $('#header').hide(); $('#footer').hide();$('#cs_entrance_small').hide();$('#cs_entrance').hide();$('#cs_entrance_menu').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
        
        webview.stringByEvaluatingJavaScript(from: ls)
        
        //  print("run")
        if countweb==0{
            countweb=1;
             webview.reload()
        }
        if webView.isLoading{
            return
        }else
        {
            webview.isHidden = false
        }
 }
       
    func addPullToRefreshToWebView(){
        let refreshController:UIRefreshControl = UIRefreshControl()
        
        refreshController.bounds = CGRect(x:0, y:0, width:refreshController.bounds.size.width, height:refreshController.bounds.size.height) // Change position of refresh view
        refreshController.addTarget(self, action: Selector(("refreshWebView:")), for: UIControlEvents.valueChanged)
        refreshController.attributedTitle = NSAttributedString(string: "Pull down to refresh...")
        webview.scrollView.addSubview(refreshController)
        
    }
        
    func refreshWebView(refresh:UIRefreshControl){
        webview.reload()
        refresh.endRefreshing()
    }
}

