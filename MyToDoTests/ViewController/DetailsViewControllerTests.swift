//
//  DetailsViewControllerTests.swift
//  MyToDoTests
//
//  Created by Nitin Kalokhe on 28/06/23.
//

import XCTest
import CoreLocation
@testable import MyToDo

final class DetailsViewControllerTests: XCTestCase {

    var detailsViewController : DetailsViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: Constants.MainStoryboardIdentifier, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.DetailViewControllerIdentifier) as! DetailsViewController
        
        detailsViewController = viewController
    }
    
    override func tearDown() {
        detailsViewController.item = nil
        super.tearDown()
    }
    
    func test_init_hasTitleLabel(){
        XCTAssertTrue(detailsViewController.label.isDescendant(of: detailsViewController.view))
    }
    
    func test_init_hasLocationLabel(){
        XCTAssertTrue(detailsViewController.locationLabel.isDescendant(of: detailsViewController.view))
    }
    
    func test_init_hasMapView(){
        XCTAssertTrue(detailsViewController.mapView.isDescendant(of: detailsViewController.view))
    }
    
    func test_viewDidLoad_givenItem_hasItem(){
        let coordinates = CLLocationCoordinate2DMake(1.0, 2.0)
        
        let timestamp = 32423432.0
        
        let toDoItem = ToDoItem(title: Foo, itemDescription: Bar, timestamp: timestamp, location: Location(name: "Infinite loop 1, Cupertino", coordinates: coordinates))
        
        detailsViewController.item = toDoItem
        
        detailsViewController.viewDidLoad()
        
        XCTAssertEqual(detailsViewController.label.text, toDoItem.title)
        XCTAssertEqual(detailsViewController.locationLabel.text, toDoItem.location!.name)
        XCTAssertEqual(ceil(detailsViewController.mapView.centerCoordinate.latitude), toDoItem.location!.coordinates!.latitude)
        XCTAssertEqual(ceil(detailsViewController.mapView.centerCoordinate.longitude), toDoItem.location!.coordinates!.longitude)
    }
}
