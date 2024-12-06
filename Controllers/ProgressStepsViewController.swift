//
//  ProgressStepsViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 08/02/24.
//

import UIKit

class ProgressStepsViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var bottomBarDay: UIView!
    @IBOutlet weak var bottomBarWeek: UIView!
    @IBOutlet weak var bottombarMonth: UIView!
    @IBOutlet weak var ContainerViewDay: UIView!
    @IBOutlet weak var containerViewWeek: UIView!
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomBarDay.backgroundColor = .black
    }
    
    //MARK: - ButtonAction
    
    @IBAction func buttonSelectDayWeekMonth(_ sender: UIButton) {
        if sender.tag == 1 {
            disableAllColor()
            bottomBarDay.backgroundColor = .black
        }else if sender.tag == 2 {
            disableAllColor()
            bottomBarWeek.backgroundColor = .black
        }else {
            disableAllColor()
            bottombarMonth.backgroundColor = .black
        }
    }
    
    func disableAllColor() {
        bottomBarDay.backgroundColor = .clear
        bottombarMonth.backgroundColor = .black
        bottomBarWeek.backgroundColor = .black
    }
}
