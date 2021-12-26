//
//  CustomersViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/27/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log


class CustomersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var submitButton: UIButton!
    var customers = [Customer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius = 5.0
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(CustomersViewController.editButtonPressed))
        
        
        if let savedCustomers = loadCustomers() {
            customers += savedCustomers}
        else {}
        
        self.tableView.separatorStyle = .none
        
    }
    
    @objc func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(CustomersViewController.editButtonPressed))
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(CustomersViewController.editButtonPressed))
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CustomersTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CustomersTableViewCell  else {
            fatalError("The dequeued cell is not an instance of CustomersTableViewCell.")
        }
        
        let customer = customers[indexPath.row]
        
        
        cell.customerName.text = "    Name: " + customer.customerName
        cell.customerMobileNumber.text = "    Mobile Number: " + customer.customerMobileNumber
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            customers.remove(at: indexPath.row)
            saveCustomers()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {}
    }
    
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedCustomer = customers[sourceIndexPath.row]
        
        customers.remove(at: sourceIndexPath.row)
        
        customers.insert(movedCustomer, at: destinationIndexPath.row)
        
        saveCustomers()
        
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(customers)")
    }
    
    private func saveCustomers() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(customers, toFile: Customer.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Customers successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save customers...", log: OSLog.default, type: .error)
        }
    }
    
    
    @IBAction func unwindToCustomerList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewCustomerViewController, let customer = sourceViewController.customer {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                customers[selectedIndexPath.row] = customer
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new customer.
                let newIndexPath = IndexPath(row: customers.count, section: 0)
                customers.append(customer)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveCustomers()
        }
    }
    
    
    private func loadCustomers() -> [Customer]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Customer.ArchiveURL.path) as? [Customer]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    // MARK: - Navigation
    
    @IBAction func returnHome(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddCustomer":
            
            
            
            os_log("Adding a new customer.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let newCustomerViewController = segue.destination as? NewCustomerViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedItemCell = sender as? CustomersTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedCustomer = customers[indexPath.row]
            newCustomerViewController.customer = selectedCustomer
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }
        
        
    }
    
    
    
}
