//
//  WeatherCardTableViewCell.swift
//  Weather
//
//  Created by Trần Đức on 7/8/24.
//

import UIKit

class WeatherCardTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherCardView: WeatherCardView!
    static let identifier = "WeatherCardTableViewCell"

    static func nib() -> UINib {
      return UINib(nibName: "WeatherCardTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

