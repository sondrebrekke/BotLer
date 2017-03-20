//
//  FeedbackClassUITest.swift
//  BotLer - Prototype 1
//
//  Created by Jørgen Frost Bø on 20.03.2017.
//  Copyright © 2017 Sondre Brekke. All rights reserved.
//

import XCTest

class FeedbackClassUITest: XCTestCase {
        
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
    
    func testAttendedLecture() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        
        
    
        
     /*   let app = XCUIApplication()
        app.tabBars.buttons["Feedback"].tap()
        app.buttons["Choose subject"].tap()
        app.tables.staticTexts["TMA4260 - Statistikk"].tap()
        
        
        
        //Tester om yesButton er klikket
        let yesButton = app.buttons["Yes"]
        let justRightButton = app.buttons["Just right"]
        XCTAssertEqual(yesButton.isSelected, false)
        yesButton.tap()
        XCTAssertEqual(yesButton.isSelected, true)
        
        //Tester om justRightButton er klikket
        XCTAssertEqual(justRightButton.isSelected, false)
        justRightButton.tap()
        XCTAssertEqual(justRightButton.isSelected, true)
        
        
        app.buttons["SUBMIT"].tap()
        app.buttons["Back"].tap() */
        
      
    }
    
    func testDidNotAttendLecture() {
        
    }
    
}
