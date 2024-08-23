//
//  ByTimeTableCell.swift
//  Weather
//
//  Created by Trần Đức on 9/8/24.
//

import UIKit

class ByTimeTableCell: UITableViewCell {
    
    @IBOutlet weak var byTimeView: ByTimeView!
    
    static let identifier = "ByTimeTableCell"
    static func nib() -> UINib {
      return UINib(nibName: "ByTimeTableCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
