
//
//  Status.swift
//  GeoLocation
//
//  Created by Daniel Ström on 15/11/15.
//  Copyright © 2015 Daniel Ström. All rights reserved.
//

import ObjectMapper

class BaseModel: Mappable {
    
    var success:Bool?
    var errorCode:Int?
    
    init() {
    
    }
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        success   <- map["success"]
        errorCode <- map["error_code"]
    }
}