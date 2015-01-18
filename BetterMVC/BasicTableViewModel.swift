//
//  BasicTableViewModel.swift
//  BetterMVC
//
//  Created by Jan Gorman on 14/01/2015.
//  Copyright (c) 2015 Schnaub. All rights reserved.
//

import Foundation

@objc protocol BasicTableViewModelObserver {

    func didAddItem()

}

class BasicTableViewModel {

    private var items = [String]()
    private var observers = NSMutableSet()

    func numberOfItems() -> Int {
        return items.count
    }

    func addItem(item: String) {
        items.append(item)
        notifyObservers()
    }

    func item(row: Int) -> String? {
        if row < 0 || row >= numberOfItems() {
            return nil
        }
        return items[row]
    }

    func addObserver(observer: BasicTableViewModelObserver) {
        observers.addObject(observer)
    }

    func removeObserver(observer: BasicTableViewModelObserver) {
        observers.removeObject(observer)
    }

    func notifyObservers() {
        for observer in observers.allObjects as [BasicTableViewModelObserver] {
            observer.didAddItem()
        }
    }

}