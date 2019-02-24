//
//  MedDetailViewController.swift
//  Medi Ready
//
//  Created by Kevin Terwelp on 2/19/19.
//  Copyright © 2019 Kevin Terwelp. All rights reserved.
//

import UIKit
import os.log

class MedDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var medTextField: UITextField!
    @IBOutlet weak var dosePerTabletTextField: UITextField!
    @IBOutlet weak var prescribedDoseTextField: UITextField!
    @IBOutlet weak var tabletsTextField: UITextField!
    @IBOutlet weak var routeTextField: UITextField!
    @IBOutlet weak var frequencyTextField: UITextField!
    @IBOutlet weak var numOfDaysTextField: UITextField!
    @IBOutlet weak var dxTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by 'MealTableViewController' in 'prepare(for:sender:)'
     or constructed as part of adding a new meal.
     */
    var medicine: Med?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input through delegate callbacks.
        medTextField.delegate = self
        /*dosePerTabletTextField.delegate = self
        prescribedDoseTextField.delegate = self
        tabletsTextField = self
        routeTextField = self
        frequencyTextField = self
        numOfDaysTextField = self
        dxTextField = self
        */
        //Set up views if editing an existing Med.
        if let med = medicine {
            navigationItem.title = med.med
            medTextField.text = med.med
            dosePerTabletTextField.text = med.dosePerTablet
            prescribedDoseTextField.text = med.prescribedDose
            tabletsTextField.text = med.tablets
            routeTextField.text = med.route
            frequencyTextField.text = med.frequency
            numOfDaysTextField.text = med.numOfDays
            dxTextField.text = med.dx
            
        }
        
        //Enable the Save button only if the text field has a valid Meal name.
        updateSaveButtonsState()
    }
    
    //MARK:  UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonsState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        //Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMedMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMedMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MedDetailViewController is not inside navigation controller")
        }
        
    }
    
    //This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        //Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let med = medTextField.text ?? ""
        let dosePerTablet = dosePerTabletTextField.text ?? ""
        let prescribedDose = prescribedDoseTextField.text ?? ""
        let tablets = tabletsTextField.text ?? ""
        let route = routeTextField.text ?? ""
        let frequency = frequencyTextField.text ?? ""
        let numOfDays = numOfDaysTextField.text ?? ""
        let dx = dxTextField.text ?? ""
        
        //Set the med to be passed to MedTableViewController after the unwind segue.
        medicine = Med(med: med, dosePerTablet: dosePerTablet, prescribedDose: prescribedDose, tablets: tablets, route: route, frequency: frequency, numOfDays: numOfDays, dx: dx)
        
        
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonsState() {
        //Disable the Save button if the text field is empty.
        let text = medTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
