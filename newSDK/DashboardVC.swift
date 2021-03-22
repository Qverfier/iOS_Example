//
//  DashboardVC.swift
//  newSDK
//
//  Created by LAP314MAC on 13/10/20.
//  Copyright © 2020 LAP314MAC. All rights reserved.
//

import UIKit
import demo

class DashboardVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationController?.setStatusBar(backgroundColor: UIColor.init(red: 42/255, green: 90/255, blue: 244/255, alpha: 1))

        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func tapSDKUI(_ sender: Any) {
        let vc = MainEntryVC()
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        vc.modalPresentationStyle = .fullScreen
        vc.isFrom = "MISSED_CALL"
        vc.strDeviceID = "123456"
        vc.strSecretKey = "lWbF6jNkG8PE0AUP"
        vc.strAppKey = "25MrTcpMMVaiWG9t"
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func tapUSerId(_ sender: Any) {
        let homeVC = (self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")as! HomeVC)
        homeVC.checkIsFrom = "user"
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
}
