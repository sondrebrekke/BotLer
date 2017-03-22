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
        
        //Denne testen sjekker at alt fungerer som det skal når student skal gi tilbakemelding etter å ha deltatt i forelesning.
        
        let app = XCUIApplication()
        app.tabBars.buttons["Feedback"].tap()
        app.buttons["Choose subject"].tap()
        app.tables.staticTexts["TDT4140 - Programvareutvikling"].tap()
        
        //Tester om yesButton er valgt etter klikk, og at noButton ikke er valgt når yesButton er valgt
        let yesButton = app.buttons["Yes"]
        let noButton = app.buttons["No"]
        let justRightButton = app.buttons["Just right"]
        let tooSlowButton = app.buttons["Too slow"]
        let tooFastButton = app.buttons["Too fast"]
        XCTAssertEqual(yesButton.isSelected, false)
        XCTAssertEqual(noButton.isSelected, false)
        yesButton.tap()
        XCTAssertEqual(yesButton.isSelected, true)
        XCTAssertEqual(noButton.isSelected, false)
        
        
        //Tester om justRightButton er valgt etter klikk, og at tooSlowButton og tooFastButton ikke er valgt når justRightButton er valgt
        XCTAssertEqual(justRightButton.isSelected, false)
        XCTAssertEqual(tooSlowButton.isSelected, false)
        XCTAssertEqual(tooFastButton.isSelected, false)
        justRightButton.tap()
        XCTAssertEqual(justRightButton.isSelected, true)
        XCTAssertEqual(tooSlowButton.isSelected, false)
        XCTAssertEqual(tooFastButton.isSelected, false)
        
        app.buttons["SUBMIT"].tap()
        app.buttons["Back"].tap()
        
        
    }
    
    func testDidNotAttendLecture() {
        
        //Denne testen sjekker at alt fungerer som det skal når student skal gi tilbakemelding etter å ikke ha deltatt i forelesning.
        
        
        
    }
    
}
