//
//  FeedCell.swift
//  PhotoShare
//
//  Created by Enes Talha Uçar  on 4.11.2023.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var noteTextField: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
