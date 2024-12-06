//
//  ExerciseListTableViewCell.swift
//  Care4Senior
//
//  Created by Aneesha on 20/02/24.
//

import UIKit

class VideoListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleOfVideo: UILabel!
    @IBOutlet weak var imgOfVideo: UIImageView!
    @IBOutlet weak var lblDateOfVideo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
