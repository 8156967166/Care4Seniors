//
//  QuizViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 19/02/24.
//

import UIKit

class QuizViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewCorner: UIView!
    
    //MARK: - Variables
    
    var strLocal = String()
    
    //MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewCorner.roundCorners(corners: [.topLeft], radius: 50.0)
    }
    
    @IBAction func buttonActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath) as! QuizTableViewCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    
}

extension QuizViewController: DataPassFromQuizTableCellToVc {
    func DataPass() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectedQuizViewController") as! SelectedQuizViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
