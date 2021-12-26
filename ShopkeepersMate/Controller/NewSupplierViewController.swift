//
//  NewSupplierViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/27/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log


class NewSupplierViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate  {

    var supplier: Supplier?
    
    @IBOutlet weak var supplierNameTextField: UITextField!
    
    @IBOutlet weak var supplierMobileTextField: UITextField!
    
    @IBOutlet weak var supplierAddressTextField: UITextField!
    
    @IBOutlet weak var suppliedItemTypeTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        supplierNameTextField.delegate = self
        
        supplierMobileTextField.delegate = self
        
        supplierAddressTextField.delegate = self
        
        suppliedItemTypeTextField.delegate = self
        
        supplierNameTextField.autocorrectionType = .no
        
        supplierMobileTextField.autocorrectionType = .no

        supplierAddressTextField.autocorrectionType = .no
        
        suppliedItemTypeTextField.autocorrectionType = .no
        
        if let supplier = supplier {
            navigationItem.title = supplier.supplierName
            supplierNameTextField.text = supplier.supplierName
            supplierMobileTextField.text = supplier.supplierMobileNumber
            supplierAddressTextField.text = supplier.supplierAddress
            suppliedItemTypeTextField.text = supplier.suppliedItemType
       }
       updateSaveButtonState()
    }

    private func updateSaveButtonState() {
        
        let supplierNameText = supplierNameTextField.text ?? ""
        
        let supplierMobileText = supplierMobileTextField.text ?? ""
        
        let supplierAddressText = supplierAddressTextField.text ?? ""
        
        let suppliedItemTypeText = suppliedItemTypeTextField.text ?? ""
        

        
        saveButton.isEnabled = !supplierNameText.isEmpty && !supplierMobileText.isEmpty && !supplierAddressText.isEmpty && !suppliedItemTypeText.isEmpty

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
            fatalError("The SupplierViewController is not inside a navigation controller.")
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
        
        let supplierName = supplierNameTextField.text ?? ""
        
        let supplierMobileNumber = supplierMobileTextField.text ?? ""
        
        let supplierAddress = supplierAddressTextField.text ?? ""
        
        let suppliedItemType = suppliedItemTypeTextField.text ?? ""

        
        supplier = Supplier(supplierName: supplierName, supplierMobileNumber: supplierMobileNumber, supplierAddress: supplierAddress, suppliedItemType: suppliedItemType)
    }

}
