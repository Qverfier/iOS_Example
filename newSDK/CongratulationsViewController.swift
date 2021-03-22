//
//  CongratulationsViewController.swift
//  newSDK
//
//  Created by LAP314MAC on 29/09/20.
//  Copyright © 2020 LAP314MAC. All rights reserved.
//

import UIKit

class CongratulationsViewController: UIViewController {
    @IBOutlet weak var congratsImgVw: UIImageView!

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
       // self.navigationController?.setStatusBar(backgroundColor: UIColor.init(red: 42/255, green: 90/255, blue: 244/255, alpha: 1))

        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
            self.functionToCall()
        }
        // Do any additional setup after loading the view.
    }
    
    func functionToCall()
    {
        let defaults = UserDefaults.standard
           let dictionary = defaults.dictionaryRepresentation()
           dictionary.keys.forEach { key in
               defaults.removeObject(forKey: key)
           }
        defaults.synchronize()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
