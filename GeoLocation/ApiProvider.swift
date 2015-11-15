//
//  ApiProvider.swift
//  GeoLocation
//
//  Created by Daniel Ström on 15/11/15.
//  Copyright © 2015 Daniel Ström. All rights reserved.
//

typealias RequestResponse = (data:NSDictionary, error:NSError?) -> Void

import Alamofire

class ApiProvider {
    static let instance = ApiProvider()
    
    func login(model:LoginModel, callback: RequestResponse) {
        let url = Route.url("/login")
        
        Alamofire.request(.POST, url, parameters: self.jsonToDict(model.toJson()), encoding: .JSON).responseData{response in
            self.generateCallback(response.result.value, error: response.result.error, callback: callback)
        }
    }
    
    func generateCallback(data:NSData?, error:NSError?, callback: RequestResponse) {
        if error != nil {
            callback(data: Dictionary<String, String>(), error: error)
            return
        }
        
        callback(data: self.dataToDict(data), error: nil)
    }
    
    func jsonToDict(jsonString: String) -> [String:AnyObject]? {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
    func dataToDict(data:NSData?) -> NSDictionary {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as! NSDictionary
        } catch {
            print(error)
        }
        
        return Dictionary<String, String>()
    }
}