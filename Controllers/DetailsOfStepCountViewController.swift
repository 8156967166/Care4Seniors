//
//  DetailsOfStepCountViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 07/02/24.
//

import UIKit

class DetailsOfStepCountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var collectionViewCalender: UICollectionView!
    @IBOutlet weak var textFieldSelectedMonth: UITextField!
    @IBOutlet weak var textFieldSelectedYear: UITextField!
    
    var dateOftheCalendr = [String]()
    var dayOftheCalendr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldSelectedMonth.delegate = self
        textFieldSelectedYear.delegate = self
        let currentDate = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // This sets the date format to display the full month name
        let currentMonthName = dateFormatter.string(from: currentDate)
        print("Current Month: \(currentMonthName)")
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        
        print("Current Year: \(currentYear)")
        print("Current Month: \(currentMonth)")
        textFieldSelectedMonth.text = "\(currentMonthName)"
        textFieldSelectedYear.text = "\(currentYear)"
        collectionViewCalender.delegate = self
        collectionViewCalender.dataSource = self
        // Call the function to display dates and days for the selected year
        guard let year = Int(textFieldSelectedYear.text ?? "") else {
            return
        }
        
        displayDatesAndDays(forYear: year)
    }
    
    // This method is called when the return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateOftheCalendr.removeAll()
        dateOftheCalendr.removeAll()
        let year = Int(textFieldSelectedYear.text ?? "")
        displayDatesAndDays(forYear: year!)
        collectionViewCalender.reloadData()
        textField.resignFirstResponder() // Hide the keyboard
        return true
    }
}

extension DetailsOfStepCountViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateOftheCalendr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCollectionViewCell", for: indexPath) as! CalenderCollectionViewCell
        cell.lblDate.text = dateOftheCalendr[indexPath.row]
        cell.lblDay.text = dayOftheCalendr[indexPath.row]
        
        //        cell.progressView.progress = 0.5
        //        cell.progressView.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func displayDatesAndDays(forYear year: Int) {
        // Create a calendar instance
        let calendar = Calendar.current
        
        // Set the date components to get the first day of January for the selected year
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = 1
        dateComponents.day = 1
        
        // Get the first day of January for the selected year
        guard let firstDayOfYear = calendar.date(from: dateComponents) else {
            print("Invalid date components")
            return
        }
        print("firstDayOfYear -- \(firstDayOfYear)")
        // Loop through each month of the year
//                for month in 1...12 {
//                    // Set the date components to get the first day of the current month
//                    dateComponents.month = month
//                    guard let firstDayOfMonth = calendar.date(from: dateComponents) else {
//                        print("Invalid date components")
//                        return
//                    }
        
        
        guard let currentMonthNumber = getCurrentMonthNumber(from: textFieldSelectedMonth.text ?? "") else {
            return
        }
        dateComponents.month = currentMonthNumber
        guard let firstDayOfMonth = calendar.date(from: dateComponents) else {
            print("Invalid date components")
            return
        }
       
        // Get the number of days in the current month
        let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!
        
        // Loop through each day of the current month
        for day in 1...range.count {
            // Set the date components to get the current day
            dateComponents.day = day
            guard let currentDate = calendar.date(from: dateComponents) else {
                print("Invalid date components")
                return
            }
            
            // Get the day of the week for the current day
            let dayOfWeek = calendar.component(.weekday, from: currentDate)
            print("dayOfWeek -- \(dayOfWeek)")
            // Print the date and day of the week
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd EEEE" // Format: Year-Month-Day DayOfWeek
            print("yyyy-mm-dd ----> \(dateFormatter.string(from: currentDate))")
            
            //MARK: - separatedBy
            
            let dateString = "\(dateFormatter.string(from: currentDate))"
            let components = dateString.components(separatedBy: " ")
            if components.count == 2 {
                let datePart = components[0] // "2024-01-01"
                let dayOfWeek = components[1] // "Monday"
                
                print("Date: \(datePart)")
                let datePartString = datePart
                let componentsDate = datePartString.components(separatedBy: "-")
                if componentsDate.count == 3 {
                    let day = componentsDate[2]
                    print("day ---> \(day)")
                    dateOftheCalendr.append(day)
                }
                print("Day of Week: \(dayOfWeek)")
                dayOftheCalendr.append(dayOfWeek)
            } else {
                print("Invalid date string format")
            }
            
        }
        //        }
    }
}

extension DetailsOfStepCountViewController {
    func getCurrentMonthNumber(from currentMonthName: String) -> Int? {
        // Create a DateFormatter to parse the month name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // Specify the format for full month name
        
        // Get the current date
        let currentDate = Date()
        
        // Set the locale of the date formatter to match the current locale
        dateFormatter.locale = Locale.current
        
        // Parse the current month name to get the month number
        if let currentMonthDate = dateFormatter.date(from: currentMonthName) {
            let calendar = Calendar.current
            let monthNumber = calendar.component(.month, from: currentMonthDate)
            return monthNumber
        }
        
        // Return nil if parsing fails
        return nil
    }
}


