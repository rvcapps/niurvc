//
//  CourseViewController.swift
//  NIURVC
//
//  Created by Charles Konkol on 8/3/17.
//  Copyright © 2017 Charles Konkol. All rights reserved.
//

import UIKit


class CourseViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,UIWebViewDelegate{
    
    @IBOutlet weak var txtSelectMenu: UITextField!
    
    @IBOutlet weak var pvSelect: UIPickerView!
    
    
    @IBOutlet weak var web: UIWebView!
   
    var list = ["Select below","Getting Started", "Mechanical Engineering","Manufacturing Technology"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        self.txtSelectMenu.text = self.list[row]
        if row == 1
        {
            //web.loadRequest(URLRequest(url: URL(string: "http://google.com")!))
            web.delegate = self
            if let url = URL(string: "https://www.rockvalleycollege.edu/Courses/Programs/Engineering/Request-Information.cfm") {
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
            
            textField.endEditing(true)
        }
        
    }

}
