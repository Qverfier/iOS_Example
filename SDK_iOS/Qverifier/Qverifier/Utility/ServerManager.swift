

import Foundation
import UIKit


public class ServerManager: NSObject  {
    
   public  func callServiceForSDK(appKey : String,secretKey : String,mobile : String,isfrom : String,deviceId : String,viewController:UIViewController, isLoaderRequired:Bool ,completion: @escaping (_ errorString: String?,_ obj:NSDictionary) -> Void) {
        
        let strDict = ["appKey":appKey, "secretKey":secretKey,"phoneNumber":mobile,"actionType" : isfrom,"deviceId" : deviceId] as Dictionary<String, String>
        
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
                completion("Success",dict!)
                print(json)
            }catch let error{
                print(error.localizedDescription)
                completion("Fail",[:]);
            }
        }
    }.resume()
    }
    
    public  func callServiceForCountryCode(viewController:UIViewController, isLoaderRequired:Bool ,completion: @escaping (_ errorString: String?,_ obj:NSDictionary) -> Void) {
         
      
         
          let urlMain = String(format: "%@", kBASE_SERVER_URL_Code)
          let url = URL(string: urlMain)
          
           var request = URLRequest(url: url!)
           request.httpMethod = "get"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           request.addValue("application/json", forHTTPHeaderField: "Accept")

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
                completion("Success",dict!)
                print(dict)
             }catch let error{
                 print(error.localizedDescription)
                completion("Fail",[:]);
             }
         }
     }.resume()
     }
}

