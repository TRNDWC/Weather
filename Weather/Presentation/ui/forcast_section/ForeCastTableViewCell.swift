//
//  ForeCastTableViewCell.swift
//  Weather
//
//  Created by Trần Đức on 7/8/24.
//

import UIKit

class ForeCastTableViewCell: UITableViewCell {
    
    static let identifier = "ForeCastTableViewCell"

    static func nib() -> UINib {
      return UINib(nibName: "ForeCastTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("ForeCastTableViewCell",self.bounds.width, self.bounds.height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
