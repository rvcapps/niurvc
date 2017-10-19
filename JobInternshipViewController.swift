//
//  JobIntershipViewController.swift
//  NIURVC
//
//  Created by Jesus Quezada on 9/9/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class JobInternshipViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate{
    
    @IBOutlet weak var btnjobs: UIButton!
    
    
    @IBAction func btnrefresh(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            JobInternshipWebView.isHidden = true
            countweb=0;
            loadwb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    
    @IBAction func btnJobs(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            JobInternshipWebView.isHidden = true
            countweb=0;
            loadwb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    
    
    
    
     var refreshController = UIRefreshControl()
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    @IBOutlet weak var JobInternshipWebView: UIWebView!
    
    
    var countweb:integer_t!
    var sv:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnjobs.setTitle("Job Search",for: .normal)
        btnjobs.alignImageAndTitleVertically(padding: 5)
        JobInternshipWebView.delegate = self
        addPullToRefreshToWebView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            JobInternshipWebView.isHidden = true
            countweb=0;
            loadwb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    func loadwb()
    {
        if let url = URL(string: "http://myjobs.ckonkol.com/") {
             sv = UIViewController.displaySpinner(onView: self.view)
            JobInternshipWebView.scalesPageToFit = true
            JobInternshipWebView.contentMode = .scaleAspectFit
            let request = URLRequest(url: url)
            JobInternshipWebView.loadRequest(request)
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
    @objc func cleanweb(){
        let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();$('.navbar-static-top').hide();$('.navbar-fixed-top').hide();$('.navbar-fixed-bottom').hide();$('.job-rss').hide();$('.well').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
        JobInternshipWebView.stringByEvaluatingJavaScript(from: ls)
        let script = "$('body').animate({scrollTop:0}, 'slow')"
        //"$('body').margin-top({scrollTop:0}, 'slow')"
        JobInternshipWebView.stringByEvaluatingJavaScript(from: script)
        let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
        JobInternshipWebView.stringByEvaluatingJavaScript(from: tops)
        print("cleanweb")
        JobInternshipWebView.isHidden = false
        UIViewController.removeSpinner(spinner: sv)
        //.navbar-static-top, .navbar-fixed-top, .navbar-fixed-bottom, .well, .job-rss
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
//         sv = UIViewController.displaySpinner(onView: self.view)
 //       JobInternshipWebView.isHidden = true
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.isLoading{
            print("webViewDidFinishLoad")
            let ls = "$(document).ready(function() { $('#header').hide(); $('#footer').hide();$('#cs_entrance_small').hide();$('#cs_entrance').hide();$('#cs_entrance_menu').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
            webView.stringByEvaluatingJavaScript(from: ls)
            let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
            webView.stringByEvaluatingJavaScript(from: tops)
            return
        }else
        {
            webView.scrollView.scrollsToTop = true
            print("else webViewDidFinishLoad")
            _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.cleanweb), userInfo: nil, repeats: false)
        }
    }
    
    func addPullToRefreshToWebView(){
     
            refreshController = UIRefreshControl()
            refreshController.bounds = CGRect(x:0, y:0, width:refreshController.bounds.size.width, height:refreshController.bounds.size.height) // Change position of refresh view
            refreshController.addTarget(self, action: #selector(refreshWebView(refresh:)), for: UIControlEvents.valueChanged)
            refreshController.attributedTitle = NSAttributedString(string: "Pull down to refresh...")
            JobInternshipWebView.scrollView.addSubview(refreshController)
       
    }
    
    @objc func refreshWebView(refresh:UIRefreshControl){
        if Reachability.isConnectedToNetwork(){
            JobInternshipWebView.isHidden = true
            sv = UIViewController.displaySpinner(onView: self.view)
            JobInternshipWebView.reload()
            refresh.endRefreshing()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Swipe down on browser to try again")
            refresh.endRefreshing()
        }
    }
}

