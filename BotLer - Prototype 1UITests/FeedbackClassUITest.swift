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

        continueAfterFailure = false
       
        XCUIApplication().launch()

      
    }
    
    override func tearDown() {
    
        super.tearDown()
    }
    
    func testAttendedLecture() {
      
        //This UI Test checks that everything works correctly when a student has been in a lecture and gives feedback to the lecturer.
   
        let app = XCUIApplication()
        
        
        
        //Initializes the relevant buttons
        let yesButton = app.buttons["Yes"]
        let noButton = app.buttons["No"]
        let justRightButton = app.buttons["Just right"]
        let tooSlowButton = app.buttons["Too slow"]
        let tooFastButton = app.buttons["Too fast"]
        
        
        app.tabBars.buttons["Feedback"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element.tap()
        app.pickerWheels["Click here to choose a subject"].swipeUp()
        
        
        
        //Tests that justRightButton, tooFastButton and tooSlowButton don't exist before yesButton is clicked.
        XCTAssertEqual(justRightButton.exists, false)
        XCTAssertEqual(tooFastButton.exists, false)
        XCTAssertEqual(tooSlowButton.exists, false)
        
        //Tests that yesButton is selected after clicked, and that noButton is not selected when yesButton is selected.
        XCTAssertEqual(yesButton.isSelected, false)
        XCTAssertEqual(noButton.isSelected, false)
        yesButton.tap()
        XCTAssertEqual(yesButton.isSelected, true)
        XCTAssertEqual(noButton.isSelected, false)
        
        
        //Tests that justRightButton, tooFastButton and tooSlowButton exist after we yesButton is selected.
        XCTAssertEqual(justRightButton.exists, true)
        XCTAssertEqual(tooFastButton.exists, true)
        XCTAssertEqual(tooSlowButton.exists, true)
        
        
        //Tests wheter justRightButton is selected after clicked, and that tooSlowButton and tooFastButton is not selected when justRightButton is selected.
        XCTAssertEqual(justRightButton.isSelected, false)
        XCTAssertEqual(tooSlowButton.isSelected, false)
        XCTAssertEqual(tooFastButton.isSelected, false)
        justRightButton.tap()
        XCTAssertEqual(justRightButton.isSelected, true)
        XCTAssertEqual(tooSlowButton.isSelected, false)
        XCTAssertEqual(tooFastButton.isSelected, false)
        
        app.buttons["SUBMIT"].tap()
        
        
    }
    
    func testDidNotAttendLecture() {
        
        
        //This UI Test checks that everything works correctly when a student has not been in a lecture and gives feedback to the lecturer.
        
        let app = XCUIApplication()
        
        //Initializes the relevant buttons on the Feedback page
        let yesButton = app.buttons["Yes"]
        let noButton = app.buttons["No"]
        let justRightButton = app.buttons["Just right"]
        let tooSlowButton = app.buttons["Too slow"]
        let tooFastButton = app.buttons["Too fast"]
        
        
        //Selects a subject
        app.tabBars.buttons["Feedback"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element.tap()
        app.pickerWheels["Click here to choose a subject"].swipeUp()
        
        
    
    
        //Testes that yesButton and noButton is not selected before noButton is clicked
        XCTAssertEqual(yesButton.isSelected, false)
        XCTAssertEqual(noButton.isSelected, false)
        
        
        //Tests that justRightButton, tooFastButton and tooSlowButton don't exist before noButton is selected.
        XCTAssertEqual(justRightButton.exists, false)
        XCTAssertEqual(tooFastButton.exists, false)
        XCTAssertEqual(tooSlowButton.exists, false)
        
        noButton.tap()
        
        //Tester that noButton is selected after clicked, and that yesButton is not selected when noButton is selected.
        XCTAssertEqual(yesButton.isSelected, false)
        XCTAssertEqual(noButton.isSelected, true)
        
        
        //Tests that justRightButton, tooFastButton and tooSlowButton still don't exist after noButton is selected.
        XCTAssertEqual(justRightButton.exists, false)
        XCTAssertEqual(tooFastButton.exists, false)
        XCTAssertEqual(tooSlowButton.exists, false)
        
        
        
        app.buttons["SUBMIT"].tap()
     
    
        
    }
}

