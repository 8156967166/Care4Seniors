//
//  QuizTableViewCell.swift
//  Care4Senior
//
//  Created by Aneesha on 19/02/24.
//

import UIKit

protocol DataPassFromQuizTableCellToVc {
    func DataPass()
}

class QuizTableViewCell: UITableViewCell {

    @IBOutlet weak var clloctnView: UICollectionView!
    
    var delegate: DataPassFromQuizTableCellToVc?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clloctnView.delegate = self
        clloctnView.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension QuizTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizCollectionViewCell", for: indexPath) as! QuizCollectionViewCell
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.DataPass()
    }
    
}
