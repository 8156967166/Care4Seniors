////
////  FSCAlenderViewController.swift
////  Care4Senior
////
////  Created by Aneesha on 15/02/24.
////
//
//
//import UIKit
//import Charts
//
//class ViewController: UIViewController {
//
//    @IBOutlet var stepsChartView: BarChartView!
//    @IBOutlet var heartPointsChartView: BarChartView!
//    @IBOutlet var energyExpandedChartView: BarChartView!
//    @IBOutlet var distanceChartView: BarChartView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Setup chart views
//        setupChartView(stepsChartView)
//        setupChartView(heartPointsChartView)
//        setupChartView(energyExpandedChartView)
//        setupChartView(distanceChartView)
//
//        // Populate chart data
//        let data = getData()
//
//        // Update chart data
//        updateChartData(on: stepsChartView, data: data["Steps"]!, label: "Steps")
//        updateChartData(on: heartPointsChartView, data: data["Heart Points"]!, label: "Heart Points")
//        updateChartData(on: energyExpandedChartView, data: data["Energy Expanded"]!, label: "Energy Expanded")
//        updateChartData(on: distanceChartView, data: data["Distance"]!, label: "Distance")
//    }
//
//    func setupChartView(_ chartView: BarChartView) {
//        chartView.noDataText = "No data available"
//        chartView.legend.enabled = false
//        chartView.rightAxis.enabled = false
//        chartView.xAxis.labelPosition = .bottom
//        chartView.xAxis.drawGridLinesEnabled = false
//        chartView.animate(xAxisDuration: 1.5)
//    }
//
//    func updateChartData(on chartView: BarChartView, data: [Double], label: String) {
//        var dataEntries: [BarChartDataEntry] = []
//        for i in 0..<data.count {
//            let dataEntry = BarChartDataEntry(x: Double(i), y: data[i])
//            dataEntries.append(dataEntry)
//        }
//
//        let chartDataSet = BarChartDataSet(entries: dataEntries, label: label)
//        let chartData = BarChartData(dataSet: chartDataSet)
//
//        chartView.data = chartData
//    }
//
//    func getData() -> [String: [Double]] {
//        return [
//            "Steps": [20.0, 30.0, 25.0, 35.0, 28.0, 40.0, 45.0],
//            "Heart Points": [10.0, 30.0, 50.9, 60.7, 49.7, 20.1, 36.2],
//            "Energy Expanded": [10.9, 75.9, 95.8, 76.4, 39.9, 74.6, 49.5],
//            "Distance": [56.8, 45.8, 67.4, 68.9, 23.5, 78.9, 45.67]
//        ]
//    }
//}
//
//
//class ExerciseTableViewCell: UITableViewCell {
//    @IBOutlet weak var barChartView: BarChartView!
//}
//
//class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//    @IBOutlet weak var tableView: UITableView!
//    
//    let data: [String: [Double]] = [
//        "Steps": [20.0, 30.0, 25.0, 35.0, 28.0, 40.0, 45.0],
//        "Heart Points": [10.0, 30.0, 50.9, 60.7, 49.7, 20.1, 36.2],
//        "Energy Expanded": [10.9, 75.9, 95.8, 76.4, 39.9, 74.6, 49.5],
//        "Distance": [56.8, 45.8, 67.4, 68.9, 23.5, 78.9, 45.67]
//    ]
//    
//    let keys = ["Steps", "Heart Points", "Energy Expanded", "Distance"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return keys.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseTableViewCell
//        
//        let key = keys[indexPath.row]
//        if let values = data[key] {
//            setChart(dataPoints: Array(1...values.count), values: values, for: cell.barChartView)
//        }
//        
//        return cell
//    }
//    
//    func setChart(dataPoints: [Int], values: [Double], for chartView: BarChartView) {
//        var dataEntries: [BarChartDataEntry] = []
//        
//        for i in 0..<dataPoints.count {
//            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
//            dataEntries.append(dataEntry)
//        }
//        
//        let chartDataSet = BarChartDataSet(entries: dataEntries, label: nil)
//        let chartData = BarChartData(dataSet: chartDataSet)
//        chartView.data = chartData
//    }
//}
