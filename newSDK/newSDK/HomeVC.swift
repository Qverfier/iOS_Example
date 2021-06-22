//
//  HomeVC.swift
//  newSDK
//
//  Created by LAP314MAC on 29/09/20.
//  Copyright © 2020 LAP314MAC. All rights reserved.
//

import UIKit
import Qverifier

@available(iOS 12.0, *)
@available(iOS 12.0, *)
@available(iOS 12.0, *)
class HomeVC: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    
    var checkIsFrom = String()
    @IBOutlet var lblInvalidOtp: UILabel!
    @IBOutlet var extraView: UIView!
    @IBOutlet var txtFieldPhNumber: UITextField!
    @IBOutlet var lblError: UILabel!
    @IBOutlet var responceView: UIView!
    @IBOutlet var lblSucess: UILabel!
    @IBOutlet var lblFail: UILabel!
    @IBOutlet var otpView: UIView!
    @IBOutlet var lblTimer: UILabel!
    @IBOutlet var txtFieldOTP1: UITextField!
    @IBOutlet var txtFieldOTP2: UITextField!
    @IBOutlet var txtFieldOTP3: UITextField!
    @IBOutlet var txtFieldOTP4: UITextField!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var countryImgr: UIImageView!
    @IBOutlet weak var lblImgCountry: UIButton!
    
    @IBOutlet var viewOtp: UIView!
    @IBOutlet var innerView: UIView!
    @IBOutlet var btnContine: UIButton!
    @IBOutlet var mobView: UIView!
    @IBOutlet var lblPleaseWait: UILabel!
    @IBOutlet var btnView: UIView!
    @IBOutlet var innerOtpView: UIView!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var btnVerify: UIButton!
    var timer = Timer()
    var counter : Int = 0
    var strOTp = String()
    var strFrom = String()
    var indicator = UIActivityIndicatorView()
    var pickerView = UIPickerView()
    var toolBar = UIToolbar()
    var arrayCOuntry = NSMutableArray()
    var selectedCode = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFieldPhNumber.delegate = self
        self.txtFieldPhNumber.clearButtonMode = .whileEditing
        let appD = UIApplication.shared.delegate as? AppDelegate
        appD?.strT = "MISSED_CALL"
        self.innerView.layer.cornerRadius = 5.0
        self.innerView.clipsToBounds = true

        self.innerOtpView.layer.cornerRadius = 5.0
        self.innerOtpView.clipsToBounds = true
        
        self.btnContine.layer.cornerRadius = 5.0
        self.btnContine.clipsToBounds = true
        
        self.btnVerify.layer.cornerRadius = 5.0
        self.btnVerify.clipsToBounds = true
        
        self.viewOtp.layer.cornerRadius = 3.0
        self.viewOtp.layer.borderWidth = 0.6
        self.viewOtp.layer.borderColor = UIColor.lightGray.cgColor
        self.viewOtp.clipsToBounds = true
        self.selectedCode = "91"
        
        
        self.mobView.layer.cornerRadius = 3.0
        self.mobView.layer.borderWidth = 0.6
        self.mobView.layer.borderColor = UIColor.init(red: 211/255, green: 223/255, blue: 237/255, alpha: 1).cgColor
        self.mobView.clipsToBounds = true
        
        
        self.btnContine.layer.cornerRadius = 3.0
        self.btnContine.layer.borderWidth = 0.6
        self.btnContine.layer.borderColor = UIColor.white.cgColor
        self.btnContine.clipsToBounds = true
        
        self.btnVerify.layer.cornerRadius = 3.0
        self.btnVerify.layer.borderWidth = 0.6
        self.btnVerify.layer.borderColor = UIColor.white.cgColor
        self.btnVerify.clipsToBounds = true
        let flag = self.getFlag(from: "IN")
        print(flag)
        self.lblImgCountry.setTitleColor(UIColor.black, for: .normal)
        self.lblImgCountry.setTitle(flag, for: .normal)
        self.callServicecForCOuntryCode()
//        var dict = ["country" : "India","flag" : self.getFlag(from: "IN"),"Code" : "+91"]
//        self.arrayCOuntry.add(dict)
//        dict = ["country" : "United State","flag" : self.getFlag(from: "US"),"Code" : "+1"]
//        self.arrayCOuntry.add(dict)
//        dict = ["country" : "United Kingdom","flag" : self.getFlag(from: "GB"),"Code" : "+44"]
//        self.arrayCOuntry.add(dict)
        
