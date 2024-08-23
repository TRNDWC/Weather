//
//  ForcastTableViewCell.swift
//  Weather
//
//  Created by Trần Đức on 7/8/24.
//

import UIKit

class ForcastTableViewCell: UITableViewCell {

    static let identifier = "ForcastTableViewCell"

    static func nib() -> UINib {
      return UINib(nibName: "ForcastTableViewCell", bundle: nil)
    }

    public func configure() {
        dateLabel.text = "Sun"
        statusImg.image = UIImage(named: "splash_image")
        statusLabel.text = "rain"
        tempLabel.text = "24/24"
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
