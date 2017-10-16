//
//  ChatViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 10/1/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController ,UIWebViewDelegate,UIScrollViewDelegate{
    
 var refreshController = UIRefreshControl()
    
 var countweb:integer_t!
var sv:UIView!
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var web: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        web.delegate = self
        addPullToRefreshToWebView()
        // Do any additional setup after loading the view.
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadwb()
    {
        sv = UIViewController.displaySpinner(onView: self.view)
        if let url = URL(string: "https://konkolchat.herokuapp.com/livechat?mode=popout") {
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
    func webViewDidStartLoad(_ webView: UIWebView) {
//        web.isHidden = true
    }
    @objc func cleanweb(){
//        let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();$('#navbar-static-top').hide();$('#navbar-fixed-top').hide();$('#navbar-fixed-bottom').hide();$('.new-message.not').hide();$('.options-menu').hide();$('.powered-by').hide();$('#cs_control_158876').hide();$('* > :nth-child(3n+3)').css('margin-top', 0);})"
          let ls = "$(document).ready(function() { $('.new-message.not').hide();$('.options-menu').hide();$('.powered-by').hide();})"
        web.stringByEvaluatingJavaScript(from: ls)
//        let script = "$('body').animate({scrollTop:0}, 'slow')"
//        web.stringByEvaluatingJavaScript(from: script)
        let tops = "document.body.style.margin='0';document.body.style.padding = '5'"
        web.stringByEvaluatingJavaScript(from: tops)
        print("cleanweb")
         web.scalesPageToFit = true
        web.isHidden = false
        //.new-message.not .livechat-room .messages .new-message.not
        //.options-menu  .powered-by
        UIViewController.removeSpinner(spinner: sv)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.isLoading{
            print("webViewDidFinishLoad")
            let ls = "$(document).ready(function() { $('.new-message.not').hide();$('.options-menu').hide();$('.powered-by').hide();})"
            webView.stringByEvaluatingJavaScript(from: ls)
            let tops = "document.body.style.margin='0';document.body.style.padding = '5'"
            webView.stringByEvaluatingJavaScript(from: tops)
            return
        }else
        {
            webView.scrollView.scrollsToTop = true
            print("else webViewDidFinishLoad")
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.cleanweb), userInfo: nil, repeats: true)
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
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
         refresh.endRefreshing()
        }
    }
}
