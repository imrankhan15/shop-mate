//
//  StaffReportDetailViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/28/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log



class StaffReportDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    var report: Report?
    
    var staffMobileNumber: String?
    
    @IBOutlet weak var statusTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
 
   
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        statusTextField.delegate = self
        statusTextField.autocorrectionType = .no
        
        if let report = report {
            navigationItem.title = report.report
            statusTextField.text = report.report
        }
        
        updateSaveButtonState()
    }

    private func updateSaveButtonState() {
        
        let text = statusTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func isModal() -> Bool {
        if self.presentingViewController != nil {
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private var wasPushed: Bool {
        guard let vc = navigationController?.viewControllers.first, vc == self else {
            return true
        }
        return false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddltemMode = wasPushed
        if !isPresentingInAddltemMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The StaffReportDetailViewController is not inside a navigation controller.")
        }

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
        
    }
    

    // MARK: - Navigation

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let status = statusTextField.text ?? ""
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        let result = formatter.string(from: date)
        report = Report(staffMobileNumber: staffMobileNumber!, report: status, date: result)

    }
  

}
