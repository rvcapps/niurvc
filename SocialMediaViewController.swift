//
//  SocialMediaViewController.swift
//  NIURVC
//
//  Created by Jesus Quezada on 9/9/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class SocialMediaViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate {
     var refreshController = UIRefreshControl()
    
    @IBOutlet weak var btnSocial: UIButton!
    
    @IBAction func btnFacebook(_ sender: UIButton) {
        UIApplication.tryURL(urls: [
            "fb://profile/265763433886265", // App
            "http://www.facebook.com/265763433886265" // Website if app fails
            ])
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnSocial(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork(){
            SocialMediaWebView.isHidden = true
            countweb=0;
            loadwb()
            fb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    
    @IBOutlet weak var SocialMediaWebView: UIWebView!
    
    var countweb:integer_t!
    var sv:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSocial.setTitle("Social",for: .normal)
        btnSocial.alignImageAndTitleVertically(padding: 18)
        SocialMediaWebView.delegate = self
        addPullToRefreshToWebView()
        // Do any additional setup after loading the view.
    }
    @objc func webload(){
        print("webload: \(SocialMediaWebView.stringByEvaluatingJavaScript(from: "window.location.href")!)")
    }
    func fb(){
        if UIApplication.shared.canOpenURL(NSURL(string: "fb://")! as URL) {
            // Facebook app is installed
        }else
        {
            UIAlertView.MsgBox("Facebook app needs installed to view NIU&RVC Facebook page")
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
       
        if Reachability.isConnectedToNetwork(){
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(webload))
            tap.delegate = self
            SocialMediaWebView.addGestureRecognizer(tap)
            SocialMediaWebView.isHidden = true
            countweb=0;
            loadwb()
            fb()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    func loadwb()
    {
        sv = UIViewController.displaySpinner(onView: self.view)
        if let url = URL(string: "http://rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/social.cfm") {
            SocialMediaWebView.scalesPageToFit = true
            SocialMediaWebView.contentMode = .scaleAspectFit
            let request = URLRequest(url: url)
            SocialMediaWebView.loadRequest(request)
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
//        SocialMediaWebView.isHidden = true
        print("old \(SocialMediaWebView.stringByEvaluatingJavaScript(from: "window.location.href")!)")
    }
    @objc func cleanweb(){
        let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();$('#navbar-static-top').hide();$('#navbar-fixed-top').hide();$('#navbar-fixed-bottom').hide();$('#cs_control_158876').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
        SocialMediaWebView.stringByEvaluatingJavaScript(from: ls)
//        let script = "$('body').animate({scrollTop:0}, 'slow')"
//        SocialMediaWebView.stringByEvaluatingJavaScript(from: script)
        let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
        SocialMediaWebView.stringByEvaluatingJavaScript(from: tops)
        print("cleanweb")
        SocialMediaWebView.isHidden = false
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
            SocialMediaWebView.scrollView.addSubview(refreshController)
       
    }
    
    @objc func refreshWebView(refresh:UIRefreshControl){
        if Reachability.isConnectedToNetwork(){
            SocialMediaWebView.isHidden = true
            sv = UIViewController.displaySpinner(onView: self.view)
            SocialMediaWebView.reload()
            refresh.endRefreshing()
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Swipe down on browser to try again")
            refresh.endRefreshing()
        }
    }
}
extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(NSURL(string: url)! as URL) {
                application.openURL(NSURL(string: url)! as URL)
                return
            }
        }
    }
}

