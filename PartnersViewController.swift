//
//  PartnersViewController.swift
//  NIURVC
//
//  Created by Jesus Quezada on 9/9/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class PartnersViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate {
     var refreshController = UIRefreshControl()
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnPartners(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            PartnersWebView.isHidden = true
            countweb=0;
            loadwb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    
    @IBOutlet weak var PartnersWebView: UIWebView!
    
    
    var countweb:integer_t!
    var sv:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PartnersWebView.delegate = self
        addPullToRefreshToWebView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
        if Reachability.isConnectedToNetwork(){
            PartnersWebView.isHidden = true
            countweb=0;
            loadwb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    func loadwb()
    {
        sv = UIViewController.displaySpinner(onView: self.view)
        if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/partners.cfm") {
            PartnersWebView.scalesPageToFit = true
            PartnersWebView.contentMode = .scaleAspectFit
            let request = URLRequest(url: url)
            PartnersWebView.loadRequest(request)
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
    func webViewDidStartLoad(_ webView: UIWebView) {
//           sv = UIViewController.displaySpinner(onView: self.view)
//        PartnersWebView.isHidden = true
    }
    @objc func cleanweb(){
        let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();$('#navbar-static-top').hide();$('#navbar-fixed-top').hide();$('#navbar-fixed-bottom').hide();$('#cs_control_158876').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
        PartnersWebView.stringByEvaluatingJavaScript(from: ls)
        let script = "$('body').animate({scrollTop:0}, 'slow')"
        PartnersWebView.stringByEvaluatingJavaScript(from: script)
        let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
        PartnersWebView.stringByEvaluatingJavaScript(from: tops)
        print("cleanweb")
        PartnersWebView.isHidden = false
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
            webView.scrollView.scrollsToTop = true
            print("else webViewDidFinishLoad")
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.cleanweb), userInfo: nil, repeats: false)
        }
    }
    
    func addPullToRefreshToWebView(){
    
            refreshController = UIRefreshControl()
            refreshController.bounds = CGRect(x:0, y:0, width:refreshController.bounds.size.width, height:refreshController.bounds.size.height) // Change position of refresh view
            refreshController.addTarget(self, action: #selector(refreshWebView(refresh:)), for: UIControlEvents.valueChanged)
            refreshController.attributedTitle = NSAttributedString(string: "Pull down to refresh...")
            PartnersWebView.scrollView.addSubview(refreshController)
       
    }
    @objc func refreshWebView(refresh:UIRefreshControl){
        if Reachability.isConnectedToNetwork(){
            PartnersWebView.isHidden = true
            sv = UIViewController.displaySpinner(onView: self.view)
            PartnersWebView.reload()
            refresh.endRefreshing()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Swipe down on browser to try again")
            refresh.endRefreshing()
        }
    }
}


