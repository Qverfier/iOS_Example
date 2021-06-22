//
//  EnterotpViewController.swift
//  newSDK
//
//  Created by LAP314MAC on 29/09/20.
//  Copyright © 2020 LAP314MAC. All rights reserved.
//

import UIKit

@available(iOS 12.0, *)
class EnterotpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var otpmsgLbl: UILabel!
    @IBOutlet weak var otpTxtFld1: UITextField!
    @IBOutlet var otpTxtFld2: UITextField!
    @IBOutlet var otpTxtFld3: UITextField!
    @IBOutlet var otpTxtFld4: UITextField!
    
    @IBOutlet weak var codeexpiryLbl: UILabel!
    @IBOutlet var msgView: UIView!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var viewTxtField: UIView!
    
    var arrayTextOTP = NSMutableArray()
    var strPhoNumber = String()
    var strType = String()
    var strMsg = String()
    var timer = Timer()
    var counter : Int = 0
    var checkIsFrom = String()
    var strCHeckOTP = String()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.setStatusBar(backgroundColor: UIColor.init(red: 42/255, green: 90/255, blue: 244/255, alpha: 1))
        UITextField.setPloceHolderTextColor([self.otpTxtFld1 as Any,self.otpTxtFld2 as Any,self.otpTxtFld3 as Any,self.otpTxtFld4 as Any], color: UIColor.init(red: 127/255, green: 143/255, blue: 164/255, alpha: 1))
        self.otpTxtFld1.delegate = self
        self.otpTxtFld2.delegate = self
        self.otpTxtFld3.delegate = self
        self.otpTxtFld4.delegate = self

        self.otpTxtFld1.isUserInteractionEnabled = true
        
        otpTxtFld1.textContentType = .oneTimeCode
        otpTxtFld1.keyboardType = .numberPad
        
        otpTxtFld2.textContentType = .oneTimeCode
        otpTxtFld2.keyboardType = .numberPad
        
        otpTxtFld3.textContentType = .oneTimeCode
        otpTxtFld3.keyboardType = .numberPad
        
        otpTxtFld4.textContentType = .oneTimeCode
        otpTxtFld4.keyboardType = .numberPad
       
        self.btnSubmit.layer.cornerRadius = 3.0
        self.btnSubmit.layer.borderWidth = 0.6
        self.btnSubmit.layer.borderColor = UIColor.white.cgColor
        self.btnSubmit.clipsToBounds = true
        
        self.viewTxtField.layer.cornerRadius = 3.0
        self.viewTxtField.layer.borderWidth = 0.6
        self.viewTxtField.layer.borderColor = UIColor.white.cgColor
        self.viewTxtField.clipsToBounds = true
        
        
        self.otpTxtFld1.text = ""
        if self.strType == "SMS"
        {
            self.counter = 15
            self.otpmsgLbl.text = "Sending verification code by SMS."
        }
        else
        {
            self.counter = 30
            self.otpmsgLbl.text = "The code that you just received on a call."
        }
        if self.checkIsFrom != "user"
        {
            let defultD = UserDefaults.standard
            let valueCounter = defultD.object(forKey: "time") as? Int
            if valueCounter != 0 && valueCounter != nil
            {
                self.counter = valueCounter!
                let type = defultD.object(forKey: "type") as? String
                   if type == "SMS"
                  {
                      self.otpmsgLbl.text = "Sending verification code by SMS."
                  }
                  else
                  {
                      self.otpmsgLbl.text = "The code that you just received on a call."
                  }
            }
           
        }
        
        if self.strType == "SMS"
        {
            if self.strMsg == nil || self.strMsg == ""
            {
                self.callServiceFunction()
            }
            else
            {
                 self.timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
            }
        }
        else
        {
            self.callServiceFunction()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.strCHeckOTP = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
            if (string.count == 1){
            if textField == self.otpTxtFld1 {
                self.otpTxtFld2.isUserInteractionEnabled = true
                self.otpTxtFld2?.becomeFirstResponder()
                
            }
            if textField == self.otpTxtFld2 {
                self.otpTxtFld3.isUserInteractionEnabled = true
                self.otpTxtFld3?.becomeFirstResponder()
            }
            if textField == self.otpTxtFld3 {
                self.otpTxtFld4.isUserInteractionEnabled = true
                self.otpTxtFld4?.becomeFirstResponder()
            }
            if textField == self.otpTxtFld4 {
                self.otpTxtFld4.isUserInteractionEnabled = true
                self.otpTxtFld4?.resignFirstResponder()
                textField.text? = string
            }
            textField.text? = string
            return false
        }else{
            if textField == self.otpTxtFld1 {
                self.otpTxtFld1?.becomeFirstResponder()
            }
            if textField == self.otpTxtFld2 {
                self.otpTxtFld1?.becomeFirstResponder()
                self.otpTxtFld2.isUserInteractionEnabled = false

            }
            if textField == self.otpTxtFld3 {
                self.otpTxtFld2?.becomeFirstResponder()
                self.otpTxtFld3.isUserInteractionEnabled = false

            }
            if textField == self.otpTxtFld4 {
                self.otpTxtFld3?.becomeFirstResponder()
                self.otpTxtFld4.isUserInteractionEnabled = false

            }
            textField.text? = string
            return false
        }

        return true
    }
    
    
    func methedForSettingOTP(str: String)
    {
        
        if str == ""
        {
            if self.arrayTextOTP.count != 0
            {
                self.arrayTextOTP.removeLastObject()
            }
        }
        else{
            let dit = ["val" : (str + "   ")]
            self.arrayTextOTP.add(dit)
        }
        
        var finalSTr = String()
        for dataSTr in self.arrayTextOTP{
            let dict = dataSTr as? NSDictionary
            let chl = dict?.object(forKey: "val") as? String
            finalSTr = finalSTr + chl!
        }
        
        self.otpTxtFld1.text = ""
        self.otpTxtFld1.text = finalSTr
    }
    
    @objc func updateCounter() {
        
        var msgCheck = String()
        
        if self.strType == "SMS"
        {
            msgCheck = "Not verified by SMS"
        }
        else
        {
            msgCheck = "Not verified by voice OTP"
        }
        
        if self.checkIsFrom != "user"
        {
            let defultD = UserDefaults.standard
            let type = defultD.object(forKey: "type") as? String
            let valueCounter = defultD.object(forKey: "time") as? Int
            if valueCounter != 0
            {
                if type == "SMS"
                {
                    msgCheck = "Not verified by SMS"
                }
                else
                {
                    msgCheck = "Not verified by voice OTP"
                }
            }
        }
        
        let defultD = UserDefaults.standard
        let appD = UIApplication.shared.delegate as? AppDelegate
           if self.checkIsFrom != "user"
           {
               defultD.set(counter, forKey: "time")
               defultD.set(self.strType, forKey: "type")
               defultD.synchronize()
           }
        
            if counter > 0 {
                   print("\(counter) seconds to the end of the world")
                self.codeexpiryLbl.text = "Code Expire in : " + "\(counter) sec"
                   counter -= 1
               }
            else
               {
                timer.invalidate()
                self.view.endEditing(true)
                self.showToast(message: msgCheck)
               
            }
        }
    
    func showToast(message : String) {
        if self.strType == "SMS"
        {
            if self.checkIsFrom != "user"
            {
                
                self.msgView.isHidden = false
               let seconds = 1.0
               DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.msgView.isHidden = true

                   let appD = UIApplication.shared.delegate as? AppDelegate
                      appD?.strT = "SMS"
                    let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "EnterotpViewController")as! EnterotpViewController)
                     homeVC.strPhoNumber = appD!.phonenumber
                     homeVC.strType = "VOICE_OTP"
                     self.navigationController?.pushViewController(homeVC, animated: true)
               }
            }
            else
            {
                self.timer.invalidate()
                self.msgView.isHidden = false
                let seconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                 self.msgView.isHidden = true
                    let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "FailVC")as! FailVC)
                    homeVC.strIsfrom = "sdk"
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
           
        }
        else
        {
            self.timer.invalidate()
            self.msgView.isHidden = true
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
             self.msgView.isHidden = true

                  let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "FailVC")as! FailVC)
                    homeVC.strIsfrom = "sdk"
                    self.navigationController?.pushViewController(homeVC, animated: true)
            }
            
          
        
       }

        
        return
        
        
    }
    
    
    @IBAction func nextClk2(_ sender: Any) {
        //timer.invalidate()
        let finalStr = self.otpTxtFld1.text! + self.otpTxtFld2.text! + self.otpTxtFld3.text! + self.otpTxtFld4.text!
        if finalStr == self.strMsg
        {
            self.timer.invalidate()

           let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "CongratulationsViewController")as! CongratulationsViewController)
            self.navigationController?.pushViewController(homeVC, animated: true)
                   
        }
        else
        {
           // self.view.endEditing(true)
            let alert = UIAlertController(title: "", message: "OTP Invalid", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
       
    }
    
    func callServiceFunction()
    {
        
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.backgroundColor = UIColor.white
        indicator.center = CGPoint(x: self.view.frame.size.width / 2.0, y: self.view.frame.size.height / 2.0)

        let loadingTextLabel = UILabel()
        loadingTextLabel.textColor = UIColor.black
        loadingTextLabel.text = "LOADING"
        loadingTextLabel.font = UIFont(name: "Avenir Light", size: 10)
        loadingTextLabel.sizeToFit()
        indicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadingTextLabel.center = CGPoint(x: indicator.frame.size.width / 2.0, y: indicator.center.y + 30)

        indicator.center = view.center
        indicator.addSubview(loadingTextLabel)
        self.view.addSubview(indicator)
        self.view.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        indicator.startAnimating()

        let appD = UIApplication.shared.delegate as? AppDelegate
        let params = ["appKey":"25MrTcpMMVaiWG9t", "secretKey":"lWbF6jNkG8PE0AUP","phoneNumber":appD?.phonenumber,"actionType" : self.strType,"deviceId" : "123456"] as! Dictionary<String, String>

        var request = URLRequest(url: URL(string: "http://112.196.109.70:8171/rv/api/ringverifier/process")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)

            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
                DispatchQueue.main.async { [unowned self] in
                    indicator.stopAnimating()
                    self.timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
                    let dictRest = json as? NSDictionary
                    let msg = dictRest?.object(forKey: "message") as? String
                    let status = dictRest?.object(forKey: "status") as? String
                    
                        if status == "Failure"
                        {
                            let alert = UIAlertController(title: "Error", message: "Invalid Action", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
                                self.navigationController?.popToRootViewController(animated: true)
                             }))
                             self.present(alert, animated: true, completion: nil)
                        }
                    else
                        {
                            self.strMsg = msg!
                    }

                }
               
            } catch {
                print("error")
            }
        })

        task.resume()
    }
}
