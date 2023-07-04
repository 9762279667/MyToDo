//
//  Location.swift
//  MyToDo
//
//  Created by Nitin Kalokhe on 17/06/23.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinates: CLLocationCoordinate2D?
    
    // plist
    private let nameKey = "nameKey"
    private let latitudeKey = "latitudeKey"
    private let longitudeKey = "longitudeKey"
    
    var plistDict: [String:Any] {
        var dict = [String:Any]()
        
        dict[nameKey] = name
        
        if let coordinates = coordinates {
            dict[latitudeKey] = coordinates.latitude
            dict[longitudeKey] = coordinates.longitude
        }
        
        return dict;
    }
    
    init(name: String, coordinates: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinates = coordinates
    }
    
    init?(dict:[String:Any]) {
        guard let name = dict[nameKey] as? String else {
            return nil
        }
        
        let coordinates : CLLocationCoordinate2D?
        
        if let latitude = dict[latitudeKey] as? Double, let longitude = dict[longitudeKey] as? Double {
            coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }else{
            coordinates = nil
        }
        self.name = name
        self.coordinates = coordinates
    }
    
}

extension Location: Equatable {
    static func ==(lhs:Location, rhs:Location) -> Bool {
        return lhs.name == rhs.name && lhs.coordinates?.latitude == rhs.coordinates?.latitude &&
        lhs.coordinates?.longitude == rhs.coordinates?.longitude
    }
}
