//
//  RetirementViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-03.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts

class RetirementViewController: UIViewController {
    @IBOutlet weak var recLabel: UILabel!
    
    var ref: DatabaseReference! = Database.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Retirement"
        var totalIncome: Double = 0
        ref.child("Users/\(ViewController.UserName)/Income").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let totalIncomeStr = value?["Total Income"] as? String ?? ""
            totalIncome = Double(totalIncomeStr.suffix(totalIncomeStr.count-1))!
        }) { (error) in
            print(error.localizedDescription)
        }
        ref.child("Users/\(ViewController.UserName)").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let totalIncomeStr = value?["Age"] as? String ?? ""
            if (totalIncomeStr.contains("21") || totalIncomeStr.contains("31")) {
                self.recLabel.text = "$" + String(totalIncome * 12)
            }
            else if (totalIncomeStr.contains("41")) {
                self.recLabel.text = "$" + String((totalIncome * 12 * 3).rounded())
            }
            else if (totalIncomeStr.contains("51")) {
                self.recLabel.text = "$" + String((totalIncome * 12 * 6).rounded())
            }
            else {
                self.recLabel.text = "$" + String((totalIncome * 12 * 9).rounded())
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func otherPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Other", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "OtherViewController") as! OtherViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
