//
//  NotificationsViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 10/21/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate {

    @IBOutlet weak var displayit: UILabel!
    
    
    @IBOutlet weak var btnadmin: UIButton!
    
    @IBAction func btnadmin(_ sender: UIButton) {
    }
    
   
    
    @IBAction func btnMain(_ sender: UIBarButtonItem) {
      
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeNav") as! MainViewController
        newViewController.pagetodisplay = 3
        self.present(newViewController, animated: true, completion: nil)

    }
    var refreshController = UIRefreshControl()
    
   
    
  
    
    
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
      _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.OutPutButton), userInfo: nil, repeats: false)
    }
    
    func OutPutButton(){
        let username = UIDevice.current.name
        print("username \(username)")
        displayit.text = username
        // username = "Charles's iPhone"
        if (username == "Charles's iPhone")
        {
            btnadmin.isHidden = false
        }else{
            btnadmin.isHidden = true
        }
    }
    
    func loadwb()
    {
       
        if let url = URL(string: "http://www.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/notifications.cfm") {
             sv = UIViewController.displaySpinner(onView: self.view)
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
    func webViewDidStartLoad(_ webView: UIWebView) {
        //        ImportantLinksWebView.isHidden = true
    }
    @objc func cleanweb(){
        
        let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();$('#navbar-static-top').hide();$('#navbar-fixed-top').hide();$('#navbar-fixed-bottom').hide();$('#cs_control_158876').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
        ImportantLinksWebView.stringByEvaluatingJavaScript(from: ls)
        //        let script = "$('body').animate({scrollTop:0}, 'slow')"
        //        ImportantLinksWebView.stringByEvaluatingJavaScript(from: script)
        let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
        ImportantLinksWebView.stringByEvaluatingJavaScript(from: tops)
        print("cleanweb")
        ImportantLinksWebView.isHidden = false
        UIViewController.removeSpinner(spinner: sv)
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
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        switch navigationType {
        case .linkClicked:
            // Open links in Safari
            guard let url = request.url else { return true }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // openURL(_:) is deprecated in iOS 10+.
                UIApplication.shared.openURL(url)
            }
            return false
        default:
            // Handle other navigation types...
            return true
        }
    }
}
