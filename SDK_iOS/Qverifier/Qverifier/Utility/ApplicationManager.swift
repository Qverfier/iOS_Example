//
//  Extension.swift
//
//  Created by SDK MAC
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

 public class ApplicationManager: NSObject {

   public func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else { return false }
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
   
    public func test(title:NSString, message:NSString,owner:UIViewController) {

           let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
           owner.present(alert, animated: true, completion: nil)
       }
    
    
}
