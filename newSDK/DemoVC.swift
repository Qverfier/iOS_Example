//
//  DemoVC.swift
//  newSDK
//
//  Created by LAP314MAC on 03/01/21.
//  Copyright © 2021 LAP314MAC. All rights reserved.
//

import UIKit

class DemoVC: UIViewController {

      var shareView = SharePromptView()

      override func loadView() {
          view = shareView
      }

      override func viewDidLoad() {
          super.viewDidLoad()
      }
}
