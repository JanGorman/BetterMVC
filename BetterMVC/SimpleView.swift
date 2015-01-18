//
//  MainView.swift
//  BetterMVC
//
//  Created by Jan Gorman on 14/01/2015.
//  Copyright (c) 2015 Schnaub. All rights reserved.
//

import UIKit

class SimpleView: UIView {

    private var context = 0

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = ""
        }
    }

    weak var controller: SimpleController!
    weak var model: SimpleModel! {
        didSet {
            model.addObserver(self, forKeyPath: "name", options: .New, context: &context)
        }
    }

    deinit {
        model.removeObserver(self, forKeyPath: "name", context: &context)
    }

    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject:AnyObject],
                                         context: UnsafeMutablePointer<Void>) {
        if context == &self.context {
            nameLabel.text = "Hi there, \(change[NSKeyValueChangeNewKey]!)"
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }

    @IBAction func didSubmit(sender: AnyObject) {
        controller.didSubmitName(nameTextField.text)
    }

}
