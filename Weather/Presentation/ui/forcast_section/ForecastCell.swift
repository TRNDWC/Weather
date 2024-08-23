//
//  ForecastCell.swift
//  Weather
//
//  Created by Trần Đức on 10/8/24.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    static let identifier = "ForecastCell"

    static func nib() -> UINib {
      return UINib(nibName: "ForecastCell", bundle: nil)
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func config(weather: WeatherModel, row: Int){
        
        let weatherCode = ItemWeatherStatus(rawValue: Int(weather.daily.daily.weatherCode[row]))
        let date = weather.daily.daily.time[row]
        let image = weatherCode?.imageName ?? ""
        let rain = String(format: "%.1f",weather.daily.daily.rainSum[row]) + "% rain"
        let temp = String(format: "%.1f",weather.daily.daily.temperature2mMin[row])+"°/"+String(format: "%.1f",weather.daily.daily.temperature2mMax[row])+"°"

        
        dateLabel.text = date
        statusImage.image = UIImage(named: image)
        rainLabel.text = rain
        tempLabel.text = temp
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(red: 0.17, green: 0.47, blue: 0.76, alpha: 1.00)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
