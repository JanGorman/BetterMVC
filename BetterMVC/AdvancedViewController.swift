//
//  AdvancedViewController.swift
//  BetterMVC
//
//  Created by Jan Gorman on 18/01/15.
//  Copyright (c) 2015 Schnaub. All rights reserved.
//

import UIKit


class AdvancedViewController: UIViewController {

    let userModel = UserModel()
    let remoteModel = RemoteModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        let advancedView = view as AdvancedView
        advancedView.controller = self
        advancedView.userModel = userModel
        advancedView.remoteModel = remoteModel
    }

    func submit(#firstName: String, lastName: String) {
        userModel.firstName = firstName
        userModel.lastName = lastName
        userModel.validate()
    }

    func load() {
        remoteModel.load()
    }

}
