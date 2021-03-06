//
//  MedTableViewController.swift
//  Medi Ready
//
//  Created by Kevin Terwelp on 2/19/19.
//  Copyright © 2019 Kevin Terwelp. All rights reserved.
//

import UIKit
import os.log

class MedTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var meds = [Med]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        //Load any saved meals, otherwise load sample data.
        if let savedMeds = loadMeds() {
            meds += savedMeds
        }
        else {
            //Load the sample data.
            loadSampleMeds()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meds.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MedicineTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MedicineTableViewCell else {
            fatalError("The dequeued cell is not an instance of MedicineTableViewCell")
        }
        
        //Fetches the appropriate med for the data source layout.
        let med = meds[indexPath.row]
        
        cell.medLabel.text = med.med
        cell.tabDosageLabel.text = med.dosePerTablet
        cell.doseLabel.text = med.prescribedDose
        cell.tabsLabel.text = med.tablets
        cell.routeLabel.text = med.route
        cell.frequencyLabel.text = med.frequency
        cell.numOfDaysLabel.text = med.numOfDays
        cell.dxLabel.text = med.dx

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            meds.remove(at: indexPath.row)
            saveMeds()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new med.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let medDetailViewController = segue.destination as? MedDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMedCell = sender as? MedicineTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMed = meds[indexPath.row]
            medDetailViewController.medicine = selectedMed
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    //MARK: Private Methods
    
    //MARK: Acions
    
    @IBAction func unwindToMedList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? MedDetailViewController, let med = sourceViewController.medicine {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Update an existing med.
                meds[selectedIndexPath.row] = med
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                
                //Add new med.
                let newIndexPath = IndexPath(row: meds.count, section: 0)
                
                meds.append(med)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
            
            //Save the meds.
            saveMeds()
            
        }
        
    }
    
    
    //MARK: Private Methods
    
    private func loadSampleMeds() {
        
        guard let med1 = Med(med: "Lorazepam", dosePerTablet: "10mg", prescribedDose: "10mg", tablets: "1 tablet", route: "by mouth", frequency: "daily", numOfDays: "14 days", dx: "anxiety") else {
            fatalError("Unable to instantiate med1")
        }
        
        guard let med2 = Med(med: "Lorazepam", dosePerTablet: "10mg", prescribedDose: "10mg", tablets: "1 tablet", route: "by mouth", frequency: "daily", numOfDays: "14 days", dx: "anxiety") else {
            fatalError("Unable to instantiate med2")
        }
        
        guard let med3 = Med(med: "Lorazepam", dosePerTablet: "10mg", prescribedDose: "10mg", tablets: "1 tablet", route: "by mouth", frequency: "daily", numOfDays: "14 days", dx: "anxiety") else {
            fatalError("Unable to instantiate med3")
        }
        
        meds += [med1, med2, med3]
    }
    
    private func saveMeds() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meds, toFile: Med.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meds successfully saved.", log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save meds...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeds() -> [Med]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Med.ArchiveURL.path) as? [Med]
    }
    
}
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   


