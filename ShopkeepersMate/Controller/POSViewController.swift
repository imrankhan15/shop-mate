//
//  POSViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/29/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log


class POSViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var startingAmountTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var unit: UITextField!
    @IBOutlet weak var newBuyButton: UIButton!
    @IBOutlet weak var newSaleButton: UIButton!
    @IBOutlet weak var otherCostButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var records = [Record]()
    var record: Record?
    var strings = [String]()
    var values: Float = 0
    var sales: Float = 0
    var buys: Float = 0
    var costs: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 5.0
        newBuyButton.layer.cornerRadius = 5.0
        newSaleButton.layer.cornerRadius = 5.0
        otherCostButton.layer.cornerRadius = 5.0
        startingAmountTextField.delegate = self
        unit.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(POSViewController.handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
        startingAmountTextField.autocorrectionType = .no
        unit.autocorrectionType = .no
        self.tableView.separatorStyle = .none
        if let savedRecords = loadRecords() {
            records += savedRecords
        }
        else {}
        
        if records.count > 0 {
            startingAmountTextField.text = records[records.count-1].ending.description
            unit.text = records[records.count-1].unit
        }
        self.update_label_report()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        update_label_report()
        
    }
    
    private func updateSaveButtonState() {
        
        let startingAmountText = startingAmountTextField.text ?? ""
        
        let unitText = unit.text ?? ""
        
        saveButton.isEnabled = !startingAmountText.isEmpty && !unitText.isEmpty
    }
    
    
    func update_label_report() {
        
        
        
        let startingAmountText = " StartingAmount : " + startingAmountTextField.text! + " " + unit.text!
        
        let salesText = " Sales : " + sales.description +  " " + unit.text!
        
        let buysText = " Buys : " + buys.description +  " " + unit.text!
        
        let costsText = " Other Costs: " + costs.description +  " " + unit.text!
        
        var current = Float(0)
        
        if(!((startingAmountTextField.text?.isEmpty)!)){
            current = values + Float(startingAmountTextField.text!)!
        }
        
        var unitText = "dollar"
        
        if(!(((unit.text)?.isEmpty)!)){
            unitText = unit.text!
        }
        
        let balanceText = " Available Balance: " + current.description +  " " + unitText
        
        self.reportLabel.text = startingAmountText + salesText + buysText + costsText + balanceText
    }
    
    @IBAction func newBuy(_ sender: UIButton) {
        
        let startAmountText = startingAmountTextField.text ?? ""
        
        let unitText = unit.text ?? ""
        
        if !startAmountText.isEmpty && !unitText.isEmpty {
            let alertController = UIAlertController(title: "Add Buy ", message: "", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                alert -> Void in
                
                let firstTextField = alertController.textFields![0] as UITextField
                
                let secondTextField = alertController.textFields![1] as UITextField
                
                
                let newIndexPath = IndexPath(row: self.strings.count, section: 0)
                
                
                
                let fieldValue = Float(firstTextField.text!) ?? 0
                
                let fieldValue2 = Float(secondTextField.text!) ?? 0
                
                let fieldValue3 = fieldValue * fieldValue2
                
                self.values = self.values - fieldValue3
                
                self.buys = self.buys + fieldValue3
                
                let unit = self.unit.text ?? "unit"
                
                let value = " New Item Bought at: " + fieldValue3.description + " " + unit
                
                self.strings.append(value)
                
                
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                
                self.update_label_report()
                
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Item Price"
                textField.keyboardType = UIKeyboardType.decimalPad
            }
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Item Quantity"
                textField.keyboardType = UIKeyboardType.decimalPad
            }
            
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else {
            let alertController = UIAlertController(title: "Not Enough Data", message: "Please Enter Value for Starting Amount and Unit", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        
    }
    
    @IBAction func newSale(_ sender: UIButton) {
        
        let text = startingAmountTextField.text ?? ""
        
        let text2 = unit.text ?? ""
        
        if !text.isEmpty && !text2.isEmpty {
            let alertController = UIAlertController(title: "Add Sale ", message: "", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                alert -> Void in
                
                let firstTextField = alertController.textFields![0] as UITextField
                
                let secondTextField = alertController.textFields![1] as UITextField
                
                
                let newIndexPath = IndexPath(row: self.strings.count, section: 0)
                
                
                
                let firstTextFloat = Float(firstTextField.text!) ?? 0
                
                let secondTextFloat = Float(secondTextField.text!) ?? 0
                
                let combinedFloat = firstTextFloat * secondTextFloat
                
                self.values = self.values + combinedFloat
                
                self.sales = self.sales + combinedFloat
                
                let unit = self.unit.text ?? "unit"
                
                let value = " New Item Sold at: " + combinedFloat.description + " " + unit
                
                self.strings.append(value)
                
                
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                
                self.update_label_report()
                
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Item Price"
                textField.keyboardType = UIKeyboardType.decimalPad
            }
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Item Quantity"
                textField.keyboardType = UIKeyboardType.decimalPad
            }
            
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
            
        else {
            let alertController = UIAlertController(title: "Not Enough Data", message: "Please Enter Value for Starting Amount and Unit", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    }
    
    @IBAction func otherCost(_ sender: UIButton) {
        
        let text = startingAmountTextField.text ?? ""
        
        let text2 = unit.text ?? ""
        
        if !text.isEmpty && !text2.isEmpty {
            let alertController = UIAlertController(title: "Other Cost : ", message: "", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                alert -> Void in
                
                let firstTextField = alertController.textFields![0] as UITextField
                
                
                
                
                let newIndexPath = IndexPath(row: self.strings.count, section: 0)
                
                
                
                let fieldValue = Float(firstTextField.text!) ?? 0
                
                
                self.values = self.values - fieldValue
                
                self.costs = self.costs + fieldValue
                
                let unit = self.unit.text ?? "unit"
                
                let value = " Other Cost Entered: " + fieldValue.description + " " + unit
                
                self.strings.append(value)
                
                
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                
                self.update_label_report()
                
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter  Amount of Cost"
                textField.keyboardType = UIKeyboardType.decimalPad
            }
            
            
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
            
        else {
            
            let alertController = UIAlertController(title: "Not Enough Data", message: "Please Enter Value for Starting Amount and Unit", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "POSTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? POSTableViewCell  else {
            fatalError("The dequeued cell is not an instance of POSTableViewCell.")
        }
        
        cell.posDetails.text = "    " + strings[indexPath.row]
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    @IBAction func viewReport(_ sender: UIButton) {
        let text = startingAmountTextField.text ?? ""
        
        let text2 = unit.text ?? ""
        
        if !text.isEmpty && !text2.isEmpty {
            
            let value = Float(startingAmountTextField.text!) ?? 0
            
            self.values = self.values + value
            
            let a1 = " StartingAmount : " + startingAmountTextField.text! + " " + unit.text!
            
            let a2 = " Sales : " + sales.description +  " " + unit.text!
            
            let a3 = " Buys : " + buys.description +  " " + unit.text!
            
            let a4 = " Other Costs: " + costs.description +  " " + unit.text!
            
            let a5 = " ClosingAmount: " + values.description +  " " + unit.text!
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy HH:mm"
            let result = formatter.string(from: date)
            
            let unitFloat = text2
            
            let ending = self.values
            
            record = Record(date: result, startingAmount: a1, endingAmount: a5, totalBought: a3, totalSold: a2, totalOtherCost: a4, ending: ending, unit: unitFloat )
            
            records.append(record!)
            
            saveRecord()
            
            strings = [String]()
            values = 0
            sales = 0
            buys = 0
            costs = 0
            
            
        }
        else {
            let alertController = UIAlertController(title: "Not Enough Data", message: "Please Enter Value for Starting Amount and Unit", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                (result : UIAlertAction) -> Void in
                print("OK")
            }
            
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    private func saveRecord() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(records, toFile: Record.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Records successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadRecords() -> [Record]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Record.ArchiveURL.path) as? [Record]
    }
    
    // MARK: - Navigation
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
            
            
            
            
        default: break
            
        }
        
    }
    
    
}
