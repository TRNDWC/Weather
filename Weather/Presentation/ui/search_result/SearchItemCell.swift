//
//  SearchItemCell.swift
//  Weather
//
//  Created by Trần Đức on 12/8/24.
//

import UIKit

class SearchItemCell: UITableViewCell {
    
    static let identifier = "SearchItemCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchItemCell", bundle: nil)
    }
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var mContentView: UIView!
    
    func setUp ( _ weather: WeatherModel){
        locationLabel.text = weather.location.name
        tempLabel.text = String(weather.current.currentWeather.temperature2m)+"°"
        let weatherCode = ItemWeatherStatus(rawValue: Int(weather.current.currentWeather.weatherCode))
        let title = weatherCode!.description
        let imageName = weatherCode!.imageName
        statusImage.image = UIImage(named: imageName)
        statusLabel.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mContentView.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
