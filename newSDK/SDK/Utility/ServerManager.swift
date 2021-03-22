

import Foundation
import UIKit


class ServerManager: NSObject  {
    
    var userDafault = UserDefaults.standard
  
    func callServiceForSDK(appKey : String,secretKey : String,mobile : String,isfrom : String,deviceId : String,vc:AnyObject)
     {
        let strDict = ["appKey":appKey, "secretKey":secretKey,"phoneNumber":mobile,"actionType" : isfrom,"deviceId" : deviceId] as Dictionary<String, String>
        let comingVC = vc as? UIViewController
        
         let urlMain = String(format: "%@", kBASE_SERVER_URL)
         let url = URL(string: urlMain)
         
          var request = URLRequest(url: url!)
          request.httpMethod = "post"
          request.addValue("application/json", forHTTPHeaderField: "Content-Type")
          request.addValue("application/json", forHTTPHeaderField: "Accept")
          request.httpBody = try? JSONSerialization.data(withJSONObject: strDict, options: [])

         URLSession.shared.dataTask(with: request){(data, response, error) in
             guard let data = data else{
                 if error == nil{
                     print(error?.localizedDescription ?? "Unknown Error")
                 }
                 return
             }
           if let httpResponse = response as? HTTPURLResponse {
                 print("statusCode: \(httpResponse.statusCode)")
             do {
                 let json = try JSONSerialization.jsonObject(with: data, options: [])
                 let dict = json as? NSDictionary
                 if let vcG = vc as? MainEntryVC{
                     vcG.sdk_successBlock(result: dict as AnyObject)
                 }
                if let vcG = vc as? OTPVC{
                                    vcG.sdk_successBlock(result: dict as AnyObject)
                                }
                 print(json)
             }catch let error{
                 print(error.localizedDescription)
                 if let vc = comingVC as? MainEntryVC{
                    vc.sdk_errorBlock(error: error as NSError)
                 }
                if let vc = comingVC as? OTPVC{
                                   vc.sdk_errorBlock(error: error as NSError)
                                }
             }
         }
     }.resume()
    }
    
}

