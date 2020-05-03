//
//  EmergencyViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-03.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts

class EmergencyViewController: UIViewController {
    @IBOutlet weak var debtTextField: UITextField!
    @IBOutlet weak var recLabel: UILabel!
    
    var ref: DatabaseReference! = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Emergency Funds"
        debtTextField.isEnabled = false
        ref.child("Users/\(ViewController.UserName)/Debt").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let highInterest = value?["High Interest"] as? Bool ?? false
            if highInterest {
                self.debtTextField.text = "have"
                self.recLabel.text = "You should start with a smaller emergency fund of two months' expenses while paying off your high-interest debt."
            } else {
                self.debtTextField.text = "don't have"
                self.recLabel.text = "It is recommended that you establish an emergency fund of six months' expenses in this account."
            }
            }) { (error) in
                print(error.localizedDescription)
            }
    }
    
    @IBAction func debtManagementPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Debt", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "DebtViewController") as! DebtViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
