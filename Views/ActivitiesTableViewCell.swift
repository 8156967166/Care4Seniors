//
//  ActivitiesTableViewCell.swift
//  Care4Senior
//
//  Created by Aneesha on 15/02/24.
//

import UIKit
import Charts

class ActivitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var lblCountActivities: UILabel!
    @IBOutlet weak var lblTitleOfActivities: UILabel!
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblLast7Days: UILabel!
    
    let steps = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    let stepsDataEntries = [20.0, 30.0, 25.0, 35.0, 28.0, 40.0, 45.0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupBarChartForWeek()
//        setChartDataForWeek()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//
//    func setupBarChartForWeek() {
//        // Customize bar chart appearance
//        barChartView.xAxis.labelPosition = .bottom
//        barChartView.xAxis.drawGridLinesEnabled = false
//        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: steps)
//        barChartView.xAxis.granularity = 1
//        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
//    }
    
    func setChartDataForWeek() {
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
    
    func setupBarChartForWeek() {
        // Customize bar chart appearance
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: steps)
        barChartView.xAxis.granularity = 1
        
        // Hide left and right axis lines and labels
        barChartView.leftAxis.enabled = false
        barChartView.rightAxis.enabled = false
        
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }

    
}
