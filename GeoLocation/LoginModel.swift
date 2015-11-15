//
//  LoginModel.swift
//  GeoLocation
//
//  Created by Daniel Ström on 15/11/15.
//  Copyright © 2015 Daniel Ström. All rights reserved.
//

import ObjectMapper

class LoginModel: Mappable {
    
    var email:String?
    var password:String?
    
    init() {
    }
    
    required init?(_ map: Map){
    }
    
    func mapping(map: Map) {
        email    <- map["email"]
        password <- map["password"]
    }
    
    func toJson() -> String {
        return Mapper().toJSONString(self, prettyPrint: false)!
    }
}