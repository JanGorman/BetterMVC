//
//  ViewController.swift
//  BetterMVC
//
//  Created by Jan Gorman on 14/01/2015.
//  Copyright (c) 2015 Schnaub. All rights reserved.
//

import UIKit


protocol SimpleController: class {

    func didSubmitName(name: String)

}

class SimpleViewController: UIViewController, SimpleController {

    let model = SimpleModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let mainView = self.view as SimpleView
        mainView.controller = self
        mainView.model = model
    }

    func didSubmitName(name: String) {
        model.name = name
    }

}

