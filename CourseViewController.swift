//
//  CourseViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 8/3/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit


class CourseViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UIWebViewDelegate,UIScrollViewDelegate{
    var countweb:integer_t!
    @IBOutlet weak var txtSelectMenu: UITextField!
    
    @IBOutlet weak var pvSelect: UIPickerView!
    
    
    @IBOutlet weak var web: UIWebView!
   
    var list = ["Select below","Getting Started", "Mechanical Engineering","Manufacturing Technology"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPullToRefreshToWebView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        web.delegate = self
        countweb=0;
        loadwb()
    }
    func loadwb()
    {
        if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/getting-started.cfm") {
            let request = URLRequest(url: url)
            web.loadRequest(request)
            web.reload()
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
        if row == 1
        {
            //web.loadRequest(URLRequest(url: URL(string: "http://google.com")!))
            web.delegate = self
            if let url = URL(string: "http://author.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/m/getting-started.cfm") {
                let request = URLRequest(url: url)
                web.loadRequest(request)
            }
           
        }
        if row == 2
        {
            //web.loadRequest(URLRequest(url: URL(string: "http://google.com")!))
            web.delegate = self
            if let url = URL(string: "https://www.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/index.cfm#cs_control_168893") {
                let request = URLRequest(url: url)
                web.loadRequest(request)
            }
            
        }
        if row == 3
        {
            //web.loadRequest(URLRequest(url: URL(string: "http://google.com")!))
            web.delegate = self
            if let url = URL(string: "https://www.rockvalleycollege.edu/Courses/Programs/Engineering/NIU/index.cfm#cs_control_168893") {
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
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.delegate = self
        //after code when webview finishes
        let ls = "$(document).ready(function() { $('#header').hide(); $('#footer').hide();$('#cs_entrance_small').hide();$('#cs_entrance').hide();$('#cs_entrance_menu').hide();$('* > :nth-child(3n+3)').css('margin-top', 20);})"
        
        web.stringByEvaluatingJavaScript(from: ls)
        
        //  print("run")
        if countweb==0{
            countweb=1;
            web.reload()
        }
        
    }
    
    func addPullToRefreshToWebView(){
        let refreshController:UIRefreshControl = UIRefreshControl()
        
        refreshController.bounds = CGRect(x:0, y:50, width:refreshController.bounds.size.width, height:refreshController.bounds.size.height) // Change position of refresh view
        refreshController.addTarget(self, action: Selector(("refreshWebView:")), for: UIControlEvents.valueChanged)
        refreshController.attributedTitle = NSAttributedString(string: "Pull down to refresh...")
        web.scrollView.addSubview(refreshController)
        
    }
    
    func refreshWebView(refresh:UIRefreshControl){
        web.reload()
        refresh.endRefreshing()
    }
}
