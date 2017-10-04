//
//  ChatViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 10/1/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController ,UIWebViewDelegate,UIScrollViewDelegate{
 var countweb:integer_t!
var sv:UIView!
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var web: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPullToRefreshToWebView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        web.delegate = self
        web.isHidden = true
        countweb=0;
        loadwb()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadwb()
    {
        sv = UIViewController.displaySpinner(onView: self.view)
        if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/getting-started.cfm") {
            web.scalesPageToFit = true
            web.contentMode = .scaleAspectFit
            let request = URLRequest(url: url)
            web.loadRequest(request)
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
    @objc func cleanweb(){
        web.isHidden = false
        UIViewController.removeSpinner(spinner: sv)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.isLoading{
            webView.delegate = self
            let ls = "$(document).ready(function() { $('#header').hide(); $('#footer').hide();$('#cs_entrance_small').hide();$('#cs_entrance').hide();$('#cs_entrance_menu').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
            webView.stringByEvaluatingJavaScript(from: ls)
            return
        }else
        {
            let script = "$('html, body').animate({scrollTop:0}, 'slow')"
            webView.stringByEvaluatingJavaScript(from: script)
            print("finished loading web")
            webView.scrollView.scrollsToTop = true
            // webView.isHidden = false
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.cleanweb), userInfo: nil, repeats: false)
        }
    }
    
    func addPullToRefreshToWebView(){
        let refreshController:UIRefreshControl = UIRefreshControl()
        
        refreshController.bounds = CGRect(x:0, y:0, width:refreshController.bounds.size.width, height:refreshController.bounds.size.height) // Change position of refresh view
        refreshController.addTarget(self, action: Selector(("refreshWebView:")), for: UIControlEvents.valueChanged)
        refreshController.attributedTitle = NSAttributedString(string: "Pull down to refresh...")
        web.scrollView.addSubview(refreshController)
        
    }
    
    func refreshWebView(refresh:UIRefreshControl){
        web.reload()
        refresh.endRefreshing()
    }
}
