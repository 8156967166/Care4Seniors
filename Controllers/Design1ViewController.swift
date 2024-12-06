//  Design1ViewController.swift
//  Care4Senior
//  Created by Aneesha on 06/02/24.

import UIKit
import CoreMotion
import MBCircularProgressBar

class Design1ViewController: UIViewController {
    
    //MARK: - Outlines
    
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var lblTimeTaken: UILabel!
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblCalories: UILabel!
    @IBOutlet weak var lblProgress: UILabel!
    @IBOutlet weak var lblTargetSteps: UILabel!
    @IBOutlet weak var lblMyProgress: UILabel!
    @IBOutlet weak var lblActionTime: UILabel!
    @IBOutlet weak var lblDistanceTitle: UILabel!
    @IBOutlet weak var lblCaloriesTitle: UILabel!
    @IBOutlet weak var lblEnryExpand: UILabel!
    @IBOutlet weak var lblProgressTitle: UILabel!
    @IBOutlet weak var lblGoal: UILabel!
  
    
    //MARK: - Variables
    var strLocal = String()
    let userDefault = UserDefaults.standard
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    // Define your time intervals
    let timeIntervals = ["12 am", "4 am", "8 am", "12 pm", "4 pm", "8 pm", "12 am"]
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGif()
        self.lblCalories.text = "0.000"
        self.lblProgress.text = "0%"
        self.lblDistance.text = "0.000 km"
        let steps = "B61-zf-dyE.text".localizableString(loc: strLocal)
        self.lblTargetSteps.text = "100 \(steps)"
        progressView.unitString = " \(steps)"
        self.progressView.value = 0
        if CMMotionActivityManager.isActivityAvailable() {
            print("CMMotionActivityManager is ActivityAvailable")
            self.activityManager.startActivityUpdates(to: OperationQueue.main) { (data) in
                DispatchQueue.main.async {
                    if let activity = data {
                        if activity.running == true {
                            print("User is Running")
                        }else if activity.walking == true {
                            print("User is Walking")
                        }else if activity.automotive == true {
                            print("User is Automotive")
                        }else if activity.cycling == true {
                            print("User is cycling")
                        }else if activity.stationary == true {
                            print("User is stationary")
                        }
                    }
                }
            }
        }
        
        //         Check if the device supports step counting
        
