//
//  StoryboardTests.swift
//  MyToDoTests
//
//  Created by Nitin Kalokhe on 25/06/23.
//

import XCTest
@testable import MyToDo

final class StoryboardTests: XCTestCase {

    override class func setUp() {
        
    }
    
    override class func tearDown() {
        
    }

    func test_init_initialViewController_isItemListViewController(){
        
        let storyboard = UIStoryboard(name: Constants.MainStoryboardIdentifier, bundle: nil)
        
        let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        
        let viewController = navigationController?.viewControllers[0]
        
        XCTAssertTrue(viewController is ItemListViewController)
    }
}
