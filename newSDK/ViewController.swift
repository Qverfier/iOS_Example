//
//  ViewController.swift
//  newSDK
//
//  Created by LAP314MAC on 29/09/20.
//  Copyright © 2020 LAP314MAC. All rights reserved.
//

import UIKit

@available(iOS 12.0, *)
@available(iOS 12.0, *)
class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var indiaLogoImg: UIImageView!
    @IBOutlet weak var countrycodeBtn: UIButton!
    @IBOutlet weak var phnNoLbl: UILabel!
    @IBOutlet weak var phnNoTxtFld: UITextField!
    @IBOutlet weak var getStartBtn: UIButton!
    @IBOutlet var mobileView: UIView!
    
    var isFrom = String()
    var strMSG = String()
    var checkFrom = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phnNoTxtFld.delegate = self
        let appD = UIApplication.shared.delegate as? AppDelegate
        appD?.chkT = "false"
        self.mobileView.layer.cornerRadius = 3.0
        self.mobileView.clipsToBounds = true

        self.getStartBtn.layer.cornerRadius = 3.0
        self.getStartBtn.layer.borderWidth = 0.6
        self.getStartBtn.layer.borderColor = UIColor.white.cgColor
        self.getStartBtn.clipsToBounds = true
       
        UITextField.setPloceHolderTextColor([self.phnNoTxtFld as Any], color: UIColor.init(red: 127/255, green: 143/255, blue: 164/255, alpha: 1))
       
    }
    
   override var prefersStatusBarHidden: Bool {
       return true
   }
    
    
    func callOtherClass()
    {
        
        let defultD = UserDefaults.standard
        let appD = UIApplication.shared.delegate as? AppDelegate

            let type = defultD.object(forKey: "type") as? String
            let valueCounter = defultD.object(forKey: "time") as? Int
            if valueCounter != 0 && valueCounter != nil && type != nil
            {
                if type == "MISSED_CALL"
                {
                    appD?.strT = "MISSED_CALL"
                    
                     let vc = PleaseWaitVC()
                    let transition = CATransition()
                    transition.duration = 0.5
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                    view.window!.layer.add(transition, forKey: kCATransition)
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false, completion: nil)
                    
                }
                else if type == "SMS"
                {
                    appD?.strT = "SMS"
                    let vc = OTPVC()
                    let transition = CATransition()
                    transition.duration = 0.5
                    transition.type = CATransitionType.push
                    transition.subtype = CATransitionSubtype.fromRight
                    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                    self.view.window!.layer.add(transition, forKey: kCATransition)
                    vc.modalPresentationStyle = .fullScreen
                    vc.strType = "SMS"
                    vc.strMsg = self.strMSG
                    self.present(vc, animated: false, completion: nil)
                }
                else
                {
                   appD?.strT = "VOICE_OTP"
                   
                   let vc = OTPVC()
                   let transition = CATransition()
                   transition.duration = 0.5
                   transition.type = CATransitionType.push
                   transition.subtype = CATransitionSubtype.fromRight
                   transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                   self.view.window!.layer.add(transition, forKey: kCATransition)
                   vc.modalPresentationStyle = .fullScreen
                   vc.strType = "VOICE_OTP"
                   vc.strMsg = self.strMSG
                   self.present(vc, animated: false, completion: nil)
                }
                return
            }
        else
            {
                let appD = UIApplication.shared.delegate as? AppDelegate
                appD?.strT = "MISSED_CALL"
                
                 let vc = PleaseWaitVC()
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromRight
                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
                view.window!.layer.add(transition, forKey: kCATransition)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
        }
        
    }
    
    @IBAction func getStartedClick(_ sender: Any) {

        
        if self.phnNoTxtFld.text?.count != 10
        {
            let alert = UIAlertController(title: "Alert", message: "invalid mobile number. Please enter valid number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        UserDefaults.standard.set(self.phnNoTxtFld.text!, forKey: "mobile")
        UserDefaults.standard.synchronize()
        
        let appDe = UIApplication.shared.delegate as? AppDelegate
        appDe?.phonenumber = self.phnNoTxtFld.text!
        
        let msg = "Is this your contact Number ?" +  "\n\n" + "+91 " +   "\(self.phnNoTxtFld.text!)" + "\n\n" + "We are calling you to verify this number."
        let alert = UIAlertController(title: "Confirm Your Number", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { action in
         }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
            self.view.isUserInteractionEnabled = false
                   self.callServiceFunction()
        }))
         self.present(alert, animated: true, completion: nil)
    }
    
// Add Delegate method for textfiled
    
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == phnNoTxtFld {
           let charsLimit = 10

            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace = range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace

            return newLength <= charsLimit
        }
        return true
    }
    
    @IBAction func valueChanged(_ sender: UITextField) {
        if let last = sender.text?.last {
            let zero: Character = "0"
            let num: Int = Int(UnicodeScalar(String(last))!.value - UnicodeScalar(String(zero))!.value)
            if (num < 0 || num > 9) {
                //remove the last character as it is invalid
                sender.text?.removeLast()
            }
        }
    }

    // Func or callService for MissedCall
    
    
    func callServiceFunction()
    {
        
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
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
        let defultD = UserDefaults.standard
        let type = defultD.object(forKey: "type") as? String
        if type != nil
        {
            self.isFrom = type!
        }
        else
        {
            self.isFrom = "MISSED_CALL"
        }
        
        let params = ["appKey":"25MrTcpMMVaiWG9t", "secretKey":"lWbF6jNkG8PE0AUP","phoneNumber":self.phnNoTxtFld.text!,"actionType" : self.isFrom,"deviceId" : "123456"] as Dictionary<String, String>

        
        if ApplicationManager().connectedToNetwork() {
            ServerManager().callServiceForSDK(strDict: params as NSDictionary, vc: self)
            }else{
                ApplicationManager().test(title: "Opps", message: "Internet Connection Not Available.. " as NSString, owner: self)
            }
    }
    
    
        func sdk_successBlock(result:AnyObject!){
            let dictRes : NSDictionary = (result as? NSDictionary)!
            let status = dictRes.object(forKey: "status") as? String

                if status == "Failure"
                {
                    DispatchQueue.main.async { [unowned self] in
                        let alert = UIAlertController(title: "Error", message: "Invalid Action", preferredStyle: .alert)
                                           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                               self.navigationController?.popToRootViewController(animated: true)
                                            }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    if self.isFrom == "SMS"
                    {
                        let strmsg = dictRes.object(forKey: "message") as? String
                        self.strMSG = strmsg!
                    }
                    DispatchQueue.main.async { [unowned self] in
                        self.callOtherClass()
                    }

                    }
        }
    
        func sdk_errorBlock(error:NSError)
        {
            
            print("In errorBlock")

            DispatchQueue.main.async { [unowned self] in
                ApplicationManager().test(title: "SDK", message: "Server Error", owner: self)
            }
        }
}

