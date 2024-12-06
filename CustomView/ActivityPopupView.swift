//
//  ActivityPopupView.swift
//  Care4Senior
//
//  Created by Aneesha on 16/02/24.
//

import Foundation
import Charts

class ActivityPopupView: UIView {
    
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblLastDay: UILabel!
    @IBOutlet weak var lblCountOfActvitiy: UILabel!
    @IBOutlet weak var lblTitileForActivity: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var buttonClose: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetuP(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ActivityPopupView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }
    
    func xibSetuP(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }
}
