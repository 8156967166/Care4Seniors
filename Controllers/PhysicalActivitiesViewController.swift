//
//  PhysicalActivitiesViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 15/02/24.
//

import UIKit
import Charts

class PhysicalActivitiesViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblActivity: UILabel!
    
    //MARK: - Variables
    
    var strLocl = String()
    
//    var activitiesArry = ["Steps", "Heart Points", "Energy Expanded", "Distance", "Move minutes", "Cycling"]
    var activitiesArry = [String]()
    var activitiesCountArry = ["1000", "1pts","680 Cal", "0.36 km", "8 m", "0", "500", "500"]
//    Automative : monitor activities related to automotive motion, such as driving a car
    var activityPopupView: ActivityPopupView!
    let steps = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    var stepsDataEntries = [Double]()
    
    var data = [String: [Double]] ()
    
   
    //MARK: - L:ifeCyles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let steps = "B61-zf-dyE.text".localizableString(loc: strLocl)
        let heart_Points = "Heart_Points".localizableString(loc: strLocl)
        let engy_Expand = "Energy_Expanded".localizableString(loc: strLocl)
        let distance = "6gQ-Id-MR3.text".localizableString(loc: strLocl)
        let move_Mints = "Move_minutes".localizableString(loc: strLocl)
        let cycling = "Cycling".localizableString(loc: strLocl)
        let arry = [steps, heart_Points, engy_Expand, distance, move_Mints, cycling]
        
        data = [
            "\(steps)": [20.0, 30.0, 25.0, 35.0, 28.0, 40.0, 45.0],
            "\(heart_Points)": [10.0, 30.0, 50.9, 60.7, 49.7, 20.1, 36.2],
            "\(engy_Expand)": [10.9, 75.9, 95.8, 76.4, 39.9, 74.6, 49.5],
            "\(distance)": [56.8, 45.8, 67.4, 68.9, 23.5, 78.9, 45.67],
            "\(move_Mints)": [53.8, 85.18, 27.5, 68.9, 33.5, 38.9, 15.27],
            "\(cycling)": [0, 20.56, 0, 0, 0, 0, 0]
    //        "Walking": [40.0, 60.3, 20.5, 57.65, 67.23, 50.16, 89.4],
    //        "Running": [34.0, 15.67, 12.55, 19.10, 21.56, 10.34, 34.5]
        ]
        
        
        activitiesArry.append(contentsOf: arry)
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblActivity.text = "arp-69-DTd.text".localizableString(loc: strLocl)
    }
    
    //MARK: - Functions
    
    func sampleJsn() {
        // Create the dictionary
        let data: [String: [Double]] = [
            "Steps": [20.0, 30.0, 25.0, 35.0, 28.0, 40.0, 45.0],
            "Heart Points": [10.0, 30.0, 50.9, 60.7, 49.7, 20.1, 36.2],
            "Energy Expanded": [10.9, 75.9, 95.8, 76.4, 39.9, 74.6, 49.5],
            "Distance": [56.8, 45.8, 67.4, 68.9, 23.5, 78.9, 45.67]
        ]

        // Convert to JSON
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } catch {
            print("Error converting to JSON: \(error)")
        }
    }
    
    //MARK: - ButtonActions
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - PopupView Function
    
    func setPopupReadingToday(titleActivity: String, countActivity: String) {
        self.activityPopupView = ActivityPopupView(frame: self.view.frame)
        self.activityPopupView.buttonClose.addTarget(self, action: #selector(closebtnTaped), for: .touchUpInside)
        activityPopupView.barChartView.xAxis.labelPosition = .bottom
        activityPopupView.barChartView.xAxis.drawGridLinesEnabled = false
        activityPopupView.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: steps)
        activityPopupView.barChartView.xAxis.granularity = 1
        
        // Hide left and right axis lines and labels
        activityPopupView.barChartView.leftAxis.enabled = false
        activityPopupView.barChartView.rightAxis.enabled = false
        
        activityPopupView.barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        activityPopupView.lblTitileForActivity.text = titleActivity
        activityPopupView.lblCountOfActvitiy.text = countActivity
        activityPopupView.lblToday.text = "UcF-qd-1Cl.text".localizableString(loc: strLocl)
        activityPopupView.lblLastDay.text = "P1T-9L-07s.text".localizableString(loc: strLocl)
        setChartDataForWeek(barChartView: activityPopupView.barChartView)
        self.view.addSubview(activityPopupView)
    }
    
    @objc func closebtnTaped() {
        self.activityPopupView.removeFromSuperview()
    }
    
    func setChartDataForWeek(barChartView: BarChartView) {
        var entries: [BarChartDataEntry] = []
        for i in 0..<stepsDataEntries.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: stepsDataEntries[i])
            entries.append(dataEntry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "week")
//        dataSet.colors = [#colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)]
        
        dataSet.colors = [#colorLiteral(red: 0.9019607843, green: 0.6196078431, blue: 0.4705882353, alpha: 1)]
        let data = BarChartData(dataSet: dataSet)
        
        barChartView.data = data
    }
    
}

//MARK: - TableVuiew Delegates and DataSources

extension PhysicalActivitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivitiesTableViewCell", for: indexPath) as! ActivitiesTableViewCell
        cell.lblTitleOfActivities.text = activitiesArry[indexPath.row]
        cell.lblCountActivities.text = activitiesCountArry[indexPath.row]
        cell.lblToday.text = "UcF-qd-1Cl.text".localizableString(loc: strLocl)
        cell.lblLast7Days.text = "P1T-9L-07s.text".localizableString(loc: strLocl)
        let key = activitiesArry[indexPath.row]
        print("key -- \(key)")
        if let values = data[key] {
            setChart(dataPoints: Array(1...values.count), values: values, for: cell.barChartView)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func setChart(dataPoints: [Int], values: [Double], for chartView: BarChartView) {
        print("dataPoints --- \(dataPoints), values -- \(values) , chartView -- \(chartView)")
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "week")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartDataSet.colors = [#colorLiteral(red: 0.9019607843, green: 0.6196078431, blue: 0.4705882353, alpha: 1)]
        chartView.data = chartData
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let key = activitiesArry[indexPath.row]
        if let values = data[key] {
            stepsDataEntries = values // Update stepsDataEntries with selected values
            setPopupReadingToday(titleActivity: activitiesArry[indexPath.row], countActivity: activitiesCountArry[indexPath.row])
        }
    }

}
