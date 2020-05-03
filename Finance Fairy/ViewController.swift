//
//  ViewController.swift
//  Finance Fairy
//
//  Created by Harsh Dawda on 2020-05-02.
//  Copyright © 2020 TOHacks. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Location: UITextField!
    @IBOutlet weak var Age: UITextField!
    @IBOutlet weak var Next: UIButton!
    
    static var UserName = ""
    var ref: DatabaseReference! = Database.database().reference()
    var pickerProvinceData: [String] = [String]()
    var pickerAgeData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        Name.tag = 1
        Location.tag = 2
        Age.tag = 3
        
        let locationPicker = UIPickerView()
        locationPicker.tag = 1
        Location.inputView = locationPicker
        locationPicker.delegate = self
        
        let agePicker = UIPickerView()
        agePicker.tag = 2
        Age.inputView = agePicker
        agePicker.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        Location.inputAccessoryView = toolBar
        Age.inputAccessoryView = toolBar
        
        pickerProvinceData = ["Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island", "Quebec", "Saskatchewan"]
        pickerAgeData = ["Under 21", "Between 21 and 30","Between 31 and 40","Between 41 and 50","Between 51 and 60","Over 60"]
    }
    
    @objc func action() {
          view.endEditing(true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if ((Name.text ?? "").isEmpty || (Age.text ?? "").isEmpty || (Location.text ?? "").isEmpty) {
                   return
        }
        ref.child("Users").child(Name.text ?? "").setValue(["Location" : Location.text])
        ref.child("Users/\(Name.text ?? "")/Age").setValue(Age.text)
        ViewController.UserName = (Name.text ?? "")
        let storyBoard : UIStoryboard = UIStoryboard(name: "IncomeScreen", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "IncomeScreenViewController") as! IncomeScreenViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return pickerProvinceData.count
        }
        return pickerAgeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 1 ? pickerProvinceData[row] : pickerAgeData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let response = pickerView.tag == 1 ? pickerProvinceData[row] : pickerAgeData[row]
        if pickerView.tag == 1 {
            Location.text = response
        }
        else {
            Age.text = response
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

