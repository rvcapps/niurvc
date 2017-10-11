//
//  ImportantLinksViewController.swift
//  NIURVC
//
//  Created by Jesus Quezada on 9/9/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//


import UIKit

class ImportantLinksViewController: UIViewController ,UIWebViewDelegate,UIScrollViewDelegate{
     var refreshController = UIRefreshControl()
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnLinks(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            ImportantLinksWebView.isHidden = true
            countweb=0;
            loadwb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    
    
    @IBOutlet weak var ImportantLinksWebView: UIWebView!
    
    
    var countweb:integer_t!
    var sv:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImportantLinksWebView.delegate = self
        addPullToRefreshToWebView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            ImportantLinksWebView.isHidden = true
            countweb=0;
            loadwb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    func loadwb()
    {
        sv = UIViewController.displaySpinner(onView: self.view)
        if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/links.cfm") {
            ImportantLinksWebView.scalesPageToFit = true
            ImportantLinksWebView.contentMode = .scaleAspectFit
            let request = URLRequest(url: url)
            ImportantLinksWebView.loadRequest(request)
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
        ImportantLinksWebView.isHidden = false
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
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.cleanweb), userInfo: nil, repeats: false)
        }
    }
    
    func addPullToRefreshToWebView(){
       
            refreshController = UIRefreshControl()
            refreshController.bounds = CGRect(x:0, y:0, width:refreshController.bounds.size.width, height:refreshController.bounds.size.height) // Change position of refresh view
            refreshController.addTarget(self, action: #selector(refreshWebView(refresh:)), for: UIControlEvents.valueChanged)
            refreshController.attributedTitle = NSAttributedString(string: "Pull down to refresh...")
            ImportantLinksWebView.scrollView.addSubview(refreshController)
       
    }
    
    @objc func refreshWebView(refresh:UIRefreshControl){
        if Reachability.isConnectedToNetwork(){
            ImportantLinksWebView.isHidden = true
            sv = UIViewController.displaySpinner(onView: self.view)
            ImportantLinksWebView.reload()
            refresh.endRefreshing()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Swipe down on browser to try again")
            refresh.endRefreshing()
        }
    }
}
