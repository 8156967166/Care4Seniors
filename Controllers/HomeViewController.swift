//
//  HomeViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 14/02/24.
//

import UIKit
import FSCalendar

struct Activities {
    var title: String
    var image: String
}

class HomeViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - Outlet
    
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var collectnView: UICollectionView!
    @IBOutlet weak var lblProfile: UILabel!
    
    //MARK: - Variables
    
    var Strlocal = String()
    let userDefaults = UserDefaults.standard
    var isSelectCalender = true
    var activitiesArry = [Activities]()
    var readingTodayView: ReadingTodayView!
    var healthLibrary = String()
    var daily_Care = String()
    var exercisse = String()
    var quiz = String()
    var memoryGames = String()
    var statisticss = String()
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Strlocal -- \(Strlocal)")
        
        collectnView.delegate = self
        collectnView.dataSource = self
        
        let titleHealth = "R2P-VU-ykb.text".localizableString(loc: Strlocal)
        let dailyCare = "Daily Care".localizableString(loc: Strlocal)
        let exercise = "Exercise".localizableString(loc: Strlocal)
        let quizz = "Quizz".localizableString(loc: Strlocal)
        let memorygames = "MemoryGames".localizableString(loc: Strlocal)
        let statistics = "Statistics".localizableString(loc: Strlocal)
        
        healthLibrary = titleHealth
        daily_Care = dailyCare
        exercisse = exercise
        quiz = quizz
        memoryGames = memorygames
        statisticss = statistics
        
        let firstActivity = Activities(title: titleHealth, image: "healthLibrary")
        let secondActivity = Activities(title: dailyCare, image: "DailyCare")
        let thirdActivity = Activities(title: exercise, image: "Exercise")
        let fourthActivity = Activities(title: quizz, image: "Quizz")
        let fifthActivity = Activities(title: memorygames, image: "memorygames")
        let sixthActivity = Activities(title: statistics, image: "statistics")
        
        let activities = [firstActivity, secondActivity, thirdActivity, fourthActivity, fifthActivity, sixthActivity]
        activitiesArry.append(contentsOf: activities)
        // Add observers for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblProfileName.text = "W2K-Jd-QGR.text".localizableString(loc: Strlocal)
        lblProfile.text = "6sx-O0-dVf.text".localizableString(loc: Strlocal)
        getAllDatasFromReadingToday()
    }
    
    //MARK: - Keyboard Functions
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        // Calculate the offset to move the popup view up
        let offset = keyboardSize.height - ((self.view.frame.height + 190) - (readingTodayView.frame.origin.y + readingTodayView.frame.height))

        // Check if offset is positive, then adjust the frame
        if offset > 0 {
            UIView.animate(withDuration: 0.3) {
                self.readingTodayView.frame.origin.y -= offset
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        // Reset the frame of the popup view when the keyboard hides
        UIView.animate(withDuration: 0.3) {
            self.readingTodayView.frame.origin.y = self.view.frame.height - self.readingTodayView.frame.height
        }
    }

    
    //MARK: - Functions
    
    func setPopupReadingToday() {
        
        self.readingTodayView = ReadingTodayView(frame: self.view.frame)
        self.readingTodayView.popupView.layer.cornerRadius = 15
        textFieldNaming()
        self.readingTodayView.buttonClose.addTarget(self, action: #selector(closebtnTaped), for: .touchUpInside)
        self.readingTodayView.buttonCalender.addTarget(self, action: #selector(calenderTapped), for: .touchUpInside)
        self.readingTodayView.buttonSave.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        self.view.addSubview(readingTodayView)
        readingTodayView.textFieldSystolic.delegate = self
        readingTodayView.textFieldDiastolic.delegate = self
        readingTodayView.textFieldDateTime.delegate = self
        readingTodayView.textFieldBloodGlucoseLevel.delegate = self
        readingTodayView.lblReadingTdy.text = "DIn-xE-CDH.text".localizableString(loc: Strlocal)
        readingTodayView.lblBloodPrsure.text = "Blood_Pressure".localizableString(loc: Strlocal)
        readingTodayView.lblSave.text = "Save".localizableString(loc: Strlocal)
        self.readingTodayView.calender.isHidden = true
        //        self.readingTodayView.calenderViewHeight.constant = 0
        self.readingTodayView.calender.delegate = self
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.readingTodayView.calender.isHidden = true
    }
    
    @objc func calenderTapped() {
        if isSelectCalender == true {
            self.readingTodayView.calender.isHidden = false
            isSelectCalender = false
        }else {
            self.readingTodayView.calender.isHidden = true
            isSelectCalender = true
        }
    }
    
    @objc func closebtnTaped() {
        self.readingTodayView.removeFromSuperview()
    }
    
    @objc func saveTapped() {
        // Usage example:
        let inputText = readingTodayView.textFieldDateTime.text ?? ""
        if isValidDateTimeFormat(inputText) {
            print("Valid format")
            if (readingTodayView.textFieldDateTime.text != "") && (readingTodayView.textFieldSystolic.text != "") && (readingTodayView.textFieldDiastolic.text != "") && (readingTodayView.textFieldBloodGlucoseLevel.text != "") {
                userDefaults.set(readingTodayView.textFieldDateTime.text, forKey: "DateTime")
                userDefaults.set(readingTodayView.textFieldSystolic.text, forKey: "Systolic")
                userDefaults.set(readingTodayView.textFieldDiastolic.text, forKey: "Diastolic")
                userDefaults.set(readingTodayView.textFieldBloodGlucoseLevel.text, forKey: "BloodGlucoseLevel")
               
                let alert = UIAlertController(title: "Alert", message: "Successfully Saved", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
                    self.readingTodayView.removeFromSuperview()
                }))
                self.present(alert, animated: true, completion: nil)
                
            }else {
                alert(msg: "Some fields are empty")
            }
        } else {
            print("Invalid format")
            alert(msg: "Invalid Date Time Format")
        }
    }
    
    func alert(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldNaming() {
        self.readingTodayView.textFieldDateTime.delegate = self
        let number = "Number".localizableString(loc: Strlocal)
        let date_Time = "Date_Time".localizableString(loc: Strlocal)
        self.readingTodayView.textFieldDateTime.label.text = date_Time
        self.readingTodayView.textFieldDateTime.textColor = .blue
        self.readingTodayView.textFieldDateTime.placeholder = "dd/MM/yy HH:mm"
        self.readingTodayView.textFieldDateTime.placeHolderColor = .lightGray
        // Set the default border color
        self.readingTodayView.textFieldDateTime.setOutlineColor(UIColor.blue, for: .normal)
        // Set the border color when the text field is selected
        self.readingTodayView.textFieldDateTime.setOutlineColor(UIColor.blue, for: .editing)
        done(textField: self.readingTodayView.textFieldDateTime)
        
        let systolic = "Systolic".localizableString(loc: Strlocal)
        self.readingTodayView.textFieldSystolic.label.text = systolic
        self.readingTodayView.textFieldSystolic.placeholder = number
        self.readingTodayView.textFieldSystolic.placeHolderColor = .lightGray
        self.readingTodayView.textFieldSystolic.setOutlineColor(UIColor.blue, for: .normal)
        self.readingTodayView.textFieldSystolic.setOutlineColor(UIColor.blue, for: .editing)
        done(textField: self.readingTodayView.textFieldSystolic)
        
        let diastolic = "Diastolic".localizableString(loc: Strlocal)
        self.readingTodayView.textFieldDiastolic.label.text = diastolic
        self.readingTodayView.textFieldDiastolic.placeholder = number
        self.readingTodayView.textFieldDiastolic.placeHolderColor = .lightGray
        self.readingTodayView.textFieldDiastolic.setOutlineColor(UIColor.blue, for: .normal)
        self.readingTodayView.textFieldDiastolic.setOutlineColor(UIColor.blue, for: .editing)
        done(textField: self.readingTodayView.textFieldDiastolic)
        
        let blood_Glucose_Level = "Blood_Glucose_Level".localizableString(loc: Strlocal)
        self.readingTodayView.textFieldBloodGlucoseLevel.label.text = blood_Glucose_Level
        self.readingTodayView.textFieldBloodGlucoseLevel.placeholder = number
        self.readingTodayView.textFieldBloodGlucoseLevel.placeHolderColor = .lightGray
        self.readingTodayView.textFieldBloodGlucoseLevel.setOutlineColor(UIColor.blue, for: .normal)
        self.readingTodayView.textFieldBloodGlucoseLevel.setOutlineColor(UIColor.blue, for: .editing)
        done(textField: self.readingTodayView.textFieldBloodGlucoseLevel)
    }
    
    func isValidDateTimeFormat(_ dateTimeString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Adjust timezone if needed
        
        if let _ = dateFormatter.date(from: dateTimeString) {
            return true
        } else {
            return false
        }
    }
    
    func done(textField: UITextField) {
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
        textField.inputAccessoryView = toolbar
    }
    
    // Function to handle the "Done" button tap event
    @objc func doneButtonTapped() {
        // Hide the keyboard
        view.endEditing(true)
    }
    
    func getAllDatasFromReadingToday() {
        let date = userDefaults.string(forKey: "DateTime")
        let systolic = userDefaults.string(forKey: "Systolic")
        let diastolic = userDefaults.string(forKey: "Diastolic")
        let bloodGlucoseLevel = userDefaults.string(forKey: "BloodGlucoseLevel")
        print("Date Time --- \(date ?? "")\n systolic --- \(systolic ?? "")\n diastolic -- \(diastolic ?? "") \n bloodGlucoseLevel -- \(bloodGlucoseLevel ?? "")")
    }
    
    //MARK: - ButtonAction
    
    @IBAction func buttonActionProfile(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        vc.strLocal = Strlocal
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - FSCalendarDelegate

extension HomeViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // Format the selected date
        print("date --- \(date)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let formattedDate = dateFormatter.string(from: date)

        print("formattedDate --- \(formattedDate)")
        
        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let formattedTime = formatter.string(from: currentTime)
        print("Current time: \(formattedTime)")
        
        // Display the formatted date in the text field
        self.readingTodayView.textFieldDateTime.text = "\(formattedDate) \(formattedTime)"
        self.readingTodayView.calender.isHidden = true
        self.isSelectCalender = true

       
        

    }
}

//MARK: - TextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    // UITextFieldDelegate method to handle text changes
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == readingTodayView.textFieldDateTime {
            if string.isEmpty {
                // Handle backspace/delete
                // Implement logic to remove characters here
                // In this example, we'll just return true to allow deletion
                return true
            }
            // Limit to 14 characters (including '/')
            guard textField.text!.count < 14 else {
                return false
            }
            
            // Allow only digits, '/', and ':'
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let allowedCharactersWithColon = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            if allowedCharacters.isSuperset(of: characterSet) {
                if textField.text!.count == 2 || textField.text!.count == 5 {
                    textField.text! += "/"
                } else if textField.text!.count == 8 {
                    textField.text! += " "
                } else if textField.text!.count == 11 {
                    textField.text! += ":"
                }
                return true
            } else if allowedCharactersWithColon.isSuperset(of: characterSet) {
                return true
            } else {
                return false
            }
        }
        if textField == readingTodayView.textFieldSystolic || textField == readingTodayView.textFieldDiastolic || textField == readingTodayView.textFieldBloodGlucoseLevel {
            
            // Ensure that only numbers are allowed
            let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacterSet.isSuperset(of: characterSet) {
                return false
            }
            // Ensure that only 3 characters are entered
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            return newText.count <= 3
        }
        return true
    }
}


//MARK: - CollectionViewDelegate & CollectionViewDatasource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activitiesArry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.titleForActivities.text = activitiesArry[indexPath.row].title
        cell.imageActivities.image = UIImage(named: activitiesArry[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2.2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = activitiesArry[indexPath.row]
        if model.title == healthLibrary {
            print("Health Library")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Design1ViewController") as! Design1ViewController
            vc.strLocal = Strlocal
            self.navigationController?.pushViewController(vc, animated: true)
        }else if model.title == daily_Care {
            print("Daily Care")
            setPopupReadingToday()
        }else if model.title == exercisse {
            print("Exercise")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ExerciseViewController") as! ExerciseViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if model.title == quiz {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
            self.navigationController?.pushViewController(vc, animated: true)
            print("Quiz")
        }else if model.title == memoryGames {
            print("Memory training & games")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BasicMemoryGameViewController") as! BasicMemoryGameViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else if model.title == statisticss {
            print("statistics")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StatisticsViewController") as! StatisticsViewController
            vc.strLocl = Strlocal
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


