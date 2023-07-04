//
//  ItemListDataProviderTests.swift
//  MyToDoTests
//
//  Created by Nitin Kalokhe on 30/06/23.
//

import XCTest
@testable import MyToDo

final class ItemListDataProviderTests: XCTestCase {

    // MARK: - variable
    var tableView: UITableView!
    var dataProvider: ItemListDataProvider!
    var itemManager: ToDoItemManager!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: Constants.MainStoryboardIdentifier, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: Constants.ItemListViewController) as? ItemListViewController
        
        tableView = viewController?.tableView
        
        dataProvider = ItemListDataProvider()
        itemManager = ToDoItemManager()
        
        dataProvider.itemManager = itemManager
        tableView.dataSource = dataProvider
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetails(_ :)), name: Notification.ItemSelectedNotification, object: nil)
    }
    
    @objc func showDetails(_ sender: Notification){
        
    }

    override func tearDown() {
        super.tearDown()
        itemManager.removeAll()
    }
    
    
    // MARK: - Number Of Sections
    
    func test_init_noOfSections_isTwo(){
        XCTAssertEqual(tableView.numberOfSections, 2, "Number of sections should be 2")
    }
    
    func test_init_noOfRowsOfToDoSection(){
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0, "Number of rows in section initially should be 0")
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), itemManager.todoCount, "Number of section of section should be equal to no of items in itemManager")
    }
    
    func test_init_noOfRowsOfToDoSection_afterAddToDoItem(){
        itemManager.add(ToDoItem(title: Foo))
        tableView.reloadData()
        
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1, "number of rows in section should be increased by 1 after adding new item")
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), itemManager.todoCount, "number of rows in section should be equal to item manager item count")
    }
    
    func test_init_noOfRowsOfToDoSection_isChecked(){
        itemManager.add(ToDoItem(title: Foo))
        itemManager.checkItem(at: 0)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1, "number of rows in section should be increased by 1 after adding new item")
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), itemManager.doneCount , "number of items in section should be euqal to done count")
    }
    
    // MARK: - CellForRow
    
    func test_cellForRow_init_isItemCell(){
        itemManager.add(ToDoItem(title: Foo))
        
        tableView.reloadData()
        
        // if tableView is not init from storyboard, it can not configure cell to ItemCell as it can not find right identifier
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is ItemCell, "cell should be ItemCell")
    }
    
    func test_cellForRow_givenToDoItem_callsCellDeque(){
        let mockTableView = MockTableView.mockTableView(withDataSource: dataProvider)
        itemManager.add(ToDoItem(title:Foo))
        
        mockTableView.reloadData()
        
        mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.dequeCellGotCalled, "cell should be dequed")
    }
    
    func test_cellForRow_givenToDoItem_callsConfigCell(){
        let mockTableView = MockTableView.mockTableView(withDataSource: dataProvider)
        
        let item = ToDoItem(title: Foo)
        itemManager.add(item)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        
        XCTAssertTrue(mockTableView.dequeCellGotCalled, "cell should be dequed")
        XCTAssertEqual(cell.cachedItem, item, "config item should be the one added")
    }
    
    func test_cellForRow_givenDoneItem_callsConfigCell(){
        let mockTableView = MockTableView.mockTableView(withDataSource: dataProvider)
        
        let item = ToDoItem(title: Foo)
        
        itemManager.add(item)
        itemManager.checkItem(at: 0)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        
        XCTAssertTrue(mockTableView.dequeCellGotCalled, "cell should be dequed")
        XCTAssertEqual(cell.cachedItem, item, "config item should be the one added")
    }
}

extension ItemListDataProviderTests {
    // Mock a tableview cell to ensure the cellDeque is called
    
    class MockTableView : UITableView {
        var dequeCellGotCalled = false
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            dequeCellGotCalled = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableView(withDataSource dataSource:UITableViewDataSource)->MockTableView{
            let mockTableView = MockTableView()
            mockTableView.dataSource = dataSource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: Constants.ItemCellIdentifier)
            return mockTableView
        }
    }
    
    
    class MockItemCell : ItemCell {
        var cachedItem : ToDoItem!
        var configCellItemGotCalled = false
        override func configCell(with item: ToDoItem, isChecked: Bool = false) {
            configCellItemGotCalled = true
            cachedItem = item
        }
    }
}
