//
//  IncomeScreenViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-03.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase

class IncomeScreenViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var earnedIncome: UITextField!
    @IBOutlet weak var otherIncome: UITextField!
    var ref: DatabaseReference! = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Monthly Income"
    }
    @IBAction  func nextButtonPressed(_ sender: Any) {
        if ((earnedIncome.text ?? "").isEmpty || (otherIncome.text ?? "").isEmpty) {
            return
        }
        ref.child("Users/\(ViewController.UserName)/Income/Earned Income").setValue("$\(earnedIncome.text ?? "$0")")
        ref.child("Users/\(ViewController.UserName)/Income/Other Income").setValue("$\(otherIncome.text ?? "$0")")
        let totalIncome = Int(earnedIncome.text!)! + Int(otherIncome.text!)!
        ref.child("Users/\(ViewController.UserName)/Income/Total Income").setValue("$\(totalIncome)")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Expenses", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "ExpensesViewController") as! ExpensesViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
