//
//  CardCollectionViewCell.swift
//  Care4Senior
//
//  Created by Aneesha on 21/02/24.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCard: UIImageView!
    @IBOutlet weak var CardView: UIView!
    
    override var isSelected: Bool {
        didSet {
            // Check if the cell is selected and hide/show the image accordingly
            imageCard.isHidden = !isSelected
        }
    }
}
