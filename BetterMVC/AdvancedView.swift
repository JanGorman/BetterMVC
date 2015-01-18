//
//  AdvancedView.swift
//  BetterMVC
//
//  Created by Jan Gorman on 18/01/15.
//  Copyright (c) 2015 Schnaub. All rights reserved.
//

import UIKit


class AdvancedView: UIView, UserModelObserver, RemoteModelObserver {

    struct Constants {

        static let ErrorColor = UIColor.redColor()
        static let DefaultColor = UIColor.clearColor()

    }

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var remoteTextView: UITextView!

    weak var controller: AdvancedViewController!
    weak var userModel: UserModel! {
        didSet {
            userModel.addObserver(self)
        }
    }
    weak var remoteModel: RemoteModel! {
        didSet {
            remoteModel.addObserver(self)
        }
    }

    override func awakeFromNib() {
        remoteTextView.text = ""
    }

    func failedValidationWithError(error: NSError) {
        if let userInfo = error.userInfo {
            if userInfo["firstName"] != nil {
                setBorder(firstNameTextField, color: Constants.ErrorColor)
            }
            if userInfo["lastName"] != nil {
                setBorder(lastNameTextField, color: Constants.ErrorColor)
            }
        }
    }

    func setBorder(textField: UITextField, color: UIColor) {
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.layer.masksToBounds = true
        textField.layer.borderColor = color.CGColor
    }

    @IBAction func submit(sender: AnyObject) {
        setBorder(firstNameTextField, color: Constants.DefaultColor)
        setBorder(lastNameTextField, color: Constants.DefaultColor)

        controller.submit(firstName: firstNameTextField.text, lastName: lastNameTextField.text)
    }

    @IBAction func load(sender: AnyObject) {
        controller.load()
    }

    func didFinishLoading() {
        let comments = remoteModel.comments as [NSDictionary]
        remoteTextView.text = comments.map {
            $0["body"] as String
        }.reduce("") {
            "\($0)\n\($1)"
        }
    }

}
