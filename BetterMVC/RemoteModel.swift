//
//  RemoteModel.swift
//  BetterMVC
//
//  Created by Jan Gorman on 18/01/15.
//  Copyright (c) 2015 Schnaub. All rights reserved.
//

import Foundation


@objc protocol RemoteModelObserver {

    func didFinishLoading()

}

class RemoteModel {

    struct Constants {

        static let URLString = "http://jsonplaceholder.typicode.com/comments"

    }

    private var observers = NSMutableSet()

    var comments = [AnyObject]()

    func load() {
        if let URL = NSURL(string: Constants.URLString) {
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(URL) {
                (data, response, error) in
                if error != nil {
                    println("Epic Fail")
                    return
                }

                var jsonError: NSError?
                let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments,
                        error: &jsonError) as NSArray
                self.comments = json
                dispatch_async(dispatch_get_main_queue()) {
                    self.notifyObservers()
                }
            }
            task.resume()
        }
    }

    func addObserver(observer: RemoteModelObserver) {
        observers.addObject(observer)
    }

    func removeObserver(observer: RemoteModelObserver) {
        observers.removeObject(observer)
    }

    func notifyObservers() {
        for observer in observers.allObjects as [RemoteModelObserver] {
            observer.didFinishLoading()
        }
    }

}