//
//  NowMovieUITests.swift
//  NowMovieUITests
//
//  Created by NghiaTran on 9/17/20.
//  Copyright © 2020 trungnghia. All rights reserved.
//

import XCTest

/*

Run test from commandline
xcodebuild test -workspace NowMovie.xcworkspace -scheme NowMovie -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.7'
 
xcodebuild test -workspace NowMovie.xcworkspace -scheme NowMovie -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.7' -only-testing:NowMovieUITests/Suite1

*/

class Suite1: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_select_upcoming_movies() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.buttons["To Movie List"].tap()
        sleep(3)
        app.navigationBars.buttons["flame"].tap()
        app.tables["Movie Types table"].cells.staticTexts["Upcoming Movies"].tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
