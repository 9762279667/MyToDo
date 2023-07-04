//
//  LocationTests.swift
//  MyToDoTests
//
//  Created by Nitin Kalokhe on 28/06/23.
//

import XCTest
import CoreLocation
@testable import MyToDo

final class LocationTests: XCTestCase {
    
    let locationName = "Location"
    let lat = 1.0
    let lon = 2.0
    
    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }

    func test_init_givenName_setName(){
        let location = Location(name: locationName)
        
        XCTAssertEqual(location.name, locationName, "should set location name")
    }
    
    func test_init_givenCoordinates_setsCoordinates(){
        let locCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let location = Location(name: locationName, coordinates: locCoordinates)
        
        XCTAssertEqual(location.name, locationName, "should set location name")
        
        XCTAssertEqual(location.coordinates?.latitude, lat, "should set location latitude")
        XCTAssertEqual(location.coordinates?.longitude, lon, "should set location longitude")
        
    }
    
    func test_init_hasPlistDictionaryProperty(){
        let location = Location(name: locationName)
        let dict = location.plistDict
        
        XCTAssertNotNil(dict)
    }
    
    func test_init_canBeSerializedAndDeserialized(){
        let location = Location(name: locationName, coordinates: CLLocationCoordinate2DMake(lat, lon))
        
        let dict = location.plistDict
        
        let recreatedLocation = Location(dict:dict)
        
        XCTAssertEqual(location, recreatedLocation)
    }
}
