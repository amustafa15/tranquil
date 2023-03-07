//
//  quietMIND_UITests.swift
//  quietMIND_UITests
//
//  Created by Ameen Mustafa on 3/3/23.
//

import XCTest

// tests homepage
// structure: GIVEN, WHEN, TTHEN
final class quietMIND_UITests: XCTestCase {
    
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
    func test_quietMINDHomeView_tapStartSession() {
        let button = app.buttons["Start Session"]
        button.tap()
        
        // if the session has started then the pause button is visible
        let pauseBtn = app.images["pause.circle"]
        XCTAssertTrue(pauseBtn.waitForExistence(timeout: 3))
    }
    
    // if pause btn works then play btn is visible
    func test_quietMIND_TimerButtonsView_PauseBtnWorks(){
        let button = app.buttons["Start Session"]
        button.tap()
        
        let pauseBtn = app.images["pause.circle"]
        XCTAssertTrue(pauseBtn.waitForExistence(timeout: 3))
        pauseBtn.tap()
        let playBtn = app.images["play.circle"]
        XCTAssertTrue(playBtn.waitForExistence(timeout: 3))
    }
    
    // if cancel btn works it goes back to home view
    func test_quietMIND_TimerButtonsView_CancelBtnWorks(){
        let button = app.buttons["Start Session"]
        button.tap()
        
        let cancel = app.images["cancel.circle"]
        XCTAssertTrue(cancel.waitForExistence(timeout: 3))
        cancel.tap()
        XCTAssertTrue(button.waitForExistence(timeout: 3))
    }
    
    // adjusts selected picker value to 3 minutes
    func test_quietMIND_MinutesPicker_CanBeAdjusted(){
        let pickerBtn = app.buttons["TimePicker"]
        pickerBtn.tap()
        
        let selectedTime = app.buttons["3"]
        selectedTime.tap()
        let button = app.buttons["Start Session"]
        button.tap()
        
        XCTAssertEqual(app.staticTexts.element.label, "03:00")
    }
    
    func test_quietMIND_SoundsPicker_CanBeAdjusted(){
        let tabBtn = app.tabBars.buttons["Profile"]
        tabBtn.tap()
        
        let toggleSwitch = app.switches["serialKillerToggle"]
        if !toggleSwitch.isEnabled {
            toggleSwitch.tap()
        }
        
        let homeBtn = app.tabBars.buttons["Home"]
        homeBtn.tap()
        let soundPickerBtn = app.buttons["SoundsPicker"]
        soundPickerBtn.tap()
        
        var button = app.buttons["Light Rain"]
        button.waitForExistence(timeout: 3)
        button.tap()
        soundPickerBtn.tap()
        XCTAssertTrue(button.isSelected)
    }
    
    func test_quietMIND_QuotesView_quoteAppears(){
        // needs to access variable which determines if serial killer
        // maybe check color of rounded rectangle?
        // no ui tests don't have colors
        let authors = ["Oprah", "Nelson Mandela", "Albert Einstein", "Charles Bukwoski", "Teddy Roosevelt", "William Faulkner"]
        let tabBtn = app.tabBars.buttons["Profile"]
        tabBtn.tap()
        
        let toggleSwitch = app.switches["serialKillerToggle"]
        if !toggleSwitch.isEnabled {
            toggleSwitch.tap()
        }
        
        let homeBtn = app.tabBars.buttons["Home"]
        homeBtn.tap()
        let btn = app.buttons["Start Session"]
        btn.tap()
        
        let postStatsHomeBtn = app.buttons["PostStatsHomeBtn"]
        postStatsHomeBtn.waitForExistence(timeout: 65.0)
        var quoteText = app.staticTexts["quoteText"]
        var author = ""
        
        for i in 0..<authors.count {
            if quoteText.label == "- \(authors[i])" {
                author = authors[i]
            }
        }
        XCTAssertEqual(quoteText.label, "- \(author)")
        
    }
    
    func test_quietMIND_QuotesView_quoteAppearsSerialKiller(){
        let tabBtn = app.tabBars.buttons["Profile"]
        tabBtn.tap()
        
        let toggleSwitch = app.switches["serialKillerToggle"]
        if toggleSwitch.isEnabled {
            toggleSwitch.tap()
            // if not serial killer then serial killer
        }
        
        let homeBtn = app.tabBars.buttons["Home"]
        homeBtn.tap()
        let authors = ["Oliver Cromwell", "Charles Manson", "Joseph Stalin", "Ted Bundy", "Napoleon Bonaparte"]
        let btn = app.buttons["Start Session"]
        btn.tap()
        
        let postStatsHomeBtn = app.buttons["PostStatsHomeBtn"]
        postStatsHomeBtn.waitForExistence(timeout: 65.0)
        
        var quoteText = app.staticTexts["quoteText"]
        var author = ""
        
        for i in 0..<authors.count {
            if quoteText.label == "- \(authors[i])" {
                author = authors[i]
            }
        }
        XCTAssertEqual(quoteText.label, "- \(author)")
    }
    
