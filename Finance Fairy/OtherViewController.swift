//
//  OtherViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-03.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import Foundation

import UIKit
import FirebaseDatabase
import Charts

class OtherViewController: UIViewController {
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Other Recomendations"
    }
}
