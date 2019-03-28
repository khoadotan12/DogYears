//
//  DogYearsUnitTests.swift
//  DogYearsUnitTests
//
//  Created by Đỗ Tấn Khoa on 3/24/19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import XCTest
@testable import DogYears

class DogYearsUnitTests: XCTestCase {
    
    let calc = Calculator()
    var resData: Data? = nil
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMenuLoadPerformance() {
        var menu = Menu()
        self.measure {
            menu.loadDefaultMenu()
        }
    }
    
    func testMenuFailing() {
        var menu = Menu()
        menu.loadMenu(path: "Dummy.plist")
        let count = menu.count
        XCTAssert(count == 0, "Menu loaded menu items for non-existent menu file")
    }
    
    func testAdd() {
        let result = calc.evaluate(op: "+", arg1: 4.5, arg2: 9.0)
        XCTAssert(result == 13.5, "Calculator add operation failed")
    }
    
    func testSubtraction() {
        let result = calc.evaluate(op: "-", arg1: 5, arg2: 7.3)
        XCTAssert(result == -2.3, "Calculator Subtraction operation failed")
    }
    
    func testResult() {
        let result = calc.evaluate(op: "+", arg1: 2.0, arg2: 2.0)
        let result2 = calc.result
        XCTAssert(result == result2, "Calculator displayed result does not match calculation result")
    }
    
    func testClear() {
        calc.clear()
        let result = calc.result
        XCTAssert(result == 0.0, "Calculator clear operation failed")
    }
    
    func testInfoLoading() {
        let url = "https://raw.githubusercontent.com/FahimF/Test/master/DogYears-Info.rtf"
        let session = MockSession()
        let client = HTTPClient(session: session)
        client.get(url: url) {(data, error) in
            self.resData = data
        }
        let pred = NSPredicate(format: "resData != nil")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let res = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if res == XCTWaiter.Result.completed {
            XCTAssertNotNil(resData, "No data received received from the server for InfoView content")
        } else {
            XCTAssert(false, "The call to get the URL ran into some other error")
        }
    }
    
    func testSettingsScreen() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(sb, "Could not instantiate storyboard for Setting")
        let vc = sb.instantiateViewController(withIdentifier: "SettingsView") as? SettingsViewController
        XCTAssertNotNil(vc, "Could not instantiate Settings view controller")
        _ = vc?.view
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
