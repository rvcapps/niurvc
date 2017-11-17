//
//  VideoViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 8/3/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController,UIWebViewDelegate ,UIScrollViewDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate{
     var refreshController = UIRefreshControl()
    
    var wl:String!
    
    @objc func webload(){
        print("webload: \(webview .stringByEvaluatingJavaScript(from: "window.location.href")!)")
       // webview.isHidden = true
       //  sv = UIViewController.displaySpinner(onView: self.view)
       //    _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: ////#selector(self.hideweb), userInfo: nil, repeats: false)
    }
    @IBAction func btnPhotos(_ sender: UIBarButtonItem) {
        if Reachability.isConnectedToNetwork(){
            webview.isHidden = true
            countweb=0;
            loadwb()
             _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.cleanweb2), userInfo: nil, repeats: false)
        }else{
            UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
    
    
    var countweb:integer_t!
    var sv:UIView!
     @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(webload))
        tap.delegate = self
        webview.addGestureRecognizer(tap)
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
        if let url = URL(string: "http://rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/media.cfm") {
            sv = UIViewController.displaySpinner(onView: self.view)
            webview.scalesPageToFit = true
            webview.contentMode = .scaleAspectFit
            let request = URLRequest(url: url)
            webview.loadRequest(request)
        }
    }
    
    @objc func webload2(){
        print("old2 \(webview .stringByEvaluatingJavaScript(from: "window.location.href")!)")
        print("new2 \(wl!)")
//        wl = webview .stringByEvaluatingJavaScript(from: "window.location.href")!
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print("gesture")
   return true
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
        let ls = "$(document).ready(function() { $('#header').hide(); $('#footer').hide();$('#cs_entrance_small').hide();$('#cs_entrance').hide();$('#cs_entrance_menu').hide();$('* > :nth-child(3n+3)').css('margin-top', 0);$('#cs_control_158876').hide();$('* > :nth-child(3n+3)').css('margin-top', 0);})"
        webView.stringByEvaluatingJavaScript(from: ls)
        let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
        webview.stringByEvaluatingJavaScript(from: tops)
    }
    @objc func cleanweb2(){
        let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();$('#navbar-static-top').hide();$('#navbar-fixed-top').hide();$('#navbar-fixed-bottom').hide();$('#cs_control_158876').hide();$('* > :nth-child(3n+3)').css('margin-top', 0);})"
        webview.stringByEvaluatingJavaScript(from: ls)
       // let script = "$('body').animate({scrollTop:0}, 'slow')"
        //"$('body').margin-top({scrollTop:0}, 'slow')"
        //webview.stringByEvaluatingJavaScript(from: script)
        let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
        webview.stringByEvaluatingJavaScript(from: tops)
        print("cleanweb")
        _ = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.hideweb), userInfo: nil, repeats: false)
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
            let ls = "$(document).ready(function() { $('#header').hide(); $('#footer').hide();$('#cs_entrance_small').hide();$('#cs_entrance').hide();$('#cs_entrance_menu').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);$('#cs_control_162871').hide();})"
            webView.stringByEvaluatingJavaScript(from: ls)
            let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
            webView.stringByEvaluatingJavaScript(from: tops)
            return
        }else
        {
            webView.scrollView.scrollsToTop = true
            print("else webViewDidFinishLoad")
            _ = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.cleanweb), userInfo: nil, repeats: false)
        }
      
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//        webview.isHidden = false
//        UIViewController.removeSpinner(spinner: sv)
     
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
extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        let txtField: UITextField = UITextField(frame: CGRect(x: ai.frame.origin.x - 60, y: ai.frame.origin.y, width: 300.00, height: 30.00));
        txtField.isEnabled = false
        txtField.textColor = UIColor.blue
        txtField.text = "Loading Innovation..."
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            spinnerView.addSubview(txtField)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

