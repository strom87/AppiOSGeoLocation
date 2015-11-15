//
//  LocationModel.swift
//  GeoLocation
//
//  Created by Daniel Ström on 15/11/15.
//  Copyright © 2015 Daniel Ström. All rights reserved.
//

import ObjectMapper

class GeoLocationModel: Mappable {
    
    var id:String?
    var lat:Float64?
    var long:Float64?
    var disconnected:Bool?
    
    init() {
    }
    
    required init?(_ map: Map){
    }
    
    func mapping(map: Map) {
        id           <- map["id"]
        lat          <- map["lat"]
        long         <- map["long"]
        disconnected <- map["disconnected"]
    }
    
    func toJson() -> String {
        return Mapper().toJSONString(self, prettyPrint: false)!
    }
}