//
//  quietMINDTests.swift
//  quietMINDTests
//
//  Created by Ameen Mustafa on 3/2/23.
//

import XCTest
@testable import quietMIND

// testing structure: GIVEN, WHEN, THEN
final class quietMINDViewModel_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_quietMINDTimerVM_timerIsRunning_shouldBeTrue() {
        
        // GIVEN
        
        // WHEN
        let vm = TimerViewModel()
        let firstTime = vm.getTimerVal()
        vm.startTimer()
        
        // THEN
        execute(after: 3.0) {
            let secondTime = vm.getTimerVal()
            XCTAssertLessThan(secondTime, firstTime)
        }
    }
    
    func test_quietMINDTimerVM_timerIsPaused_shouldBeTrue(){
        // GIVEN
        
        // WHEN
        let vm = TimerViewModel()
        vm.startTimer()
        vm.pressPause()
        let isPaused = vm.getPaused()
        // THEN
        XCTAssertTrue(isPaused)
    }
    
    func test_quietMINDTimerVM_timerIsPlayingAfterUnpaused_shouldBeTrue(){
        // GIVEN
        
        // WHEN
        let vm = TimerViewModel()
        vm.startTimer()
        let firstTime = vm.getTimerVal()
        vm.pressPause()
        vm.pressPause()
        let isPlaying = vm.getPaused()
        
        // THEN
        XCTAssertFalse(isPlaying)
    }

}

extension XCTestCase {
    
    func execute(after: TimeInterval, testBlock: () -> Void){
        let result = XCTWaiter.wait(for: [expectation(description: "Delayed Test")], timeout: after)

            if result == XCTWaiter.Result.timedOut {
                testBlock()
            } else {
                XCTFail("Delay interrupted.")
            }
    }
}
