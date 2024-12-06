//
//  BasicMemoryGameViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 21/02/24.
//

import UIKit
import Foundation

class BasicMemoryGameViewController: UIViewController {

    @IBOutlet weak var viewCorner: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewCorner.roundCorners(corners: [.topLeft], radius: 50.0)
    }
    
    @IBAction func buttonStart(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
