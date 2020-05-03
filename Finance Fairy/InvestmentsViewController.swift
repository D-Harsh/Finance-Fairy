//
//  InvestmentsViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-03.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InvestmentsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emergencyFund: UITextField!
    @IBOutlet weak var cash: UITextField!
    @IBOutlet weak var savings: UITextField!
    @IBOutlet weak var interestRate: UITextField!
    @IBOutlet weak var tfsa: UITextField!
    @IBOutlet weak var rrsp: UITextField!
    @IBOutlet weak var other: UITextField!
        
    @IBOutlet weak var emgCash: UISwitch!
    @IBOutlet weak var emgsavings: UISwitch!
    @IBOutlet weak var emginvest: UISwitch!
    @IBOutlet weak var emgOther: UISwitch!
    
    @IBOutlet weak var RESP: UISwitch!
    @IBOutlet weak var GIC: UISwitch!
    @IBOutlet weak var mutualFunds: UISwitch!
    @IBOutlet weak var bonds: UISwitch!
    @IBOutlet weak var ETFs: UISwitch!
    @IBOutlet weak var stocks: UISwitch!
    @IBOutlet weak var otherInvestments: UISwitch!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var ref: DatabaseReference! = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Investments and Savings"
    }
    
    @IBAction  func nextButtonPressed(_ sender: Any) {
        if ((emergencyFund.text ?? "").isEmpty || (cash.text ?? "").isEmpty || (savings.text ?? "").isEmpty || (interestRate.text ?? "").isEmpty || (tfsa.text ?? "").isEmpty || (rrsp.text ?? "").isEmpty || (other.text ?? "").isEmpty) {
            return
        }
        //1
        ref.child("Users/\(ViewController.UserName)/Emergency Fund/Amount").setValue("$\(emergencyFund.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Emergency Fund/Cash").setValue(emgCash.isOn)
        ref.child("Users/\(ViewController.UserName)/Emergency Fund/Savings").setValue(emgsavings.isOn)
        ref.child("Users/\(ViewController.UserName)/Emergency Fund/Investment").setValue(emginvest.isOn)
        ref.child("Users/\(ViewController.UserName)/Emergency Fund/Other").setValue(emgOther.isOn)
        //2,3,4
        ref.child("Users/\(ViewController.UserName)/Cash").setValue("$\(cash.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Savings Account/Amount").setValue("$\(savings.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Savings Account/Interest Rate").setValue("\(interestRate.text ?? "0")%")
        ref.child("Users/\(ViewController.UserName)/Tax Free/TFSA").setValue("$\(tfsa.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Tax Free/RRSP").setValue("$\(rrsp.text ?? "0")")
        //5
        ref.child("Users/\(ViewController.UserName)/Other Investments/Amount").setValue("$\(other.text ?? "0")")
        ref.child("Users/\(ViewController.UserName)/Other Investments/RESP").setValue(RESP.isOn)
        ref.child("Users/\(ViewController.UserName)/Other Investments/GIC").setValue(GIC.isOn)
        ref.child("Users/\(ViewController.UserName)/Other Investments/MutualFunds").setValue(RESP.isOn)
        ref.child("Users/\(ViewController.UserName)/Other Investments/Bonds").setValue(bonds.isOn)
        ref.child("Users/\(ViewController.UserName)/Other Investments/ETFs").setValue(ETFs.isOn)
        ref.child("Users/\(ViewController.UserName)/Other Investments/Stocks").setValue(RESP.isOn)
        ref.child("Users/\(ViewController.UserName)/Other Investments/Other").setValue(otherInvestments.isOn)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Snapshot", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "SnapshotViewController") as! SnapshotViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