//        self.btnCountry.titleLabel!.font = UIFont(name: "AppleColorEmoji", size: CGFloat(16.0))
//        self.btnCountry.setTitleColor(UIColor.black, for: .normal)

       // self.btnCountry.setTitle(flag, for: .normal)
    //    UITextField.setPloceHolderTextColor([self.txtFieldPhNumber as Any,txtFieldOTP1 as Any,txtFieldOTP2 as Any,txtFieldOTP3 as Any,txtFieldOTP4 as Any], color: UIColor.init(red: 127/255, green: 143/255, blue: 164/255, alpha: 1))
        
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    internal func getFlag(from countryCode: String) -> String {

        return countryCode
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    @IBAction func tapSMS(_ sender: Any) {
        let appD = UIApplication.shared.delegate as? AppDelegate
        appD?.strT = "SMS"
        self.strFrom = "SMS"
        self.txtFieldOTP1.text = ""
        self.txtFieldOTP2.text = ""
        self.txtFieldOTP3.text = ""
        self.txtFieldOTP4.text = ""
        self.extraView.isHidden = false
        self.btnView.isHidden = false
    }
    
    @IBAction func tapCountryCode(_ sender: Any) {
        self.setUpPicker()
    }
    
    func setUpPicker()
    {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.backgroundColor = UIColor.white
        pickerView.setValue(UIColor.black, forKey: "textColor")
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        
                    
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
       toolBar.barStyle = UIBarStyle.default
       toolBar.isTranslucent = true
       toolBar.tintColor = UIColor.init(red: 103/255, green: 48/255, blue: 197/255, alpha: 1)
       toolBar.sizeToFit()
        self.view.addSubview(pickerView)
       let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
       
       let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
       
       let cancelButton = UIBarButtonItem(title: "Cancle", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPicker))
       
       toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
       toolBar.isUserInteractionEnabled = true
        self.view.addSubview(toolBar)

        self.pickerView.reloadAllComponents()
}
    
    @objc func donePicker() {
        self.toolBar.removeFromSuperview()
        self.pickerView.removeFromSuperview()
    }
            
    @objc func cancelPicker()
    {
        self.toolBar.removeFromSuperview()
        self.pickerView.removeFromSuperview()
    }
    
    
    //=====================================================
     // MARK: - UIPickerView delegate datasource method
     //=====================================================
     
     
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
     {
     
        return self.arrayCOuntry.count
     }
     
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          
        let dict = self.arrayCOuntry[row] as? NSDictionary
        let counryName = dict?.object(forKey: "country") as? String
        let flag = dict?.object(forKey: "flag") as? String
        let code = dict?.object(forKey: "code") as? String
        let value = flag!  + " " + counryName! + " " + code!

        return value
     }
     
     
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let dict = self.arrayCOuntry[row] as? NSDictionary
        let flag = dict?.object(forKey: "flag") as? String
        var code = dict?.object(forKey: "code") as? String
        //rself.btnCountry.setTitleColor(UIColor.black, for: .normal)
        self.btnCountryCode.setTitle(code, for: .normal)
        self.lblImgCountry.setTitle(flag, for: .normal)
        let newCode = code?.split(separator: "+")
        let ccodeValue = String(newCode![0])
        self.selectedCode = ccodeValue
        print(self.selectedCode)
     }
    
    //MARK:- UIAction Method----------
    
    @IBAction func tapVoiceCall(_ sender: Any) {
        let appD = UIApplication.shared.delegate as? AppDelegate
        appD?.strT = "VOICE_OTP"
        self.extraView.isHidden = false
        self.txtFieldOTP1.text = ""
        self.txtFieldOTP2.text = ""
        self.txtFieldOTP3.text = ""
        self.txtFieldOTP4.text = ""
        self.strFrom = "VOICE_OTP"
        self.btnView.isHidden = false
    }
    
    @IBAction func tapSubmit(_ sender: Any) {
        self.view.endEditing(true)
        self.btnView.isHidden = true
        if self.txtFieldPhNumber.text?.count == 0
        {
            self.lblError.isHidden = false
            self.lblError.text = "Mobile Number is required."
            return
        }
        
        if self.txtFieldPhNumber.text?.count != 10
        {
            self.lblError.isHidden = false
            self.lblError.text = "Invalid mobile number"
            return
        }
               
        self.extraView.isHidden = true
        self.txtFieldOTP1.text = ""
        self.txtFieldOTP2.text = ""
        self.txtFieldOTP3.text = ""
        self.txtFieldOTP4.text = ""
        self.lblError.isHidden = true
        self.view.endEditing(true)
        self.callServiceFunction()
        self.lblPhone.text = self.txtFieldPhNumber.text!

    }
    
    @IBAction func tapOTP(_ sender: Any) {
        self.view.resignFirstResponder()
        self.view.endEditing(true)
        
        let finalOTp = self.txtFieldOTP1.text! + self.txtFieldOTP2.text! + self.txtFieldOTP3.text! + self.txtFieldOTP4.text!
        
        if self.strOTp == finalOTp
        {
            timer.invalidate()
            self.extraView.isHidden = true
            self.otpView.isHidden = true
            self.responceView.isHidden = false
            self.lblError.text = "Authentication Successful"
            self.lblFail.text = ""
            self.lblInvalidOtp.isHidden = true
           let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "CongratulationsViewController")as! CongratulationsViewController)
           self.navigationController?.pushViewController(homeVC, animated: true)
        }
        else
        {
            if self.counter > 0
            {
                timer.invalidate()

                //self.lblInvalidOtp.isHidden = false
                let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "FailVC")as! FailVC)
                homeVC.strIsfrom = "User"
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
            else
            {
                timer.invalidate()
                self.lblInvalidOtp.isHidden = true
                self.extraView.isHidden = true
                self.otpView.isHidden = true
                self.responceView.isHidden = false
                self.lblError.text = "Authentication fail"
                self.lblSucess.text = ""
                let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "FailVC")as! FailVC)
                homeVC.strIsfrom = "User"
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
        }
    }
    
    
    @IBAction func tapMissedCall(_ sender: Any) {
        self.txtFieldOTP1.text = ""
        self.txtFieldOTP2.text = ""
        self.txtFieldOTP3.text = ""
        self.txtFieldOTP4.text = ""
        self.extraView.isHidden = false
        self.strFrom = "MISSED_CALL"
        self.btnView.isHidden = false
    }
    
    @IBAction func tapCross(_ sender: Any) {
        self.extraView.isHidden = true
        self.btnView.isHidden = false
        self.otpView.isHidden  = true
        self.timer.invalidate()
    }
    
    
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == self.txtFieldPhNumber {
           let charsLimit = 10

            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace

            return newLength <= charsLimit
        }
       else {
                 if (string.count == 1){
                      if textField == self.txtFieldOTP1 {
                          self.txtFieldOTP2.isUserInteractionEnabled = true
                          self.txtFieldOTP2?.becomeFirstResponder()
                          
                      }
                      if textField == self.txtFieldOTP2 {
                          self.txtFieldOTP3.isUserInteractionEnabled = true
                          self.txtFieldOTP3?.becomeFirstResponder()
                      }
                      if textField == self.txtFieldOTP3 {
                          self.txtFieldOTP4.isUserInteractionEnabled = true
                          self.txtFieldOTP4?.becomeFirstResponder()
                      }
                      if textField == self.txtFieldOTP4 {
                          self.txtFieldOTP4.isUserInteractionEnabled = true
                          self.txtFieldOTP4?.resignFirstResponder()
                          textField.text? = string
                      }
                      textField.text? = string
                      return false
                  }else{
                      if textField == self.txtFieldOTP1 {
                          self.txtFieldOTP1?.becomeFirstResponder()
                      }
                      if textField == self.txtFieldOTP2 {
                          self.txtFieldOTP1?.becomeFirstResponder()
                          self.txtFieldOTP2.isUserInteractionEnabled = false

                      }
                      if textField == self.txtFieldOTP3 {
                          self.txtFieldOTP2?.becomeFirstResponder()
                          self.txtFieldOTP3.isUserInteractionEnabled = false

                      }
                      if textField == self.txtFieldOTP4 {
                          self.txtFieldOTP3?.becomeFirstResponder()
                          self.txtFieldOTP4.isUserInteractionEnabled = false

                      }
                      textField.text? = string
                      return false
                  }
               }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true
    }
    
    
    func setUpView()
    {
            self.otpView.isHidden = false
            self.txtFieldOTP1.delegate = self
            self.txtFieldOTP2.delegate = self
            self.txtFieldOTP3.delegate = self
            self.txtFieldOTP4.delegate = self

            self.txtFieldOTP1.textContentType = .oneTimeCode
            self.txtFieldOTP1.keyboardType = .numberPad
        
            self.txtFieldOTP2.textContentType = .oneTimeCode
            self.txtFieldOTP2.keyboardType = .numberPad
        
            self.txtFieldOTP3.textContentType = .oneTimeCode
            self.txtFieldOTP3.keyboardType = .numberPad
        
            self.txtFieldOTP4.textContentType = .oneTimeCode
            self.txtFieldOTP4.keyboardType = .numberPad
        
            if self.strFrom == "SMS"
            {
                self.counter = 15
            }
            else
            {
                self.counter = 30
            }
         self.timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        let appD = UIApplication.shared.delegate as! AppDelegate
        let statusCall = UserDefaults.standard.value(forKey: "call") as? String
        if counter > 0 {
              print("\(counter) seconds to the end of the world")
                self.lblTimer.text = "Code Expire in :" + "\(counter)"
              counter -= 1
            if appD.strT == "MISSED_CALL" && statusCall == "true"
            {
                timer.invalidate()
                UserDefaults.standard.set("false", forKey: "call")
                UserDefaults.standard.synchronize()
                self.extraView.isHidden = true
                self.otpView.isHidden = true
                self.lblPleaseWait.text = "Authentication Successful"
                self.lblFail.text = ""
                let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "CongratulationsViewController")as! CongratulationsViewController)
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
          }
       else
          {
           timer.invalidate()
           self.view.endEditing(true)
            self.extraView.isHidden = true
            self.otpView.isHidden = true
            self.responceView.isHidden = true
            self.btnView.isHidden = false
            self.lblFail.text = "Authentication fail"
            self.lblSucess.text = ""
            let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "FailVC")as! FailVC)
            homeVC.strIsfrom = "User"
            self.navigationController?.pushViewController(homeVC, animated: true)
       }
    }
    
    
    func callServicecForCOuntryCode()
    {
        self.indicator = UIActivityIndicatorView(style: .medium)
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
      
      
      //indicator.startAnimating()

    
        ServerManager().callServiceForCountryCode(viewController: self, isLoaderRequired: false) { (status, obj) in
            if status == "Success"
            {
                //self.indicator.stopAnimating()
                let dictRes : NSDictionary = (obj)
                print(dictRes)
                let arrayList = dictRes.object(forKey: "message") as? NSArray
                for i  in 0...(arrayList!.count - 1)
                {
                    let mutDict = NSMutableDictionary()
                    mutDict.addEntries(from: arrayList![i] as! [AnyHashable : Any])
                    let country = mutDict.object(forKey: "country") as? String
                    if country == "India"
                    {
                        mutDict.setValue("IN", forKey: "country")
                       
                    }
                    let vlaue = mutDict.object(forKey: "country") as? String
                    let flag = self.getFlag(from: vlaue!)
                    mutDict.setValue(flag, forKey: "flag")
                    self.arrayCOuntry.add(mutDict)
                }
                print(self.arrayCOuntry)
            }
        }
    }
    
    
    func callServiceFunction()
      {
          
            self.indicator = UIActivityIndicatorView(style: .medium)
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
          
          
          indicator.startAnimating()
 
        let mob = self.selectedCode + self.txtFieldPhNumber.text!
        
        ServerManager().callServiceForSDK(appKey: "25MrTcpMMVaiWG9t", secretKey: "lWbF6jNkG8PE0AUP", mobile:mob, isfrom: self.strFrom, deviceId: "123456", viewController: self, isLoaderRequired: false) { (status, obj) in
            
                if status == "Success"
                {
                    let dictRes : NSDictionary = (obj)
                    let status = dictRes.object(forKey: "status") as? String
                    DispatchQueue.main.async {
                        
                        self.indicator.stopAnimating()

                    if status == "Failure"
                        {
                            // now update UI on main thread
                            self.responceView.isHidden = false
                             self.txtFieldPhNumber.text = ""
                            self.lblFail.text = "Authentication Fail!"
                        }
                        else
                        {
                            self.txtFieldPhNumber.text = ""
                            if self.strFrom == "MISSED_CALL"
                            {
                              self.responceView.isHidden = false
                              self.counter = 15
                               self.timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
                              }
                             else
                            {
                                let numb = dictRes.object(forKey: "message") as? String
                                self.responceView.isHidden = true
                                if numb != nil
                                {
                                    self.strOTp = numb!
                                }
                               else
                                {
                                    let numbr = dictRes.object(forKey: "message") as? Int
                                    self.strOTp = "\(numbr!)"
                                }
                                
                                self.setUpView()
                          }
                            
                        }
                    }
                }
        }
    }
}
