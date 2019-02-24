//
//  MedViewController.swift
//  Medi Ready v2
//
//  Created by Kevin Terwelp on 2/19/19.
//  Copyright © 2019 Kevin Terwelp. All rights reserved.
//

import UIKit
import os.log

class MedViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var medTextField: UITextField!
    @IBOutlet weak var tabDoseTextField: UITextField!
    @IBOutlet weak var rxNumTextField: UITextField!
    @IBOutlet weak var doseTextField: UITextField!
    @IBOutlet weak var tabPerDoseTextField: UITextField!
    @IBOutlet weak var routeTextField: UITextField!
    @IBOutlet weak var frequencyTextField: UITextField!
    @IBOutlet weak var numOfDaysTextField: UITextField!
    @IBOutlet weak var dxTextField: UITextField!
    @IBOutlet weak var medNameLabel: UILabel!
    @IBOutlet weak var tabDoseLabel: UILabel!
    @IBOutlet weak var rxNumLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var tabPerDoseLabel: UILabel!
    @IBOutlet weak var routeLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var numOfDaysLabel: UILabel!
    @IBOutlet weak var dxLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
//    @IBOutlet weak var outerStackViewTopConstraint: NSLayoutConstraint!
//    var outerStackViewTopConstraintConstant:CGFloat = 20.0
    
    /*
     This value is either passed by 'MedTableViewController' in 'prepare(for:sender:)' or constructed as part of adding a new med.
    */
    var med: Med?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        
        //Handle the text field's user input through delegate callbacks.
        medTextField.delegate = self
        tabDoseTextField.delegate = self
        rxNumTextField.delegate = self
        doseTextField.delegate = self
        tabPerDoseTextField.delegate = self
        routeTextField.delegate = self
        frequencyTextField.delegate = self
        numOfDaysTextField.delegate = self
        dxTextField.delegate = self
        commentTextView.delegate = self
        
        //Set up views if editing an existing Med.
        if let med = med {
            navigationItem.title = med.med
            medTextField.text = med.med
            tabDoseTextField.text = med.tabDose
            rxNumTextField.text = med.rxNum
            doseTextField.text = med.dose
            tabPerDoseTextField.text = med.tabPerDose
            routeTextField.text = med.route
            frequencyTextField.text = med.frequency
            numOfDaysTextField.text = med.numOfDays
            dxTextField.text = med.dx
            commentTextView.text = med.comments
            
        }
        
//        //Listen for the keyboard
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        //Enable the Save button only if the text field has a valid Med name.
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = medTextField.text
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
            
            fatalError("The MedViewController is not inside a navigation controller.")
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
        
        let medName = medTextField.text ?? ""
        let tabDose = tabDoseTextField.text ?? ""
        let rxNum = rxNumTextField.text ?? ""
        let dose = doseTextField.text ?? ""
        let tabPerDose = tabPerDoseTextField.text ?? ""
        let route = routeTextField.text ?? ""
        let frequency = frequencyTextField.text ?? ""
        let numOfDays = numOfDaysTextField.text ?? ""
        let dx = dxTextField.text ?? ""
        let comments = commentTextView.text ?? ""
        
        //Set the med to be passed to MedTableViewController after the unwind segue.
        med = Med(med: medName, tabDose: tabDose, rxNum: rxNum, dose: dose, tabPerDose: tabPerDose, route: route, frequency: frequency, numOfDays: numOfDays, dx: dx, comments: comments)
        
    }

    //MARK: Actions
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        //Disable the Save button if the text field is empty.
        let text = medTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        let text2 = tabDoseTextField.text ?? ""
        saveButton.isEnabled = !text2.isEmpty
        let text3 = doseTextField.text ?? ""
        saveButton.isEnabled = !text3.isEmpty
        let text4 = tabPerDoseTextField.text ?? ""
        saveButton.isEnabled = !text4.isEmpty
        let text5 = routeTextField.text ?? ""
        saveButton.isEnabled = !text5.isEmpty
        let text6 = frequencyTextField.text ?? ""
        saveButton.isEnabled = !text6.isEmpty
        let text7 = dxTextField.text ?? ""
        saveButton.isEnabled = !text7.isEmpty
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        commentTextView.resignFirstResponder()
//
//        self.view.layoutIfNeeded()
//
//        UIView.animate(withDuration: 0.5, animations: {
//
//            self.outerStackViewTopConstraint.constant = self.outerStackViewTopConstraintConstant
//            self.view.layoutIfNeeded()
//        })
//    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//
//        if let info = notification.userInfo {
//
//            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
//
//            //Find our target Y
//            let targetY = view.frame.size.height - rect.height - 20 - commentTextView.frame.origin.y
//
//            //Find out where the stackView is relative to the frame
//            let textFieldY = outerStackView.frame.origin.y + stackView.frame.origin.y + commentTextView.frame.origin.y
//
//            let difference = targetY - textFieldY
//
//            let targetOffsetForTopConstraint = outerStackViewTopConstraint.constant + difference
//
//            self.view.layoutIfNeeded()
//
//            UIView.animate(withDuration: 0.25, animations: {
//
//                self.outerStackViewTopConstraint.constant = targetOffsetForTopConstraint
//                self.view.layoutIfNeeded()
//
//                })
//
//        }
//
//    }
    
}

