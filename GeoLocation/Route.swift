//
//  Route.swift
//  GeoLocation
//
//  Created by Daniel Ström on 15/11/15.
//  Copyright © 2015 Daniel Ström. All rights reserved.
//

class Route {
    static let host = "192.168.0.18:1337"

    static func url(route:String) -> String {
        return "http://\(host)\(route)"
    }
    
    static func ws(route:String) -> String {
        return "ws://\(host)\(route)"
    }
}