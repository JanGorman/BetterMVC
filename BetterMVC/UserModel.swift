//
//  UserModel.swift
//  BetterMVC
//
//  Created by Jan Gorman on 18/01/15.
//  Copyright (c) 2015 Schnaub. All rights reserved.
//

import Foundation


public struct UserModelError {

    static let ValidationError = -1
    static let ErrorDomain = "com.schnaub.UserModelError"

}

@objc public protocol UserModelObserver {

    func failedValidationWithError(error: NSError)

}

public class UserModel {

    private var observers = NSMutableSet()

    public var firstName: String?
    public var lastName: String?

    public init() {
    }

    public func validate() {
        var validationErrors = [String: String]()
        if firstName == nil || countElements(firstName!) == 0 {
            validationErrors["firstName"] = "Invalid firstName"
        }
        if lastName == nil || countElements(lastName!) == 0 {
            validationErrors["lastName"] = "Invalid lastName"
        }
        if validationErrors.count > 0 {
            let error = NSError(domain: UserModelError.ErrorDomain, code: UserModelError.ValidationError,
                    userInfo: validationErrors)
            notifyObserversOfValidationError(error)
        }
    }

    public func addObserver(observer: UserModelObserver) {
        observers.addObject(observer)
    }

    public func removeObserver(observer: UserModelObserver) {
        observers.removeObject(observer)
    }

    private func notifyObserversOfValidationError(error: NSError) {
        for observer in observers.allObjects as [UserModelObserver] {
            observer.failedValidationWithError(error)
        }
    }

}
