//
//  AppDelegate.swift
//  newSDK
//
//  Created by LAP314MAC on 29/09/20.
//  Copyright © 2020 LAP314MAC. All rights reserved.
//

import UIKit
import CallKit

@available(iOS 12.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var storyBoard = UIStoryboard()
    var callObserver: CXCallObserver!
    var phonenumber = String()
    var strT = String()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        callObserver = CXCallObserver()
        callObserver.setDelegate(self, queue: nil)
        self.resetRoot()
        UserDefaults.standard.set("false", forKey: "call")
        UserDefaults.standard.synchronize()
       
        return true
    }

   
    
    func resetRoot() {
        
           guard let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC else {
               return
           }
           let navigationController = UINavigationController(rootViewController: rootVC)
        
        self.window!.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
    }
    
   
}

extension AppDelegate: CXCallObserverDelegate {
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.hasEnded == true {
            print("Disconnected")
            
            UserDefaults.standard.set("true", forKey: "call")
            UserDefaults.standard.synchronize()
        }
        if call.isOutgoing == true && call.hasConnected == false {
            
            print("Dialing")
        }
        if call.isOutgoing == false && call.hasConnected == false && call.hasEnded == false {
            print("Incoming")
        }

        if call.hasConnected == true && call.hasEnded == false {
            print("Connected")
        }
    }
}
extension UINavigationController {

func setStatusBar(backgroundColor: UIColor) {
    let statusBarFrame: CGRect
    if #available(iOS 13.0, *) {
        statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
    } else {
        statusBarFrame = UIApplication.shared.statusBarFrame
    }
    let statusBarView = UIView(frame: statusBarFrame)
    statusBarView.backgroundColor = backgroundColor
    view.addSubview(statusBarView)
}
}
