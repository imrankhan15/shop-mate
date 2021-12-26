//
//  RecordViewController.swift
//  ShopkeepersMate
//
//  Created by Muhammad Faisal Imran Khan on 1/30/18.
//  Copyright © 2018 MI Apps. All rights reserved.
//

import UIKit
import os.log


class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var records = [Record]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(RecordViewController.editButtonPressed))
        
        if let savedRecords = loadRecords() {
            records += savedRecords
        }
        else {
        }
        tableView.separatorStyle = .none
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "2000px-Shop.svg.png"))
        tableView.backgroundView?.contentMode = .scaleAspectFit
    }
    
    @objc func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RecordViewController.editButtonPressed))
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(RecordViewController.editButtonPressed))
        }
    }
    
    private func loadRecords() -> [Record]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Record.ArchiveURL.path) as? [Record]
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "RecordTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecordTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RecordTableViewCell.")
        }
        
        let record = records[indexPath.row]
        
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        cell.record_dateTime.text = "Record Date &Time : " + record.date
        
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let counter = records.count-1
            
            if(counter == indexPath.row){
                
                let alertController = UIAlertController(title: "Cannot Delete", message: "Last Record is required for future reference, please delete only the previous records except the last one", preferredStyle: UIAlertController.Style.alert) 
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    (result : UIAlertAction) -> Void in
                    print("OK")
                }
                
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
                
            }
            else {
                records.remove(at: indexPath.row)
                saveRecord()
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            
        } else if editingStyle == .insert {
            
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
            
            
        case "ShowRecord":
            
            
            
            guard let recordItemViewController = segue.destination as? RecordItemViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            
            guard let selectedItemCell = sender as? RecordTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedItemCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            
            
            
            recordItemViewController.dateTime = records[indexPath.row].date
            
            recordItemViewController.buys = records[indexPath.row].totalBought
            
            recordItemViewController.sales = records[indexPath.row].totalSold
            
            recordItemViewController.closingAmount = records[indexPath.row].endingAmount
            
            recordItemViewController.cost = records[indexPath.row].totalOtherCost
            
            recordItemViewController.startingAmount = records[indexPath.row].startingAmount
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
}
