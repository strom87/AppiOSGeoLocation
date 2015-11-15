//
//  UserModel.swift
//  GeoLocation
//
//  Created by Daniel Ström on 15/11/15.
//  Copyright © 2015 Daniel Ström. All rights reserved.
//

import ObjectMapper

class UserModel: BaseModel {
    
    var id:String?
    var name:String?
    var email:String?
    var icon:String?
    
    override init() {
        super.init()
    }
    
    required init?(_ map: Map){
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        id    <- map["data.id"]
        name  <- map["data.name"]
        email <- map["data.email"]
        icon  <- map["data.icon"]
    }
}
