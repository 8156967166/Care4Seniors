//
//  QuitAlertPopup.swift
//  Care4Senior
//
//  Created by Aneesha on 21/02/24.
//

import Foundation
import UIKit

class QuitAlertPopup: UIView {
    
    @IBOutlet weak var buttonQuit: UIButton!
    @IBOutlet weak var buttonNo: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetuP(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "QuitAlertPopup", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }
    
    func xibSetuP(frame: CGRect) {
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }
}

