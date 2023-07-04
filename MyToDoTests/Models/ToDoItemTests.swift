//
//  ToDoItemTests.swift
//  MyToDoTests
//
//  Created by Nitin Kalokhe on 27/06/23.
//

import XCTest
@testable import MyToDo

class ToDoItemTests: XCTestCase {
    
    let timestamp = 0.0
    let locationName = "Location"
    
    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func test_init_givenTitle_setsTitle(){
        let toDoItem = ToDoItem(title: Foo)
        XCTAssertEqual(toDoItem.title, Foo, "should set title")
    }
    
    func test_init_givenItemDescription_setsItemDescription(){
        let toDoItem = ToDoItem(title: Foo, itemDescription: Bar)
        
        XCTAssertEqual(toDoItem.title, Foo, "should set title")
        XCTAssertEqual(toDoItem.itemDescription, Bar, "should set description")
    }
    
    func test_init_givenItemTimestamp_setTimestamp(){
        let toDoItem = ToDoItem(title: Foo, timestamp: timestamp)
        XCTAssertEqual(toDoItem.title, Foo, "should set title")
        XCTAssertEqual(toDoItem.timestamp, timestamp, "should set item description")
    }
    
    func test_init_givenItemLocation_setLocation(){
        let toDoItem = ToDoItem(title: Foo, location: Location(name: locationName))
        let location = Location(name: locationName)

        XCTAssertEqual(toDoItem.title, Foo, "should set tile")
        XCTAssertEqual(toDoItem.location, location, "should set Location")
    }
    
    func test_init_hasPlistDictionaryProperty(){
        let toDoItem = ToDoItem(title: "First")
        let dictionary = toDoItem.plistDict;
        XCTAssertNotNil(dictionary)
    }
    
    func test_canBeCreatedFromPlistDictionary(){
        let location = Location(name: Bar)
        let toDoItem = ToDoItem(title: Foo, itemDescription: "Bar", timestamp: 1.0, location: location)
        
        let dict = toDoItem.plistDict
        
        let recreatedItem = ToDoItem(dict: dict)
        
        XCTAssertEqual(recreatedItem, toDoItem)
    }
}
