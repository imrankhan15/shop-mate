//
//  StaffsViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/28/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log



class StaffsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    var staffs = [Staff]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 5.0
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(StaffsViewController.editButtonPressed))
        if let savedStaffs = loadStaffs() {
            staffs += savedStaffs
        }
        else {}
        
        self.tableView.separatorStyle = .none
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "StaffsTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StaffsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of StaffsTableViewCell.")
        }
        
        let staff = staffs[indexPath.row]
        cell.staffName.text = "    Name: " + staff.staffName
        cell.staffMobileNumber.text = "    Mobile Number: " + staff.staffMobileNumber
        cell.report.tag = indexPath.row
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
            staffs.remove(at: indexPath.row)
            saveStaffs()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedStaff = staffs[sourceIndexPath.row]
        staffs.remove(at: sourceIndexPath.row)
        staffs.insert(movedStaff, at: destinationIndexPath.row)
        saveStaffs()
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(staffs)")
    }
    
    private func saveStaffs() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(staffs, toFile: Staff.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Staffs successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save staffs...", log: OSLog.default, type: .error)
        }
    }
    
    @IBAction func unwindToStaffList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewStaffViewController, let staff = sourceViewController.staff {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal.
                staffs[selectedIndexPath.row] = staff
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new supplier.
                let newIndexPath = IndexPath(row: staffs.count, section: 0)
                staffs.append(staff)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveStaffs()
        }
    }
    
    
    @IBAction func returnHome(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    private func loadStaffs() -> [Staff]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Staff.ArchiveURL.path) as? [Staff]
    }
    
    @objc func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(StaffsViewController.editButtonPressed))
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(StaffsViewController.editButtonPressed))
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
            
        case "AddStaff":
            os_log("Adding a new staff.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let newStaffViewController = segue.destination as? NewStaffViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedItemCell = sender as? StaffsTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedStaff = staffs[indexPath.row]
            newStaffViewController.staff = selectedStaff
            
        case "ShowReport":
            
            guard let navVc = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let staffReportViewController = navVc.viewControllers.first as! StaffReportViewController
            guard let selectedButton = sender as? UIButton else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            let selectedStaffMobileNumber = staffs[selectedButton.tag].staffMobileNumber
            staffReportViewController.StaffMobileNumber = selectedStaffMobileNumber
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
}
