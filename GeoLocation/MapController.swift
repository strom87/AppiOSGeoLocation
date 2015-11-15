//
//  LoginController.swift
//  GeoLocation
//
//  Created by Daniel Ström on 15/11/15.
//  Copyright © 2015 Daniel Ström. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftWebSocket
import CoreLocation

class MapController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var isMapInitialized = false
    
    var user:UserModel?
    var socket:WebSocket?
    var mapView:GMSMapView?
    var markers = Dictionary<String, CustomMarker>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initLocationManager()
        self.initWebsocket()
    }
    
    func initLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.pausesLocationUpdatesAutomatically = true
        self.locationManager.startUpdatingLocation()
    }
    
    func initMap(lat:Float64, long:Float64) {
        let camera = GMSCameraPosition.cameraWithLatitude(lat, longitude: long, zoom: 15)
        self.mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        self.view = self.mapView
        self.isMapInitialized = true
    }
    
    func initWebsocket() {
        self.socket = WebSocket(Route.ws("/ws/geo-location/\(self.user!.id!)"))
        
        self.socket!.event.open = {
            print("opend")
        }
        
        self.socket!.event.close = {_,_,_ in
            print("closed")
        }
        
        self.socket!.event.error = {error in
            print("error: \(error)")
        }
        
        self.socket!.event.message = {msg in
            let location = Mapper<GeoLocationModel>().map(msg as! String)
            
            self.updateMarker(location!)
        }
    }
    
    func updateMarker(location:GeoLocationModel) {
        let key = location.id!
        
        if self.markers[key] == nil {
            if location.disconnected! {
                self.markers[key]?.map = nil
                self.markers.removeValueForKey(key)
                return
            }
            
            let marker = CustomMarker(id: key)
            marker.position = CLLocationCoordinate2DMake(location.lat!, location.long!)
            marker.snippet = key
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.map = self.mapView
            
            self.markers[key] = marker
        }
        
        self.markers[key]?.position = CLLocationCoordinate2DMake(location.lat!, location.long!)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        
        if !self.isMapInitialized {
            self.initMap(location.coordinate.latitude, long: location.coordinate.longitude)
        }
        
        let model = GeoLocationModel()
        model.lat = location.coordinate.latitude
        model.long = location.coordinate.longitude
        
        self.socket!.send(model.toJson())
    }

}
