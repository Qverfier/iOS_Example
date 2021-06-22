//
//  PleaseWaitViewController.swift
//  newSDK
//
//  Created by LAP314MAC on 29/09/20.
//  Copyright © 2020 LAP314MAC. All rights reserved.
//

import UIKit

class PleaseWaitViewController: UIViewController {

    @IBOutlet weak var callingImgVw: UIImageView!
    @IBOutlet weak var plzwaitlbl: UILabel!
    @IBOutlet weak var waitmsgLbl: UILabel!
    @IBOutlet var lblTimer: UILabel!
    @IBOutlet var mainView: UIView!
    
    var counter : Int = 0
    var timer = Timer()
    var checkIsFrom = String()
    var userTy = String()
    var strMsg = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.navigationController?.setStatusBar(backgroundColor: UIColor.init(red: 42/255, green: 90/255, blue: 244/255, alpha: 1))

       timer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        if self.checkIsFrom != "user"
        {
            let defultD = UserDefaults.standard
            let valueCounter = defultD.object(forKey: "time") as? Int
            if valueCounter != 0 && valueCounter != nil
            {
                self.counter = valueCounter!
            }
            else
            {
                self.counter = 15
            }
        }
        else
        {
            self.counter = 15
        }
        
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.callingImgVw.image = UIImage.gifImageWithName("call_new")
    }
    
  @objc func updateCounter() {
       //example functionality
    let defultD = UserDefaults.standard
    let appD = UIApplication.shared.delegate as? AppDelegate
    if self.userTy != "user"
    {
        defultD.set(counter, forKey: "time")
        defultD.set(appD?.strT, forKey: "type")
        defultD.synchronize()
    }
       if counter > 0 {
           print("\(counter) seconds to the end of the world")
            self.lblTimer.text = "\(counter) sec"
           counter -= 1
        
        
        if appD?.strT == "MISSED_CALL" && appD?.chkT == "true"
        {
            timer.invalidate()
            appD?.chkT = "false"
            let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "CongratulationsViewController")as! CongratulationsViewController)
            self.navigationController?.pushViewController(homeVC, animated: true)
            
        }
       }
    else
       {
        timer.invalidate()
        do {
            if appD?.chkT == "false"  && self.userTy == "user"
            {
               self.mainView.isHidden = false
                let seconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                 self.mainView.isHidden = true
                    let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "FailVC")as! FailVC)
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
            else
            {
                self.plzwaitlbl.text = "Authentication failed"
                self.waitmsgLbl.text = "Trying Another way."
                let seconds = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    let appD = UIApplication.shared.delegate as? AppDelegate
                       appD?.strT = "SMS"
                       let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "EnterotpViewController")as! EnterotpViewController)
                       homeVC.strPhoNumber = ""
                       homeVC.strType = "SMS"
                    homeVC.strMsg = self.strMsg
                       homeVC.checkIsFrom = self.checkIsFrom
                       self.navigationController?.pushViewController(homeVC, animated: true)
                }
                
                
               
            }
            }
        
        }
    }
    
    func showToast(message : String) {

          let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
          toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
          toastLabel.textColor = UIColor.white
          toastLabel.textAlignment = .center;
          toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
          toastLabel.text = message
          toastLabel.alpha = 1.0
          toastLabel.layer.cornerRadius = 10;
          toastLabel.clipsToBounds  =  true
         // self.view.addSubview(toastLabel)
         
      }
}
