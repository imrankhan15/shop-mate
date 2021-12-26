//
//  NewCustomerViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/26/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log


class NewCustomerViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate{


    @IBOutlet weak var customerNameTextField: UITextField!
    
    @IBOutlet weak var customerMobileTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
     var customer: Customer?
    override func viewDidLoad() {
        super.viewDidLoad()

        customerNameTextField.delegate = self
        customerMobileTextField.delegate = self
        
        customerNameTextField.autocorrectionType = .no
        customerMobileTextField.autocorrectionType = .no
        
        if let customer = customer {
            navigationItem.title = customer.customerName
            customerNameTextField.text = customer.customerName
            customerMobileTextField.text = customer.customerMobileNumber
        }
        updateSaveButtonState()
    }

    private func updateSaveButtonState() {
        
        let customerNameText = customerNameTextField.text ?? ""
        
        let customerMobileText = customerMobileTextField.text ?? ""
        
      
        
        saveButton.isEnabled = !customerNameText.isEmpty && !customerMobileText.isEmpty
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
            fatalError("The CustomerViewController is not inside a navigation controller.")
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
        
        let customerName = customerNameTextField.text ?? ""
        
        let customerMobileNumber = customerMobileTextField.text ?? ""
        
        
        
        customer = Customer(customerName: customerName, customerMobileNumber: customerMobileNumber)
    }
  

}
