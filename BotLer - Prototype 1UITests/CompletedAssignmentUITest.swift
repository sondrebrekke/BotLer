//
//  CompletedAssignmentUITest.swift
//  BotLer - Prototype 1
//
//  Created by Jørgen Frost Bø on 21.04.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import XCTest


class CompletedAssignmentUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
            
            
            let app = XCUIApplication()
            
            
            
            let completedAssignment = app.buttons["Complete"]
            
            
            let tablesQuery = XCUIApplication().tables
            tablesQuery.children(matching: .cell).element(boundBy: 1).children(matching: .staticText).element.swipeLeft()
            
            XCTAssertEqual(completedAssignment.exists, false)
            
            XCTAssertEqual(completedAssignment.isSelected, true)
            
            tablesQuery.buttons["Complete"].tap()
            
            
            XCTAssertEqual(completedAssignment.isSelected, true)
            
            
        
    }
    
}
