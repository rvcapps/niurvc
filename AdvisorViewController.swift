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
    
     var refreshController = UIRefreshControl()
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeNav") as! MainViewController
        newViewController.pagetodisplay = 3
        self.present(newViewController, animated: true, completion: nil)
    }
    @IBOutlet weak var nav: UINavigationBar!
    
    @IBOutlet weak var webview: UIWebView!
    
    var countweb:integer_t!
    var sv:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self
        addPullToRefreshToWebView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            webview.isHidden = true
            countweb=0;
            loadwb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    func loadwb()
    {
        sv = UIViewController.displaySpinner(onView: self.view)
        if let url = URL(string: "http://rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/advisors.cfm") {
            webview.scalesPageToFit = true
            webview.contentMode = .scaleAspectFit
            let request = URLRequest(url: url)
            webview.loadRequest(request)
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
       
    }
    @objc func hideweb(){
        webview.isHidden = false
        UIViewController.removeSpinner(spinner: sv)
    }
    @objc func cleanweb(){
        let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();$('#navbar-static-top').hide();$('#navbar-fixed-top').hide();$('#navbar-fixed-bottom').hide();$('#cs_control_158876').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
        webview.stringByEvaluatingJavaScript(from: ls)
//        let script = "$('body').animate({scrollTop:0}, 'slow')"
//        webview.stringByEvaluatingJavaScript(from: script)
        let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
        webview.stringByEvaluatingJavaScript(from: tops)
        print("cleanweb")
      _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.hideweb), userInfo: nil, repeats: false)
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
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.cleanweb), userInfo: nil, repeats: false)
        }
 }
       
    func addPullToRefreshToWebView(){
       
            refreshController = UIRefreshControl()
            refreshController.bounds = CGRect(x:0, y:0, width:refreshController.bounds.size.width, height:refreshController.bounds.size.height) // Change position of refresh view
            refreshController.addTarget(self, action: #selector(refreshWebView(refresh:)), for: UIControlEvents.valueChanged)
            refreshController.attributedTitle = NSAttributedString(string: "Pull down to refresh...")
            webview.scrollView.addSubview(refreshController)
       
    }
    
    @objc func refreshWebView(refresh:UIRefreshControl){
        if Reachability.isConnectedToNetwork(){
            webview.isHidden = true
            sv = UIViewController.displaySpinner(onView: self.view)
            webview.reload()
            refresh.endRefreshing()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Swipe down on browser to try again")
            refresh.endRefreshing()
        }
    }
}

