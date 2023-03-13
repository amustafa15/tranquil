//
//  quietMIND_Watch_AppUITests.swift
//  quietMIND Watch AppUITests
//
//  Created by Ameen Mustafa on 1/15/22.
//

import XCTest

// structure: GIVEN, WHEN, THEN
class quietMIND_Watch_AppUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // so basically this clicks the start session in the homeview with default timer settings
    // test is successful if it goes to timer page
    func test_quietMIND_Watch_AppInitialView_tapStartSession() {
        let button = app.buttons["Go"]
        button.tap()
        
        // if the session has started then the pause button is visible
        let pauseBtn = app.images["pause.circle"]
        XCTAssertTrue(pauseBtn.waitForExistence(timeout: 3))
    }
    
    // if pause btn works then play btn is visible
    func test_quietMIND_Watch_AppTimerViewBtns_PauseBtnWorks() {
        let button = app.buttons["Go"]
        button.tap()
        
        let pauseBtn = app.images["pause.circle"]
        XCTAssertTrue(pauseBtn.waitForExistence(timeout: 3))
        pauseBtn.tap()
        let playBtn = app.images["play.circle"]
        XCTAssertTrue(playBtn.waitForExistence(timeout: 3))
    }
    
    // if cancel btn works it goes back to home view
    func test_quietMIND_Watch_AppTimerButtonsView_CancelBtnWorks(){
        let button = app.buttons["Go"]
        button.tap()
        
        let cancel = app.images["cancel.circle"]
        XCTAssertTrue(cancel.waitForExistence(timeout: 3))
        cancel.tap()
        XCTAssertTrue(button.waitForExistence(timeout: 3))
    }
    
    // adjusts selected picker value to 3 minutes
    func test_quietMIND_Watch_AppMinutesPicker_CanBeAdjusted(){
        let timePicker = app.otherElements["TimePicker"]
        timePicker.swipeUp(velocity: 50)
        timePicker.swipeUp(velocity: 50)
        let button = app.buttons["Go"]
        button.tap()
        
        XCTAssertEqual(app.staticTexts.element.label, "03:00")
    }
    
    func test_quietMIND_Watch_AppSoundsPicker_CanBeAdjusted(){
        let soundPicker = app.otherElements["SoundsPicker"]
        soundPicker.swipeUp(velocity: 50)
        
        XCTAssertEqual(soundPicker.value as! String, "Light Rain")
    }
    
    // only good quotes for now
    func test_quietMIND_Watch_AppQuotes_quoteAppearsAfterSession(){
        let authors = ["Oprah", "Nelson Mandela", "Albert Einstein", "Charles Bukwoski", "Teddy Roosevelt", "William Faulkner"]
        
        let button = app.buttons["Go"]
        button.tap()
        
        let quoteAuthorText = app.staticTexts["quoteAuthor"]
        quoteAuthorText.waitForExistence(timeout: 65)
        var author = ""
        for i in 0..<authors.count {
            if quoteAuthorText.label == "- \(authors[i])" {
                author = authors[i]
            }
        }
        XCTAssertEqual(quoteAuthorText.label, "- \(author)")
    }
    
    func test_quietMIND_Watch_App_PostSessionView_backToHome(){
        let button = app.buttons["Go"]
        button.tap()
        
        let goodJobBtn = app.buttons["goodJobBtn"]
        goodJobBtn.waitForExistence(timeout: 65)
        goodJobBtn.tap()
        
        let homeBtn = app.buttons["HomeBtn"]
        homeBtn.waitForExistence(timeout: 3)
        homeBtn.tap()
        
        XCTAssert(button.waitForExistence(timeout: 3))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
