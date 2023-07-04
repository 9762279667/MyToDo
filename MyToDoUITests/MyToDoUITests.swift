//
//  MyToDoUITests.swift
//  MyToDoUITests
//
//  Created by Nitin Kalokhe on 29/05/23.
//

import XCTest

final class MyToDoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    func testAddToDo(){
        let app = XCUIApplication()
        app.navigationBars["MyToDo.ItemListView"].buttons["Add"].tap()
        
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("Meeting")
        
        let addressTextField = app.textFields["Adress"]
        addressTextField.tap()
        addressTextField.typeText("Shivajinagar, Pune")
        
        let descriptionTextField = app.textFields["Description"]
        descriptionTextField.tap()
        descriptionTextField.typeText("This is testing description")
        
        let datePickerQuery = app.datePickers
        datePickerQuery.pickerWheels["1970"].adjust(toPickerWheelValue: "2023")
        datePickerQuery.pickerWheels["July"].adjust(toPickerWheelValue: "July")
        datePickerQuery.pickerWheels["30"].adjust(toPickerWheelValue: "30")
        
        app.keyboards.buttons["return"].tap()
        
        app.buttons["Save"].tap()
        
        XCTAssertTrue(app.tables.staticTexts["Meeting"].exists)
        XCTAssertTrue(app.tables.staticTexts["Shivajinagar, Pune"].exists)
        XCTAssertTrue(app.tables.staticTexts["This is testing description"].exists)
    }
}
