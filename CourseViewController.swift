//
//  CourseViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 8/3/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit


class CourseViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UIWebViewDelegate,UIScrollViewDelegate{
     var refreshController = UIRefreshControl()
    var countweb:integer_t!
    var sv:UIView!
    @IBOutlet weak var txtSelectMenu: UITextField!
    
    @IBOutlet weak var pvSelect: UIPickerView!
    
    
    @IBOutlet weak var web: UIWebView!
   
    var list = ["Getting Started", "Mechanical Engineering","Manufacturing Technology (Online)"]

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
    func loadwb()
    {
          if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/getting-started.cfm") {
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
    

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return list[row]
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         countweb=0;
        self.txtSelectMenu.text = self.list[row]
        if row == 0
        {
            web.isHidden = true
            countweb=0;
            sv = UIViewController.displaySpinner(onView: self.view)
            if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/getting-started.cfm") {
                web.scalesPageToFit = true
                web.contentMode = .scaleAspectFit
                let request = URLRequest(url: url)
                web.loadRequest(request)
            }
           
        }
        if row == 1
        {
            web.isHidden = true
            countweb=0;
            sv = UIViewController.displaySpinner(onView: self.view)
            if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/mechanicalengineering.cfm") {
                web.scalesPageToFit = true
                web.contentMode = .scaleAspectFit
                let request = URLRequest(url: url)
                web.loadRequest(request)
            }
            
        }
        if row == 2
        {
            web.isHidden = true
            countweb=0;
            sv = UIViewController.displaySpinner(onView: self.view)
            if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/manufacturingtechnology.cfm") {
                web.scalesPageToFit = true
                web.contentMode = .scaleAspectFit
                let request = URLRequest(url: url)
                web.loadRequest(request)
            }
            
        }
        self.pvSelect.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.txtSelectMenu {
           
            self.pvSelect.isHidden = false
            //if you dont want the users to se the keyboard type:
           textField.resignFirstResponder()
            textField.endEditing(true)
        }
        
    }
    @objc func cleanweb(){
        let ls = "$(document).ready(function() { $('.powered-by').hide();$('.toggle-options').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
        web.stringByEvaluatingJavaScript(from: ls)
        UIViewController.removeSpinner(spinner: sv)
        let script = "$('html, body').animate({scrollTop:0}, 'slow')"
        web.stringByEvaluatingJavaScript(from: script)
           web.isHidden = false
        print("cleanweb")
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.isLoading{
            webView.delegate = self
            // $('.powered-by').hide();
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
   
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
       // web.isHidden = false
       // UIViewController.removeSpinner(spinner: sv)
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
