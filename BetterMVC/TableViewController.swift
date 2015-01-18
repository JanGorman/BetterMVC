//
//  TableViewController.swift
//  BetterMVC
//
//  Created by Jan Gorman on 14/01/2015.
//  Copyright (c) 2015 Schnaub. All rights reserved.
//

import UIKit

protocol BasicTableViewController: class {

}

class TableViewController: UITableViewController, BasicTableViewController {

    let model = BasicTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = tableView as BasicTableView
        view.controller = self
        view.model = model
    }

    @IBAction func addItem(sender: AnyObject) {
        model.addItem("New row @ \(NSDate())")
    }

}

extension TableViewController {

    // MARK: UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfItems()
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        if let item = model.item(indexPath.row) {
            cell.textLabel?.text = item
        }
        return cell
    }

}
