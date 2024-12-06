//  ViewController.swift
//  Care4Senior
//  Created by Aneesha on 05/02/24.

import UIKit
import CoreMotion
import MBCircularProgressBar

class InfographicsViewController: UIViewController {
    
    //MARK: - Outlines
    
    @IBOutlet weak var lblTimeTaken: UILabel!
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblCalories: UILabel!
    
    //MARK: - Variables
    
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressView.value = 20
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
                        }
                    }
                }
            }
        }
        
        // Check if the device supports step counting
        
        if CMPedometer.isStepCountingAvailable() {
            print("CMPedometer is StepCountingAvailable")
            self.pedoMeter.startUpdates(from: Date()) { (data, error) in
                if error == nil {
                    if let response = data {
                        DispatchQueue.main.async {
                            // Use the numberOfSteps data
                            print("Number of steps: \(response.numberOfSteps)")
                            print("Distance: \(String(describing: response.distance))")
                            let value = response.numberOfSteps
                            let val = self.calculatePercentage(value: Double(value) ,percentageVal: 500)
                                print(val)
                                UIView.animate(withDuration: 1.0) {
                                    self.progressView.value = val
                                }
                        }
                    }
                }
            }
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
    
    //MARK: - Function: - calculatePercentage
    
    //Calucate percentage based on given values
    public func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value / percentageVal
        return val * 100.0
    }
    
}

