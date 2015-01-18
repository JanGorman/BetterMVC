//
//  BetterMVCTests.swift
//  BetterMVCTests
//
//  Created by Jan Gorman on 14/01/2015.
//  Copyright (c) 2015 Jan Gorman. All rights reserved.
//

import UIKit
import XCTest
import BetterMVC

class UserModelTests: XCTestCase, UserModelObserver {

    var model: UserModel!
    var error: NSError?

    override func setUp() {
        super.setUp()
        model = UserModel()
        model.addObserver(self)
    }

    func assertError() {
        XCTAssertNotNil(error)
        XCTAssertNotNil(error?.userInfo)
    }

    func testFirstAndLastNameAreNil() {
        model.validate()

        assertError()
        if let userInfo = error?.userInfo? {
            XCTAssertNotNil(userInfo["firstName"])
            XCTAssertNotNil(userInfo["lastName"])
        }
    }

    func testLastNameIsNil() {
        model.firstName = "First"

        model.validate()

        assertError()
        if let userInfo = error?.userInfo? {
            XCTAssertNil(userInfo["firstName"])
            XCTAssertNotNil(userInfo["lastName"])
        }
    }

    func testFirstNameIsNil() {
        model.lastName = "Last"

        model.validate()

        assertError()
        if let userInfo = error?.userInfo? {
            XCTAssertNotNil(userInfo["firstName"])
            XCTAssertNil(userInfo["lastName"])
        }
    }

    func testFirstAndLastNameNotNil() {
        model.firstName = "First"
        model.lastName = "Last"

        model.validate()

        XCTAssertNil(error)
    }

    func failedValidationWithError(error: NSError) {
        self.error = error
    }

}
