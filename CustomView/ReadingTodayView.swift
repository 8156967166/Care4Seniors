//
//  ReadingTodayView.swift
//  Care4Senior
//
//  Created by Aneesha on 14/02/24.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import FSCalendar

class ReadingTodayView: UIView {
    
    @IBOutlet weak var lblBloodPrsure: UILabel!
    @IBOutlet weak var lblSave: UILabel!
    @IBOutlet weak var lblReadingTdy: UILabel!
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var textFieldDiastolic: MDCOutlinedTextField!
    @IBOutlet weak var textFieldSystolic: MDCOutlinedTextField!
    @IBOutlet weak var textFieldBloodGlucoseLevel: MDCOutlinedTextField!
    @IBOutlet weak var textFieldDateTime: MDCOutlinedTextField!
    @IBOutlet weak var buttonCalender: UIButton!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var popupView: UIView!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetuP(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ReadingTodayView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }
    
    func xibSetuP(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }
}
