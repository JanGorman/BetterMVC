//
//  TableView.swift
//  BetterMVC
//
//  Created by Jan Gorman on 14/01/2015.
//  Copyright (c) 2015 Schnaub. All rights reserved.
//

import UIKit


class BasicTableView: UITableView, BasicTableViewModelObserver {

    weak var controller: BasicTableViewController!
    weak var model: BasicTableViewModel! {
        didSet {
            model.addObserver(self)
        }
    }

    // MARK: BasicTableViewModelObserver

    func didAddItem() {
        reloadData()
    }

}
