//
//  DebtViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-03.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts

class DebtViewController: UIViewController {
    @IBOutlet weak var recLabel: UILabel!
    var ref: DatabaseReference! = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Debt Management"
        recLabel.isEnabled = false
        ref.child("Users/\(ViewController.UserName)/Debt").observeSingleEvent(of: .value, with: {(snapshot) in
        let value = snapshot.value as? NSDictionary
        let highInterest = value?["High Interest"] as? Bool ?? false
        if highInterest {
            self.recLabel.text = "Since you have high interest debt:\n\n1. Focus your extra money to pay down your high-interest debt (interest rate of 10% or higher)\n\n2. Go back to step two and raise the amount in your emergency fund to 6 months of expenses."
        } else {
            self.recLabel.text = "Since you don't have high interest debt:\n\n1. Focus your extra money to pay down your moderate-interest debt (interest rate of 5% or higher, excluding mortgages)\n\n2. Resume to step four: planning for large purchases and retirement."
        }
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    @IBAction func didPressRetirement(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Retirement", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "RetirementViewController") as! RetirementViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
