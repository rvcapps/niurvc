//
//  FaqViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 10/1/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit

class FaqViewController: UIViewController,UIWebViewDelegate ,UIScrollViewDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate{
 var countweb:integer_t!
    var wl:String!
    var sv:UIView!
    var refreshController = UIRefreshControl()
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HomeNav") as! MainViewController
        newViewController.pagetodisplay = 3
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         webview.delegate = self
         addPullToRefreshToWebView()
    }
    @objc func webload(){
        print("webload: \(webview .stringByEvaluatingJavaScript(from: "window.location.href")!)")
    }
    
//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
//    {
//        let docUrl = request.url!.absoluteString
//        let load = String(describing: docUrl).range(of: "some string in the url") != nil
//        print(load)
//        return true
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork(){
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(webload))
            tap.delegate = self
            webview.addGestureRecognizer(tap)
            webview.isHidden = true
            
            countweb=0;
            loadwb()
        }else{
           UIAlertView.MsgBox("Internet Connection Required, Please Try Again Later")
        }
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches , with:event)
//        if (touches.first as UITouch!) != nil {
//             //print("touchesBegan")
//             webload()
//        }
//         print("touchesBegan")
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches , with:event)
//        if (touches.first as UITouch!) != nil {
////              print("touchesEnded")
//            webload()
//        }
//         print("touchesEnded")
//    }
   
    @objc func webload2(){
        print("old2 \(webview .stringByEvaluatingJavaScript(from: "window.location.href")!)")
        print("new2 \(wl!)")
        if (wl! == webview .stringByEvaluatingJavaScript(from: "window.location.href")!){
             //webview.isHidden = false
        }else{
            webview.isHidden = true
            sv = UIViewController.displaySpinner(onView: self.view)
            print("webload")
            _ = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.cleanweb2), userInfo: nil, repeats: false)
        }
        wl = webview .stringByEvaluatingJavaScript(from: "window.location.href")!
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print("old \(webview .stringByEvaluatingJavaScript(from: "window.location.href")!)")
        print("new \(wl!)")
        if (wl! == webview .stringByEvaluatingJavaScript(from: "window.location.href")!){
            //webview.isHidden = true
            wl = webview .stringByEvaluatingJavaScript(from: "window.location.href")!
            _ = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.webload2), userInfo: nil, repeats: false)
        }else{
            webview.isHidden = true
            sv = UIViewController.displaySpinner(onView: self.view)
            print("webload")
            _ = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.cleanweb2), userInfo: nil, repeats: false)
        }
        return true
    }
    
    func loadwb()
    {
        //http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/faq.cfm
        //https://slimfaq.com/rock-valley-college
        sv = UIViewController.displaySpinner(onView: self.view)
        if let url = URL(string: "https://slimfaq.com/rock-valley-college") {
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
func removefooter()
{
    let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();})"
    webview.stringByEvaluatingJavaScript(from: ls)
    }
//document.getElementById("myDiv").style.marginTop = "50px";
    @objc func cleanweb2(){
        let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();$('* > :nth-child(3n+3)').css('margin-top', 0);})"
        webview.stringByEvaluatingJavaScript(from: ls)
        let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
        webview.stringByEvaluatingJavaScript(from: tops)
        print("cleanweb")
        _ = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.hideweb), userInfo: nil, repeats: false)
    }
    @objc func hideweb(){
         webview.isHidden = false
         UIViewController.removeSpinner(spinner: sv)
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
//           sv = UIViewController.displaySpinner(onView: self.view)
// webview.isHidden = true
    }
    @objc func cleanweb(){
     let ls = "$(document).ready(function() { $('#headline-wrapper').remove();$('#branding').remove();$('#navbar-static-top').hide();$('#navbar-fixed-top').hide();$('#navbar-fixed-bottom').hide();$('#cs_control_158876').hide();$('* > :nth-child(3n+3)').css('margin-top', 0);})"
        webview.stringByEvaluatingJavaScript(from: ls)
//        let script = "$('body').animate({scrollTop:0}, 'slow')"
//        //"$('body').margin-top({scrollTop:0}, 'slow')"
//        webview.stringByEvaluatingJavaScript(from: script)
        let tops = "document.body.style.margin='0';document.body.style.padding = '0'"
         webview.stringByEvaluatingJavaScript(from: tops)
        print("cleanweb")
        wl = "\(String(describing: webview.stringByEvaluatingJavaScript(from: "window.location.href")!))"
        print("first: \(wl!)")
           webview.isHidden = false
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
extension UIAlertView {
    class func MsgBox(_ message:String)
    {
        //Create Alert
        let alert = UIAlertView()
        alert.title = "Alert!"
        alert.message = message
        alert.addButton(withTitle: "OK")
        alert.show()
        
        
    }
}