    func test_quietMIND_QuotesView_HomeButtonWorks(){
        let btn = app.buttons["Start Session"]
        btn.tap()
        
        let postStatsHomeBtn = app.buttons["PostStatsHomeBtn"]
        postStatsHomeBtn.waitForExistence(timeout: 65.0)
        postStatsHomeBtn.tap()
        
        btn.waitForExistence(timeout: 3)
        XCTAssertTrue(btn.exists)
    }
    
    // start a session then go back to home screen by doulbe tapping button
    func test_quietMIND_doubleTapHomeBtnWorks(){
        let btn = app.buttons["Start Session"]
        btn.tap()
        
        let tabHome = app.tabBars.buttons["Home"]
        tabHome.waitForExistence(timeout: 3)
        tabHome.tap()
        tabHome.tap()
        XCTAssertTrue(btn.exists)
    }
    
    // test if stats view button after completing session takes you to updated stats. clicks stats view btn after session
    func test_quietMIND_StatsView_statsUpdatedAfterSession(){
        let statsViewBtn = app.buttons["Stats"]
        statsViewBtn.tap()
        app.staticTexts["mindfulMinutes"].waitForExistence(timeout: 3)
        let minutes = app.staticTexts["mindfulMinutes"].label
        
        let sessions = app.staticTexts["mindfulSessions"].label
        
        let homeBtn = app.buttons["Home"]
        homeBtn.tap()
        
        let btn = app.buttons["Start Session"]
        btn.tap()
        
        let postStatsStatsBtn = app.buttons["PostStatsStatsBtn"]
        postStatsStatsBtn.waitForExistence(timeout: 65.0)
        postStatsStatsBtn.tap()
        
        app.staticTexts["mindfulMinutes"].waitForExistence(timeout: 3)
        let minutes1 = app.staticTexts["mindfulMinutes"].label
        let sessions1 = app.staticTexts["mindfulSessions"].label
        
        XCTAssertNotEqual(minutes, minutes1)
        XCTAssertNotEqual(sessions, sessions1)
    }
    
    // completes session, clicks stat view tab instead of button
    func test_quietMIND_StatsView_statsUpdatedAfterSessionFromTab(){
        let statsViewBtn = app.buttons["Stats"]
        statsViewBtn.tap()
        app.staticTexts["mindfulMinutes"].waitForExistence(timeout: 3)
        let minutes = app.staticTexts["mindfulMinutes"].label
        
        let sessions = app.staticTexts["mindfulSessions"].label
        
        let homeBtn = app.buttons["Home"]
        homeBtn.tap()
        
        let btn = app.buttons["Start Session"]
        btn.tap()
        
        let postStatsStatsBtn = app.buttons["PostStatsStatsBtn"]
        postStatsStatsBtn.waitForExistence(timeout: 65.0)
        statsViewBtn.waitForExistence(timeout: 3)
        statsViewBtn.tap()
        
        app.staticTexts["mindfulMinutes"].waitForExistence(timeout: 3)
        let minutes1 = app.staticTexts["mindfulMinutes"].label
        let sessions1 = app.staticTexts["mindfulSessions"].label
        
        XCTAssertNotEqual(minutes, minutes1)
        XCTAssertNotEqual(sessions, sessions1)
    }
    
    // tests if theme can be changed
    func test_quietMIND_ProfileView_themeChange(){
        let tabBtn = app.tabBars.buttons["Profile"]
        tabBtn.tap()
        
        let toggleSwitch = app.switches["serialKillerToggle"]
        toggleSwitch.tap()
        let text = app.staticTexts["showText"].label
        toggleSwitch.tap()
        let text1 = app.staticTexts["showText"].label
        // these have 2 different text values depending on toggle
        // so they should not be equal if they are different
        XCTAssertNotEqual(text, text1)
    }

    // if you are a serial killer you have serial killer sounds
    func test_quietMIND_SoundsPicker_yesSerialKillerSoundsWhenNotSerialKillerSelected(){
        let tabBtn = app.tabBars.buttons["Profile"]
        tabBtn.tap()
        
        let toggleSwitch = app.switches["serialKillerToggle"]
        if toggleSwitch.isEnabled {
            toggleSwitch.tap()
        }
        
        let homeBtn = app.tabBars.buttons["Home"]
        homeBtn.tap()
        
        let soundPickerBtn = app.buttons["SoundsPicker"]
        soundPickerBtn.tap()
        
        var button = app.buttons["Creepy Kids"]
        button.waitForExistence(timeout: 3)
        button.tap()
        soundPickerBtn.tap()
        XCTAssertTrue(button.isSelected)
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