        //        if CMPedometer.isStepCountingAvailable() {
        //            print("CMPedometer is StepCountingAvailable")
        //            self.pedoMeter.startUpdates(from: Date()) { (data, error) in
        //                if error == nil {
        //                    if let response = data {
        //                        DispatchQueue.main.async {
        //                            // Use the numberOfSteps data
        //                            if let stepCount = response.numberOfSteps as? Int {
        //                                print("Number of steps: \(stepCount)")
        //                            }
        //                            if let distance = response.distance as? Double {
        //                                print("Distance walked: \(distance) meters")
        //                            }
        //                            if let caloriesBurned = response.numberOfSteps.doubleValue * 0.04 as? Double {
        //                                print("Calories burned: \(caloriesBurned)")
        //                                self.lblCalories.text = "\(caloriesBurned)"
        //                            }
        //                            print("Number of steps: \(response.numberOfSteps)")
        //                            print("Distance: \(String(describing: response.distance))")
        //                            // Get the current date and time
        //                            let currentDate = Date()
        //                            // Create a date formatter
        //                            let dateFormatter = DateFormatter()
        //                            // Set the date format
        //                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //                            // Convert the date to a string using the date formatter
        //                            let dateString = dateFormatter.string(from: currentDate)
        //                            // Print the current time
        //                            print("Current time: \(dateString)")
        //                            let value = response.numberOfSteps
        //                            self.progressView.value = CGFloat(value)
        //                            self.lblDistance.text = "\(String(describing: response.distance))"
        //                            let val = self.calculatePercentage(value: Double(value) ,percentageVal: 500)
        //                            print(val)
        //                            self.lblProgress.text = "\(val)%"
        //                            UIView.animate(withDuration: 1.0) {
        //                                self.progressView.value = val
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }
        
        if CMPedometer.isStepCountingAvailable() {
            print("CMPedometer is StepCountingAvailable")
            self.pedoMeter.startUpdates(from: Date()) { (data, error) in
                if error == nil {
                    if let response = data {
                        DispatchQueue.main.async {
                            // Use the numberOfSteps data
                            if let stepCount = response.numberOfSteps as? Int {
                                print("Number of steps: \(stepCount)")
                                let getTargetSteps = UserDefaults.standard.value(forKey: "TargetSteps")
                                if self.progressView.value >= getTargetSteps as! CGFloat {
                                    print("Step count over target goal")
                                }else{
                                    self.progressView.value = CGFloat(stepCount)
                                    self.userDefault.set(self.progressView.value, forKey: "ProgressValue")
                                }
                                
                                // Convert distance from NSNumber to Double
                                let distanceInKm = (response.distance ?? 0).doubleValue
                                let averageSpeedKmPerHour = 5.0
                                let actionTimeInHours = distanceInKm / averageSpeedKmPerHour
                                let hours = Int(actionTimeInHours)
                                let minutes = Int((actionTimeInHours - Double(hours)) * 60)
                                let actionTimeString = String(format: "%02d:%02d", hours, minutes)
                                print("Action time: \(actionTimeString)")
                                self.lblTimeTaken.text = " \(actionTimeString) ss:ms"
                                self.userDefault.set(actionTimeString, forKey: "ActionTime")
                                
                                let percentage = self.calculatePercentage(value: Double(stepCount) ,percentageVal: 500)
                                let formattedPercentage = String(format: "%.2f", percentage)
                                self.lblProgress.text = "\(formattedPercentage)%"
                                self.userDefault.set(formattedPercentage, forKey: "ProgressPercentage")
                                
                                let distanceString = String(format: "%.3f", distanceInKm)
                                self.lblDistance.text = "\(distanceString) m"
                                print("distanceString --- \(distanceString)")
                                self.userDefault.set(distanceString, forKey: "Distance")
                                
                                if let caloriesBurned = response.numberOfSteps.doubleValue * 0.04 as? Double {
                                    let calories = String(format: "%.3f", caloriesBurned)
                                    print("Calories burned: \(caloriesBurned)")
                                    self.lblCalories.text = "\(calories)"
                                    self.userDefault.set(calories, forKey: "Calories")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblDistanceTitle.text = "6gQ-Id-MR3.text".localizableString(loc: strLocal)
        lblCaloriesTitle.text = "wcz-Pn-nVC.text".localizableString(loc: strLocal)
        lblActionTime.text = "E2j-R0-0lz.text".localizableString(loc: strLocal)
        lblEnryExpand.text = "nfK-Nc-4zt.text".localizableString(loc: strLocal)
        lblMyProgress.text = "jBm-NZ-M1v.text".localizableString(loc: strLocal)
        lblProgressTitle.text = "q92-cH-9Vp.text".localizableString(loc: strLocal)
        lblGoal.text = "9aa-kx-dso.text".localizableString(loc: strLocal)
        setlocalazition()
        getAllDataStepTracking()
        let getTargetSteps = UserDefaults.standard.value(forKey: "TargetSteps")
        print("getTargetSteps -- \(getTargetSteps ?? "")")
        let steps = "B61-zf-dyE.text".localizableString(loc: strLocal)
        lblTargetSteps.text = "\(getTargetSteps ?? "") \(steps)"
        if let targetSteps = getTargetSteps as? Double { // Assuming getTargetSteps is of type Double
            // Assuming progressView is your UIProgressView instance
            progressView.maxValue = targetSteps
        } else {
            print("Error: Unable to set maxValue. getTargetSteps does not contain a valid numeric value.")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        if let text = self.lblCounter.text, let value = Int(text) {
        //           print("value --- \(value)")
        //            let val = calculatePercentage(value: Double(value),percentageVal: 100)
        //            print(val)
        //            UIView.animate(withDuration: 1.0) {
        //                self.progressView.value = val
        //            }
        //        }
        
        //        UIView.animate(withDuration: 20.0) {
        //            self.progressView.value = 60
        //        }
    }
    
    func setGif() {
        // Load the GIF file
        if let gifURL = Bundle.main.url(forResource: "fire", withExtension: "gif") {
            // Create a data object from the GIF file
            if let gifData = try? Data(contentsOf: gifURL) {
                // Create an animated image from the GIF data
                if let image = UIImage.gifImageWithData(gifData) {
                    // Set the animated image to the image view
                    gifImageView.image = image
                }
            }
        }
    }
   
    
    func setlocalazition() {
        // Identify current language
        let currentLanguage = Bundle.main.preferredLocalizations.first
                
        if currentLanguage == "en" {
            // Handle English language
            print("English")
        } else if currentLanguage == "zh-Hans" {
            // Handle Simplified Chinese language
            print("Chinese")
        } else {
            // Handle other languages
        }
    }
    
    //MARK: - Function: - calculatePercentage
    
    //Calucate percentage based on given values
    public func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value / percentageVal
        return val * 100.0
    }
    
    func getAllDataStepTracking() {
        let steps = userDefault.value(forKey: "ProgressValue")
        let actionTime = userDefault.value(forKey: "ActionTime")
        let calories = userDefault.value(forKey: "Calories")
        let distance = userDefault.value(forKey: "Distance")
        let progrssPercentage = userDefault.value(forKey: "ProgressPercentage")
        print("steps -- \(steps ?? ""), actionTime -- \(actionTime ?? ""), calories -- \(calories ?? ""), distance -- \(distance ?? ""), progrssPercentage -- \(progrssPercentage ?? "")")
        if steps == nil {
            progressView.value = 0
        }else {
            progressView.value = steps as! CGFloat
        }
        
        if actionTime == nil {
            lblTimeTaken.text = "00:00 HH:mm"
        }else {
            lblTimeTaken.text = "\(actionTime ?? "") HH:mm"
        }
        
        if calories == nil {
            self.lblCalories.text = "0.000"
        }else {
            self.lblCalories.text = calories as? String
        }
        
        if distance == nil {
            self.lblDistance.text = "0.000 m"
        }else {
            self.lblDistance.text = "\(distance ?? "") m"
        }
        
        if progrssPercentage == nil {
            self.lblProgress.text = "0%"
        }else {
            self.lblProgress.text = "\(progrssPercentage ?? "")%"
        }
        
        print("steps -- \(progressView.value), actionTime -- \(lblTimeTaken.text ?? ""), calories -- \(lblCalories.text ?? ""), distance -- \(lblDistance.text ?? ""), progrssPercentage -- \(lblProgress.text ?? "")")
        
    }
    
    //MARK: - ButtonAction
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonStepProgress(_ sender: UIButton) {
        print("buttonStepProgress")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StepCountingViewController") as! StepCountingViewController
        vc.strLocal = strLocal
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Function to get the index of time interval based on current time
    func getTimeIntervalIndex(for date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        let timeString = dateFormatter.string(from: date)
        if let index = timeIntervals.firstIndex(of: timeString) {
            return index
        } else {
            return -1 // Invalid time
        }
    }
}

//if CMPedometer.isStepCountingAvailable() {
//    print("CMPedometer is StepCountingAvailable")
//    self.pedoMeter.startUpdates(from: Date()) { (data, error) in
//        if error == nil {
//            if let response = data {
//                DispatchQueue.main.async {
//                    // Use the numberOfSteps data
//                    if let stepCount = response.numberOfSteps as? Int {
//                        print("Number of steps: \(stepCount)")
//                        self.progressView.value = CGFloat(stepCount)
//
//                        // Get the current date and time
//                        let currentDate = Date()
//
//                        // Iterate through time intervals
//                        for i in 0..<time.count-1 {
//                            let startTimeString = time[i]
//                            let endTimeString = time[i+1]
//
//                            // Convert time strings to Date objects
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "h a"
//                            guard let startTime = dateFormatter.date(from: startTimeString),
//                                  let endTime = dateFormatter.date(from: endTimeString) else {
//                                return
//                            }
//
//                            // Check if current time falls within the interval
//                            if currentDate >= startTime && currentDate < endTime {
//                                let stepsInInterval = dataTimeEntries[i]
//                                print("Steps taken from \(startTimeString) to \(endTimeString): \(stepsInInterval)")
//                                // Do something with the stepsInInterval
//                                break
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
