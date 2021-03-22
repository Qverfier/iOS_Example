//
//  FailVC.swift
//  newSDK
//
//  Created by LAP314MAC on 21/10/20.
//  Copyright © 2020 LAP314MAC. All rights reserved.
//

import UIKit

class FailVC: UIViewController {

    @IBOutlet var btnTryAgain: UIButton!
    @IBOutlet var lblReason: UILabel!
    var strIsfrom = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.btnTryAgain.layer.cornerRadius = 3.0
        self.btnTryAgain.layer.borderWidth = 0.6
        self.btnTryAgain.layer.borderColor = UIColor.white.cgColor
        self.btnTryAgain.clipsToBounds = true
              
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func functionToCall()
    {
         let defaults = UserDefaults.standard
           let dictionary = defaults.dictionaryRepresentation()
           dictionary.keys.forEach { key in
               defaults.removeObject(forKey: key)
           }
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func tapTryAgaian(_ sender: Any) {
        let defaults = UserDefaults.standard
           let dictionary = defaults.dictionaryRepresentation()
           dictionary.keys.forEach { key in
               defaults.removeObject(forKey: key)
           }
        
        if self.strIsfrom == "sdk"
        {
            let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC")as! DashboardVC)
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        else
        {
            let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")as! HomeVC)
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
       
       
        }
    }

