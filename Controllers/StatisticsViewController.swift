//
//  StatisticsViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 21/02/24.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var lblGamePoints: UILabel!
    @IBOutlet weak var lblVideoPoints: UILabel!
    @IBOutlet weak var lblQuizPoints: UILabel!
    
    var strLocl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblGamePoints.text = "RmV-Y4-Ypc.text".localizableString(loc: strLocl)
        lblVideoPoints.text = "Dtb-oa-xCD.text".localizableString(loc: strLocl)
        lblQuizPoints.text = "0oX-sO-RC9.text".localizableString(loc: strLocl)
    }

    @IBAction func buttonPhysicalActy(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhysicalActivitiesViewController") as! PhysicalActivitiesViewController
        vc.strLocl = strLocl
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buttonActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
