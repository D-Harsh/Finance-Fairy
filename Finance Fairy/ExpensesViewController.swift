//
//  ExpensesViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-03.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ExpensesViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var home: UITextField!
    @IBOutlet weak var food: UITextField!
    @IBOutlet weak var transport: UITextField!
    @IBOutlet weak var health: UITextField!
    @IBOutlet weak var childcare: UITextField!
    @IBOutlet weak var entertainment: UITextField!
    @IBOutlet weak var personal: UITextField!
    @IBOutlet weak var other: UITextField!
    @IBOutlet weak var highInterestDebt: UISwitch!
    @IBOutlet weak var moderateInterestDebt: UISwitch!
    @IBOutlet weak var lowInterestDebt: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    
    var ref: DatabaseReference! = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Monthly Expenses"
    }
    
    @IBAction  func nextButtonPressed(_ sender: Any) {
        if ((home.text ?? "").isEmpty || (food.text ?? "").isEmpty || (transport.text ?? "").isEmpty || (health.text ?? "").isEmpty || (childcare.text ?? "").isEmpty || (entertainment.text ?? "").isEmpty || (personal.text ?? "").isEmpty || (other.text ?? "").isEmpty) {
            return
        }
        ref.child("Users/\(ViewController.UserName)/Expenses/Home").setValue("$\(home.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Expenses/Food").setValue("$\(food.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Expenses/Transport").setValue("$\(transport.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Expenses/Health").setValue("$\(health.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Expenses/Childcare").setValue("$\(childcare.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Expenses/Entertainment").setValue("$\(entertainment.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Expenses/Personal").setValue("$\(personal.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Expenses/Other").setValue("$\(other.text ?? "0")")
        var totalExpenses = Int(home.text ?? "0")! + Int(food.text ?? "0")! + Int(transport.text ?? "0")! + Int(health.text ?? "0")!
        totalExpenses = totalExpenses + Int(childcare.text ?? "0")! + Int(entertainment.text ?? "0")!
        totalExpenses = totalExpenses + Int(personal.text ?? "0")! + Int(other.text ?? "0")!
        ref.child("Users/\(ViewController.UserName)/Expenses/Total").setValue("$\(totalExpenses)")
        ref.child("Users/\(ViewController.UserName)/Debt/High Interest").setValue(highInterestDebt.isOn)
        ref.child("Users/\(ViewController.UserName)/Debt/Moderate Interest").setValue(moderateInterestDebt.isOn)
        ref.child("Users/\(ViewController.UserName)/Debt/Low Interest").setValue(lowInterestDebt.isOn)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Investments", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "InvestmentsViewController") as! InvestmentsViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

