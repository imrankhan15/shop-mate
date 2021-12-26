//
//  NewStaffViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/28/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log



class NewStaffViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

     var staff: Staff?
    @IBOutlet weak var staffNameTextField: UITextField!
    @IBOutlet weak var staffMobileNumberTextField: UITextField!
    @IBOutlet weak var staffAddressTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        staffNameTextField.delegate = self
        staffMobileNumberTextField.delegate = self
        staffAddressTextField.delegate = self
        staffNameTextField.autocorrectionType = .no
        staffMobileNumberTextField.autocorrectionType = .no
        staffAddressTextField.autocorrectionType = .no
        if let staff = staff {
            navigationItem.title = staff.staffName
            staffNameTextField.text = staff.staffName
            staffMobileNumberTextField.text = staff.staffMobileNumber
            staffAddressTextField.text = staff.staffAddress
        }
        updateSaveButtonState()
    }

    private func updateSaveButtonState() {
        
        let staffNameText = staffNameTextField.text ?? ""
        
        let staffMobileText = staffMobileNumberTextField.text ?? ""
        
        let staffAddressText = staffAddressTextField.text ?? ""
        
        saveButton.isEnabled = !staffNameText.isEmpty && !staffMobileText.isEmpty && !staffAddressText.isEmpty
        
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

    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddltemMode = wasPushed
        if !isPresentingInAddltemMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The StaffViewController is not inside a navigation controller.")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let staffName = staffNameTextField.text ?? ""
        let staffMobileNumber = staffMobileNumberTextField.text ?? ""
        let staffAddress = staffAddressTextField.text ?? ""
        staff = Staff(staffName: staffName, staffMobileNumber: staffMobileNumber, staffAddress: staffAddress)
    }

}
