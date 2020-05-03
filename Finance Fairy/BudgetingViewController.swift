//
//  BudgetingViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-03.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts

class BudgetingViewController: UIViewController {
    
    @IBOutlet weak var expensesPieChart: PieChartView!
    @IBOutlet weak var totalExpensesLabel: UILabel!
    @IBOutlet weak var incomeComparison: UITextField!
    @IBOutlet weak var recommendation: UILabel!
    
    var ref: DatabaseReference! = Database.database().reference()
    var childcareDataEntry = PieChartDataEntry(value: 0)
    var entDataEntry = PieChartDataEntry(value: 0)
    var foodDataEntry = PieChartDataEntry(value: 0)
    var healthDataEntry = PieChartDataEntry(value: 0)
    var homeDataEntry = PieChartDataEntry(value: 0)
    var otherDataEntry = PieChartDataEntry(value: 0)
    var personalDataEntry = PieChartDataEntry(value: 0)
    var transportDataEntry = PieChartDataEntry(value: 0)
    var financialBreakdown = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Budgeting"
        var totalIncome: Double = 0
        var totalExpenses: Double = 0
        incomeComparison.isEnabled = false
        ref.child("Users/\(ViewController.UserName)/Income").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let totalIncomeStr = value?["Total Income"] as? String ?? ""
            totalIncome = Double(totalIncomeStr.suffix(totalIncomeStr.count-1))!
        }) { (error) in
            print(error.localizedDescription)
        }
        ref.child("Users/\(ViewController.UserName)/Expenses").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let totalExpensesStr = value?["Total"] as? String ?? ""
            totalExpenses = Double(totalExpensesStr.suffix(totalExpensesStr.count-1))!
            
            let childcareData = value?["Childcare"] as? String ?? ""
            self.childcareDataEntry.value = Double(childcareData.suffix(childcareData.count-1))!
            self.childcareDataEntry.label = "Childcare"
            
            let entData = value?["Entertainment"] as? String ?? ""
            self.entDataEntry.value = Double(entData.suffix(entData.count-1))!
            self.entDataEntry.label = "Entertainment"
            
            let foodData = value?["Food"] as? String ?? ""
            self.foodDataEntry.value = Double(foodData.suffix(foodData.count-1))!
            self.foodDataEntry.label = "Food"
            
            let healthData = value?["Health"] as? String ?? ""
            self.healthDataEntry.value = Double(healthData.suffix(healthData.count-1))!
            self.healthDataEntry.label = "Health"
            
            let homeData = value?["Home"] as? String ?? ""
            self.homeDataEntry.value = Double(homeData.suffix(homeData.count-1))!
            self.homeDataEntry.label = "Home"
            
            let otherData = value?["Other"] as? String ?? ""
            self.otherDataEntry.value = Double(otherData.suffix(otherData.count-1))!
            self.otherDataEntry.label = "Other"
            
            let personalData = value?["Personal"] as? String ?? ""
            self.personalDataEntry.value = Double(personalData.suffix(personalData.count-1))!
            self.personalDataEntry.label = "Personal"
            
            let transportData = value?["Transport"] as? String ?? ""
            self.transportDataEntry.value = Double(transportData.suffix(transportData.count-1))!
            self.transportDataEntry.label = "Transport"
            
            self.financialBreakdown = [self.childcareDataEntry, self.entDataEntry, self.foodDataEntry, self.healthDataEntry, self.homeDataEntry, self.otherDataEntry, self.personalDataEntry, self.transportDataEntry]
            let chartDataSet = PieChartDataSet(entries: self.financialBreakdown, label: nil)
            let chartData = PieChartData(dataSet: chartDataSet)
            let colors = [UIColor.systemTeal, UIColor.systemRed, UIColor.systemBlue, UIColor.systemGray, UIColor.systemPink, UIColor.systemGreen, UIColor.systemIndigo, UIColor.systemOrange]
            chartDataSet.colors = colors
            self.expensesPieChart.data = chartData
            if (totalIncome > totalExpenses) {
                self.incomeComparison.text? = "greater than"
                self.recommendation.text = "You've passed the first step but there may still be some room for improvement! Try to identify areas where your spending can be reduced to have money for the next steps! You may click the emergency fund icon."
            }
            else if (totalIncome == totalExpenses) {
                self.incomeComparison.text? = "equal to"
                self.recommendation.text = "Look at the different categories of expenses to analyze which items are needs vs. wants to reduce your spending. This includes items in entertainment or eating out! You cannot proceed to the next step yet."
            }
            else {
                self.incomeComparison.text? = "less than"
                self.recommendation.text = "Look at the different categories of expenses to analyze which items are needs vs. wants to reduce your spending. This includes items in entertainment or eating out! You cannot proceed to the next step yet."
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    @IBAction func emergencyButtonPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Emergency", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "EmergencyViewController") as! EmergencyViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
