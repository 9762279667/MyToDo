//
//  ToDoItemManagerTests.swift
//  MyToDoTests
//
//  Created by Nitin Kalokhe on 28/06/23.
//

import XCTest
@testable import MyToDo

final class ToDoItemManagerTests: XCTestCase {

    var itemManager: ToDoItemManager!
    
    override func setUp() {
        super.setUp()
        
        itemManager = ToDoItemManager()
    }
    
    override func tearDown() {
        itemManager.removeAll()
        itemManager = nil
        super.tearDown()
    }
    
    func test_init_toDoCountIsZero(){
        XCTAssertEqual(itemManager.todoCount, 0, "To Do item count should be zero")
    }
    
    func test_init_doneCountIsZero(){
        XCTAssertEqual(itemManager.doneCount, 0, "done count should be 0")
    }
    
    func test_init_increaseToDoCountByOne(){
        let expectedToDoCount = itemManager.todoCount + 1
        
        itemManager.add(ToDoItem(title: "New To Do"))
        
        XCTAssertEqual(itemManager.todoCount, expectedToDoCount, "to do count should increased by 1")
    }
    
}
