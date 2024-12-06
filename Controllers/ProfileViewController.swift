//
//  ProfileViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 14/02/24.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import Network

class ProfileViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Outlets
    
    @IBOutlet weak var lblLanguageChnge: UILabel!
    @IBOutlet weak var lblUpdate: UILabel!
    @IBOutlet weak var textFieldTargetSteps: MDCOutlinedTextField!
    @IBOutlet weak var lblProfileLetter: UILabel!
    @IBOutlet weak var lblActyGoal: UILabel!
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblLangChange: UILabel!
    
    //MARK: - Variables
    
    var strLocal = String()
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldTargetSteps.delegate = self
        self.textFieldTargetSteps.placeHolderColor = .lightGray
        self.textFieldTargetSteps.setOutlineColor(UIColor.blue, for: .normal)
        self.textFieldTargetSteps.setOutlineColor(UIColor.blue, for: .editing)
        
        
        // Create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Create a flexible space item to push the done button to the right
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // Create a done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        // Assign the button to the toolbar
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        // Assign the toolbar to the text field input accessory view
        textFieldTargetSteps.inputAccessoryView = toolbar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLabelTap()
        let goal = "Goal".localizableString(loc: strLocal)
        let number = "Number".localizableString(loc: strLocal)
        self.textFieldTargetSteps.label.text =  goal
        self.textFieldTargetSteps.placeholder = number
        lblActyGoal.text = "5FT-T0-uIV.text".localizableString(loc: strLocal)
        lblProfile.text = "Ehg-oZ-FZo.text".localizableString(loc: strLocal)
        lblUpdate.text = "bec-30-7aA.text".localizableString(loc: strLocal)
    }
    
    func setupLabelTap() {
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        self.lblLangChange.isUserInteractionEnabled = true
        self.lblLangChange.addGestureRecognizer(labelTap)
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        print("labelTapped")
    }
    
    // Function to handle the "Done" button tap event
    @objc func doneButtonTapped() {
        // Hide the keyboard
        view.endEditing(true)
    }
    
    // UITextFieldDelegate method to handle return key press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard when return key is pressed
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: - ButtonActions
    
    
    @IBAction func buttonUpdate(_ sender: UIButton) {
        if let text = textFieldTargetSteps.text, let numericValue = Double(text) {
            print("targetSteps --- \(UserDefaults.standard.setValue(numericValue, forKey: "TargetSteps"))")
        }
        alert(msg: "Successfully updated")
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func alert(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
