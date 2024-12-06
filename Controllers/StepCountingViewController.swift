
import UIKit
import Charts
import FSCalendar

class StepCountingViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var bottomBarDay: UIView!
    @IBOutlet weak var bottomBarWeek: UIView!
    @IBOutlet weak var bottombarMonth: UIView!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var fsCalender: FSCalendar?
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var buttonPrevious: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblWeek: UILabel!
    @IBOutlet weak var lblMyActvty: UILabel!
    
    //MARK: - Variables
    var strLocal = String()
    let days = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"]
    let dataEntries = [20.0, 30.0, 25.0, 35.0, 28.0, 40.0, 45.0]
    let time = ["12 am", "4 am", "8 am", "12 pm", "4 pm", "8 pm", "12 am"]
    let dataTimeEntries = [0.0, 0.0, 400.0, 200.0, 580.0, 347.0, 150.0]
    let month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let dataMonthEntries = [40.0, 30.5, 80.0, 50.0, 28.0, 100.0, 55.0, 39.0, 48.0, 66.0, 98.0, 76.0]
    var isSelectMonth = Bool()
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDay.text = "CGB-e6-EJa.text".localizableString(loc: strLocal)
        lblWeek.text = "32X-PP-0TC.text".localizableString(loc: strLocal)
        lblMonth.text = "EYE-g5-rfk.text".localizableString(loc: strLocal)
        lblMyActvty.text = "7tM-0O-uBO.text".localizableString(loc: strLocal)
        
        setCheckCurrentYearGreaterOrNot()
        fsCalender?.isHidden = true
        setDay()
        disableAllColor()
        bottomBarDay.backgroundColor = .black
        fsCalender?.delegate = self
        fsCalender?.dataSource = self
        setupBarChartForDay()
        setChartDataForDay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy" // Change the format as needed
        if dateLabel?.text == dateFormatter.string(from: Date()) {
            buttonNext.isEnabled = false
        }
    }
    
    //MARK: - Days
    
    func setDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy" // Change the format as needed
        dateLabel?.text = dateFormatter.string(from: Date())
        buttonNext.isEnabled = false
    }
    
    func setupBarChartForDay() {
        // Customize bar chart appearance
        barChartView.xAxis.labelPosition = .bottom
        
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: time)
        barChartView.xAxis.granularity = 1
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func setChartDataForDay() {
        var entries: [BarChartDataEntry] = []
        
        for i in 0..<dataTimeEntries.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: dataTimeEntries[i])
            entries.append(dataEntry)
        }
        
        let dataSet = BarChartDataSet(entries: entries, label: "Day")
        dataSet.colors = [#colorLiteral(red: 0.9019607843, green: 0.6196078431, blue: 0.4705882353, alpha: 1)]
        let data = BarChartData(dataSet: dataSet)
        
        barChartView.data = data
    }
    
    func setDateUpdate(number: Int) {
        // Assuming dateLabel is a UILabel or some similar UI component
        // Make sure dateLabel.text contains a valid date string in "MMM dd, yyyy" format
        if let dateString = dateLabel?.text {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            if let updateDate = dateFormatter.date(from: dateString) {
                let currentDate = Date()
                // Disable the button if the current date is greater than or equal to the lower date
                let nextDate = Calendar.current.date(byAdding: .day, value: number, to: updateDate)!
                // Set the label text to the formatted next date
                dateLabel?.text = dateFormatter.string(from: nextDate)
            } else {
                // Handle case where dateLabel.text is not in the expected format
                print("Invalid date format")
            }
        } else {
            // Handle case where dateLabel.text is nil
            print("Date label text is nil")
        }
    }
    
    func setCheckCurrentDateGreaterOrNot() {
        let currentDate = Date()
        
        if let dateString = dateLabel?.text {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            if let updateDate = dateFormatter.date(from: dateString) {
                // Reduce one day from the updateDate
                let updatedDate = Calendar.current.date(byAdding: .day, value: 1, to: updateDate)!
                
                if currentDate > updatedDate {
                    buttonNext.isEnabled = true
                } else {
                    buttonNext.isEnabled = false
                }
            }
        }
    }
    
    //MARK: - Week
    
    func SetOneWeekCalender() {
        // Configure the appearance
        fsCalender?.appearance.headerMinimumDissolvedAlpha = 0
        fsCalender?.appearance.headerDateFormat = "MMMM yyyy"
        fsCalender?.scope = .week // Set calendar scope to week
        setupBarChartForWeek()
        setChartDataForWeek()
    }
    
    func setupBarChartForWeek() {
        // Customize bar chart appearance
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        barChartView.xAxis.granularity = 1
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func setChartDataForWeek() {
        var entries: [BarChartDataEntry] = []
        for i in 0..<dataEntries.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: dataEntries[i])
            entries.append(dataEntry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "week")
        dataSet.colors = [#colorLiteral(red: 0.9019607843, green: 0.6196078431, blue: 0.4705882353, alpha: 1)]
        let data = BarChartData(dataSet: dataSet)
        
        barChartView.data = data
    }
    
    //MARK: - Month
    
    func setMonthGraph() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" // Change the format as needed
        dateLabel?.text = dateFormatter.string(from: Date())
        setupBarChartForMonth()
        setChartDataForMonth()
    }
    
    func setupBarChartForMonth() {
        // Customize bar chart appearance
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: month)
        barChartView.xAxis.granularity = 1
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    func setChartDataForMonth() {
        var entries: [BarChartDataEntry] = []
        for i in 0..<dataMonthEntries.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: dataMonthEntries[i])
            entries.append(dataEntry)
        }
        let dataSet = BarChartDataSet(entries: entries, label: "months")
        dataSet.colors = [#colorLiteral(red: 0.9019607843, green: 0.6196078431, blue: 0.4705882353, alpha: 1)]
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
    }
    
    func setYearUpdate(number: Int) {
        if let dateString = dateLabel?.text {
            // Create a date formatter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            if let currentDate = dateFormatter.date(from: dateString) {
                // Create a calendar object
                let calendar = Calendar.current
                // Get the next year from the current date
                if let nextYear = calendar.date(byAdding: .year, value: number, to: currentDate) {
                    // Format the next year
                    let formattedYear = dateFormatter.string(from: nextYear)
                    // Set the label text to the formatted next year
                    dateLabel?.text = formattedYear
                }
            }else {
                print("Invalid date format")
            }
        }else {
            print("Date label text is nil")
        }
    }
   
    func setCheckCurrentYearGreaterOrNot() {
        let currentDate = Date()
        if let dateString = dateLabel?.text {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            if let updateDate = dateFormatter.date(from: dateString) {
                let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: updateDate)!
                if currentDate > nextYear {
                    buttonNext.isEnabled = true
                } else {
                    buttonNext.isEnabled = false
                }
            }
        }
    }
   
    func disableAllColor() {
        bottomBarDay.backgroundColor = .clear
        bottombarMonth.backgroundColor = .clear
        bottomBarWeek.backgroundColor = .clear
    }
    
    //MARK: - ButtonAction
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonSelectDayWeekMonth(_ sender: UIButton) {
        if sender.tag == 1 {
            isSelectMonth = false
            setDay()
            DateView.isHidden = false
            fsCalender?.isHidden = true
            disableAllColor()
            bottomBarDay.backgroundColor = .black
            setChartDataForDay()
            setupBarChartForDay()
        }else if sender.tag == 2 {
            DateView.isHidden = true
            fsCalender?.isHidden = false
            disableAllColor()
            bottomBarWeek.backgroundColor = .black
            SetOneWeekCalender()
        }else {
            isSelectMonth = true
            setMonthGraph()
            DateView.isHidden = false
            fsCalender?.isHidden = true
            disableAllColor()
            bottombarMonth.backgroundColor = .black
        }
    }
    
    @IBAction func nextDate(_ sender: UIButton) {
        if sender.tag == 1 {
            if isSelectMonth == true {
                setYearUpdate(number: 1)
                setCheckCurrentYearGreaterOrNot()
            }else {
                setDateUpdate(number: 1)
                setCheckCurrentDateGreaterOrNot()
            }
        }else {
            if isSelectMonth == true {
                setYearUpdate(number: -1)
                setCheckCurrentYearGreaterOrNot()
            }else {
                setDateUpdate(number: -1)
                setCheckCurrentDateGreaterOrNot()
            }
        }
    }
}

extension StepCountingViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.fs_height = bounds.height + 30
        self.view.layoutIfNeeded()
    }
    
    // MARK: - FSCalendarDelegate
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // Handle date selection
    }
}
