//
//  FirstViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 8/3/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate {
//http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/home.cfm
    var refreshController = UIRefreshControl()
    var countweb:integer_t!
    var sv:UIView!
    @IBOutlet weak var web: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        web.delegate = self
        addPullToRefreshToWebView()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            web.isHidden = true
            countweb=0;
            loadwb()
        }else{
             UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
      
    }
    func loadwb()
    {
        if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/home.cfm") {
            sv = UIViewController.displaySpinner(onView: self.view)
            web.scalesPageToFit = true
            web.contentMode = .scaleAspectFit
            let request = URLRequest(url: url)
            web.loadRequest(request)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func cleanweb(){
        web.isHidden = false
        UIViewController.removeSpinner(spinner: sv)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.delegate = self
        if webView.isLoading{
            let ls = "$(document).ready(function() { $('#header').hide(); $('#footer').hide();$('#cs_entrance_small').hide();$('#cs_entrance').hide();$('#cs_entrance_menu').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
            webView.stringByEvaluatingJavaScript(from: ls)
            return
        }else
        {
            print("finished loading web")
            let script = "$('html, body').animate({scrollTop:0}, 'slow')"
            webView.stringByEvaluatingJavaScript(from: script)
            webView.scrollView.scrollsToTop = true
            // webView.isHidden = false
            _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.cleanweb), userInfo: nil, repeats: false)
        }
    }

    func addPullToRefreshToWebView(){
       
            refreshController = UIRefreshControl()
            refreshController.bounds = CGRect(x:0, y:0, width:refreshController.bounds.size.width, height:refreshController.bounds.size.height) // Change position of refresh view
            refreshController.addTarget(self, action: #selector(refreshWebView(refresh:)), for: UIControlEvents.valueChanged)
            refreshController.attributedTitle = NSAttributedString(string: "Pull down to refresh...")
            web.scrollView.addSubview(refreshController)
       
    }
    
    @objc func refreshWebView(refresh:UIRefreshControl){
        if Reachability.isConnectedToNetwork(){
            web.isHidden = true
            sv = UIViewController.displaySpinner(onView: self.view)
            web.reload()
            refresh.endRefreshing()
        }else{
           UIAlertView.MsgBox("Internet Connection Required, Swipe down on browser to try again")
         refresh.endRefreshing()
        }
    }
}

