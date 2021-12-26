//
//  StaffReportViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/28/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log


class StaffReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var StaffMobileNumber: String?
    var reports = [Report]()
    var profile_reports = [Report]()
    var copy_reports = [Report]()
    var date: String?
    var dateTwo: String?
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 5.0
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(StaffReportViewController.editButtonPressed))
        
        self.tableView.separatorStyle = .none
        
        if let savedReports = loadReports() {
            reports += savedReports
        }
        else {}
        for rc in reports {
            if rc.staffMobileNumber == StaffMobileNumber! {
                profile_reports.append(rc)
            }
        }
        
        for rc in reports {
            copy_reports.append(rc)
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile_reports.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "StaffReportTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StaffReportTableViewCell  else {
            fatalError("The dequeued cell is not an instance of StaffReportTableViewCell.")
        }
        let report = profile_reports[indexPath.row]
        cell.date.text = "    Date: " + report.date
        cell.status.text = "    Report: " + report.report
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
            date = profile_reports[indexPath.row].date
            profile_reports.remove(at: indexPath.row)
            
            var counter = 0
            for rc in copy_reports {
                if rc.date == date {
                    
                    reports.remove(at: counter)
                }
                counter += 1
            }
            copy_reports.remove(at: indexPath.row)
            saveReport()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    
    private func saveReport() {
        
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(reports, toFile: Report.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Reports successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save reports...", log: OSLog.default, type: .error)
        }
    }
    
    @objc func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(StaffReportViewController.editButtonPressed))
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(StaffReportViewController.editButtonPressed))
        }
    }
    
    
    private func loadReports() -> [Report]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Report.ArchiveURL.path) as? [Report]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func returnToStuffs(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToStaffReportList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? StaffReportDetailViewController, let report = sourceViewController.report {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                profile_reports[selectedIndexPath.row] = report
                copy_reports[selectedIndexPath.row] = report
                var counter = 0
                for rc in copy_reports {
                    if rc.date == report.date {
                        
                        reports[counter].report = report.report
                    }
                    counter += 1
                }
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                saveReport()
            }
            else {
                
                let newIndexPath = IndexPath(row: profile_reports.count, section: 0)
                
                
                reports.append(report)
                profile_reports.append(report)
                copy_reports.append(report)
                
                
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                saveReport()
            }
        }
    }
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddStaffReport":
            
            guard let navVc = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            let staffReportDetailViewController = navVc.viewControllers.first as! StaffReportDetailViewController
            
            staffReportDetailViewController.staffMobileNumber = StaffMobileNumber
            os_log("Adding a new staffReport.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let staffReportDetailViewController = segue.destination as? StaffReportDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedItemCell = sender as? StaffReportTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedStaffReport = profile_reports[indexPath.row]
            staffReportDetailViewController.report = selectedStaffReport
            staffReportDetailViewController.staffMobileNumber = StaffMobileNumber
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }
        
        
    }
    
    
}
