//
//  SuppliersViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/27/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log


class SuppliersViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    var suppliers = [Supplier]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       submitButton.layer.cornerRadius = 5.0
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(SuppliersViewController.editButtonPressed))
        if let savedSuppliers = loadSuppliers() {
            suppliers += savedSuppliers
        }
        else {}
        self.tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suppliers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SuppliersTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SuppliersTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SuppliersTableViewCell.")
        }
        let supplier = suppliers[indexPath.row]
        cell.supplierName.text = "    Name: " + supplier.supplierName
        cell.supplierMobileNumber.text = "    Mobile Number: " + supplier.supplierMobileNumber
        cell.selectionStyle = .none
        return cell
    }
    

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            suppliers.remove(at: indexPath.row)
            saveSuppliers()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {}
    }
    
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedSupplier = suppliers[sourceIndexPath.row]
        suppliers.remove(at: sourceIndexPath.row)
        suppliers.insert(movedSupplier, at: destinationIndexPath.row)
        saveSuppliers()
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(suppliers)")
    }
    
    private func saveSuppliers() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(suppliers, toFile: Supplier.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Suppliers successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save suppliers...", log: OSLog.default, type: .error)
        }
    }
    
    @IBAction func unwindToSupplierList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewSupplierViewController, let supplier = sourceViewController.supplier {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                suppliers[selectedIndexPath.row] = supplier
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new supplier.
                let newIndexPath = IndexPath(row: suppliers.count, section: 0)
                suppliers.append(supplier)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveSuppliers()
        }
    }

    @IBAction func returnHome(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func loadSuppliers() -> [Supplier]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Supplier.ArchiveURL.path) as? [Supplier]
    }
    
    @objc func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SuppliersViewController.editButtonPressed))
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(SuppliersViewController.editButtonPressed))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddSupplier":
            os_log("Adding a new supplier.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let newSupplierViewController = segue.destination as? NewSupplierViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedItemCell = sender as? SuppliersTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedSupplier = suppliers[indexPath.row]
            newSupplierViewController.supplier = selectedSupplier
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }
    }
   

}
