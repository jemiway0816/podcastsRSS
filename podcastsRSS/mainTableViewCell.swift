//
//  mainTableViewCell.swift
//  podcastsRSS
//
//  Created by CHUN-CHIEH LU on 2022/10/16.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
