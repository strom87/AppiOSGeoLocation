//
//  CustomMarker.swift
//  GeoLocation
//
//  Created by Daniel Ström on 15/11/15.
//  Copyright © 2015 Daniel Ström. All rights reserved.
//

import Foundation

class CustomMarker: GMSMarker {
    var id:String
    
    init(id:String) {
        self.id = id
    }
}