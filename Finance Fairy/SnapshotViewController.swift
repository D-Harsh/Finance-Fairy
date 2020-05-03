//
//  SnapshotViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-03.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Charts

class SnapshotViewController: UIViewController {
    
    @IBOutlet weak var snapshotPieGraph: PieChartView!
    @IBOutlet weak var hello: UILabel!
    @IBOutlet weak var budget: UIButton!
    
    var ref: DatabaseReference! = Database.database().reference()
    var incomeDataEntry = PieChartDataEntry(value: 0)
    var expensesDataEntry = PieChartDataEntry(value: 0)
    var financialBreakdown = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = "Snapshot"
        hello.text = "Hello \(ViewController.UserName),"
        snapshotPieGraph.chartDescription?.text = ""
        ref.child("Users/\(ViewController.UserName)/Income").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let totalIncome = value?["Total Income"] as? String ?? ""
            self.incomeDataEntry.value = Double(totalIncome.suffix(totalIncome.count-1))!
            self.incomeDataEntry.label = "Income"
        }) { (error) in
            print(error.localizedDescription)
        }
        ref.child("Users/\(ViewController.UserName)/Expenses").observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let totalExpenses = value?["Total"] as? String ?? ""
            self.expensesDataEntry.value = Double(totalExpenses.suffix(totalExpenses.count-1))!
            self.expensesDataEntry.label = "Expenses"
            self.financialBreakdown = [self.incomeDataEntry, self.expensesDataEntry]
            let chartDataSet = PieChartDataSet(entries: self.financialBreakdown, label: nil)
            let chartData = PieChartData(dataSet: chartDataSet)
            let colors = [UIColor.systemTeal, UIColor.systemRed]
            chartDataSet.colors = colors
            self.snapshotPieGraph.data = chartData
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func budgetButtonPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Budgeting", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "BudgetingViewController") as! BudgetingViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
