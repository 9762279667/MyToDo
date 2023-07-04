//
//  ItemCellTests.swift
//  MyToDoTests
//
//  Created by Nitin Kalokhe on 25/06/23.
//

import XCTest
@testable import MyToDo

final class ItemCellTests: XCTestCase {

    var cell : ItemCell!

    override  func setUp() {
        super.setUp()
        var storyboard = UIStoryboard(name: Constants.MainStoryboardIdentifier, bundle: nil)
        var itemListViewController = storyboard.instantiateViewController(withIdentifier: Constants.ItemListViewController) as? ItemListViewController
        itemListViewController?.loadViewIfNeeded()
        
        let tableView = itemListViewController?.tableView
        let fakeDataSource = FakeDataSource()
        tableView?.dataSource = fakeDataSource
        
        cell = (tableView?.dequeueReusableCell(withIdentifier: Constants.ItemCellIdentifier, for: IndexPath(row: 0, section: 0)) as! ItemCell)
    }
    
    override  func tearDown() {
        super.tearDown()
    }
    
    // MARK: - init
    func test_init_givenTableViewDataSource_hasNameTable(){
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func test_init_givenTableViewDataSource_hasLocationLable(){
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func test_init_givenTableViewDataSource_hasDateLabel(){
        XCTAssertTrue(cell.timestampLabel.isDescendant(of: cell.contentView))
    }
    
    // MARK: - configCell
    func test_configCell_givenTitle_setsTitle(){
        let toDoItem = ToDoItem(dict: ["hey":Foo])
        cell.configCell(with: toDoItem!)
        
        XCTAssertEqual(cell.titleLabel.text, toDoItem?.title)
    }
    
    func test_configCell_givenLocation_setsLocation(){
        let location = Location(dict: ["hey": Foo])
        let toDoItem = ToDoItem(title: Foo, location: location)
        cell.configCell(with: toDoItem)
        XCTAssertEqual(cell.locationLabel.text, Bar)
    }
    
    func test_configCell_givenDate_setsDate(){
        let dateFormtter = DateFormatter()
        dateFormtter.dateFormat = "MM/dd/yyyy"
        let date = dateFormtter.date(from: testDate)
        let timestamp = date?.timeIntervalSince1970
        
        let toDoItem = ToDoItem(title: Foo, timestamp: timestamp)
        cell.configCell(with: toDoItem)
        XCTAssertEqual(cell.timestampLabel.text, testDate)
    }
    
    func test_configCell_itemIsChecked_titleIsStrokeThrough(){
        let location = Location(name: Bar)
        let toDoItem = ToDoItem(title: Foo, timestamp: 1432435344, location: location)
        cell.configCell(with: toDoItem, isChecked: true)
        
        let attributedString = NSAttributedString(string: Foo, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.timestampLabel.text)
    }
}

extension ItemCellTests {
    class FakeDataSource : NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
